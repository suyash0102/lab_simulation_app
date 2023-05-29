import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/ui/viva_voice_module/screens/final_screen.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data' show Uint8List;
import 'package:audio_session/audio_session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

///
const int tSAMPLERATE = 8000;

/// Sample rate used for Streams
const int tSTREAMSAMPLERATE = 44000; // 44100 does not work for recorder on iOS

///
const int tBLOCKSIZE = 4096;

enum Media {
  file,
}

enum AudioState {
  isPlaying,
  isPaused,
  isStopped,
  isRecording,
  isRecordingPaused,
}

class QuestionSecondScreen extends StatefulWidget {
  final String title;
  final String quizTitle;
  final String answer1;

  const QuestionSecondScreen({super.key, required this.title, required this.quizTitle, required this.answer1});

  @override
  State<QuestionSecondScreen> createState() => _QuestionSecondScreenState();
}

class _QuestionSecondScreenState extends State<QuestionSecondScreen> {
  bool _isRecording = false;
  bool starRecording = true;
  bool startPlayer01 = true;
  late String _filePath;
  late bool _isUploading;

  final List<String?> _path = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];

  StreamSubscription? _recorderSubscription;

  StreamSubscription? _playerSubscription;

  StreamSubscription? _recordingDataSubscription;

  FlutterSoundPlayer playerModule = FlutterSoundPlayer();

  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();

  String _recorderTxt = '00:00:00';

  String _playerTxt = '00:00';

  double? _dbLevel;

  double sliderCurrentPosition = 0.0;

  double maxDuration = 1.0;

  Media? _media = Media.file;

  Codec _codec = Codec.aacMP4;

  bool? _encoderSupported = true;
  var path = '';

  // Optimist
  StreamController<Food>? recordingDataController;

  IOSink? sink;

  Future<void> _initializeExample() async {
    await playerModule.closePlayer();
    await playerModule.openPlayer();
    await playerModule.setSubscriptionDuration(Duration(milliseconds: 10));
    await recorderModule.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await recorderModule.openRecorder();

    if (!await recorderModule.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
    }
  }

  Future<void> init() async {
    await openTheRecorder();
    await _initializeExample();
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  @override
  void initState() {
    super.initState();
    init();
  }
  Future<void> _onFileUploadButtonPressed() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    setState(() {
      _isUploading = true;
    });
    try {
      await firebaseStorage
          .ref("VivaVoice/$userId")
          .child("Subject/LabName/answer2.mp4")
          .putFile(File(_filePath));
      await firebaseStorage
          .ref("VivaVoice/$userId")
          .child("Subject/LabName/answer1.mp4")
          .putFile(File(widget.answer1));
      // widget.onUploadComplete();
    } catch (error) {
      print('Error occured while uplaoding to Firebase ${error.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occured while uplaoding'),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }
  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  void cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription!.cancel();
      _playerSubscription = null;
    }
  }

  void cancelRecordingDataSubscription() {
    if (_recordingDataSubscription != null) {
      _recordingDataSubscription!.cancel();
      _recordingDataSubscription = null;
    }
    recordingDataController = null;
    if (sink != null) {
      sink!.close();
      sink = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelPlayerSubscriptions();
    cancelRecorderSubscriptions();
    cancelRecordingDataSubscription();
    // releaseFlauto();
  }

  // Future<void> releaseFlauto() async {
  void startRecorder() async {
    try {
      // Request Microphone permission if needed
      if (!kIsWeb) {
        var status = await Permission.microphone.request();
        if (status != PermissionStatus.granted) {
          throw RecordingPermissionException(
              'Microphone permission not granted');
        }
      }
      if (!kIsWeb) {
        var tempDir = await getTemporaryDirectory();
        path = '${tempDir.path}/answer2${ext[_codec.index]}';
        _filePath = path;

      } else {
        path = '_flutter_sound${ext[_codec.index]}';
        _filePath = path;

      }
      await recorderModule.startRecorder(
        toFile: path,
        codec: _codec,
        bitRate: 8000,
        numChannels: 1,
        sampleRate: (_codec == Codec.pcm16) ? tSTREAMSAMPLERATE : tSAMPLERATE,
      );

      recorderModule.logger.d('startRecorder');

      _recorderSubscription = recorderModule.onProgress!.listen((e) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
        var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

        setState(() {
          _recorderTxt = txt.substring(0, 8);
          _dbLevel = e.decibels;
        });
      });

      setState(() {
        _isRecording = true;
        _path[_codec.index] = path;
      });
    } on Exception catch (err) {
      recorderModule.logger.e('startRecorder error: $err');
      setState(() {
        stopRecorder();
        _isRecording = false;
        cancelRecordingDataSubscription();
        cancelRecorderSubscriptions();
      });
    }
  }

  void stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      recorderModule.logger.d('stopRecorder');
      cancelRecorderSubscriptions();
      cancelRecordingDataSubscription();
    } on Exception catch (err) {
      recorderModule.logger.d('stopRecorder error: $err');
    }
    setState(() {
      _isRecording = false;
    });
  }

  Future<bool> fileExists(String path) async {
    return await File(path).exists();
  }

  // In this simple example, we just load a file in memory.This is stupid but just for demonstration  of startPlayerFromBuffer()
  Future<Uint8List?> makeBuffer(String path) async {
    try {
      if (!await fileExists(path)) return null;
      var file = File(path);
      file.openRead();
      var contents = await file.readAsBytes();
      playerModule.logger.i('The file is ${contents.length} bytes long.');
      return contents;
    } on Exception catch (e) {
      playerModule.logger.e(e);
      return null;
    }
  }

  void _addListeners() {
    cancelPlayerSubscriptions();
    _playerSubscription = playerModule.onProgress!.listen((e) {
      maxDuration = e.duration.inMilliseconds.toDouble();
      if (maxDuration <= 0) maxDuration = 0.0;

      sliderCurrentPosition =
          min(e.position.inMilliseconds.toDouble(), maxDuration);
      if (sliderCurrentPosition < 0.0) {
        sliderCurrentPosition = 0.0;
      }

      var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _playerTxt = txt.substring(0, 5);
      });
    });
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    var myUri = Uri.parse(filePath);
    var audioFile = File.fromUri(myUri);
    Uint8List bytes;
    var b = await audioFile.readAsBytes();
    bytes = Uint8List.fromList(b);
    playerModule.logger.d('reading of bytes is completed');
    return bytes;
  }

  final int blockSize = 4096;

  Future<void> startPlayer() async {
    startPlayer01=false;
    try {
      Uint8List? dataBuffer;
      String? audioFilePath;
      var codec = _codec;
      if (kIsWeb || await fileExists(_path[codec.index]!)) {
        audioFilePath = _path[codec.index];
      }
      if (audioFilePath != null) {
        await playerModule.startPlayer(
            fromURI: audioFilePath,
            codec: codec,
            sampleRate: tSTREAMSAMPLERATE,
            whenFinished: () {
              startPlayer01=true;
              playerModule.logger.d('Play finished');
              setState(() {});
            });
      } else if (dataBuffer != null) {
        await playerModule.startPlayer(
            fromDataBuffer: dataBuffer,
            sampleRate: tSAMPLERATE,
            codec: codec,
            whenFinished: () {
              playerModule.logger.d('Play finished');
              setState(() {
              });
            });
      }
      _addListeners();
      setState(() {
        startPlayer01;
      });
      playerModule.logger.d('<--- startPlayer');
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
  }

  Future<void> stopPlayer() async {
    try {
      await playerModule.stopPlayer();
      playerModule.logger.d('stopPlayer');
      if (_playerSubscription != null) {
        await _playerSubscription!.cancel();
        _playerSubscription = null;
      }
      sliderCurrentPosition = 0.0;
    } on Exception catch (err) {
      playerModule.logger.d('error: $err');
    }
    setState(() {});
  }

  void pauseResumePlayer() async {
    try {
      if (playerModule.isPlaying) {
        await playerModule.pausePlayer();
      } else {
        await playerModule.resumePlayer();
      }
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
    setState(() {});
  }

  void pauseResumeRecorder() async {
    try {
      if (recorderModule.isPaused) {
        await recorderModule.resumeRecorder();
      } else {
        await recorderModule.pauseRecorder();
        assert(recorderModule.isPaused);
      }
    } on Exception catch (err) {
      recorderModule.logger.e('error: $err');
    }
    setState(() {});
  }

  Future<void> seekToPlayer(int milliSecs) async {
    //playerModule.logger.d('-->seekToPlayer');
    try {
      if (playerModule.isPlaying) {
        await playerModule.seekToPlayer(Duration(milliseconds: milliSecs));
      }
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
    setState(() {});
    //playerModule.logger.d('<--seekToPlayer');
  }

  void Function()? onPauseResumePlayerPressed() {
    if (playerModule.isPaused || playerModule.isPlaying) {
      return pauseResumePlayer;
    }
    return null;
  }

  void Function()? onPauseResumeRecorderPressed() {
    if (recorderModule.isPaused || recorderModule.isRecording) {
      return pauseResumeRecorder;
    }
    return null;
  }

  void Function()? onStopPlayerPressed() {
    return (playerModule.isPlaying || playerModule.isPaused)
        ? stopPlayer
        : null;
  }

  void startStopRecorder() {
    if (recorderModule.isRecording || recorderModule.isPaused) {
      stopRecorder();
      starRecording = true;
    } else {
      startRecorder();
      starRecording = false;
    }
  }

  void Function()? onStartRecorderPressed() {
    // Disable the button if the selected codec is not supported
    if (!_encoderSupported!) return null;
    return startStopRecorder;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget recorderSection = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.01, bottom: size.height * 0.01),
            child: Text(
              _recorderTxt,
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: Colors.black,
              ),
            ),
          ),
          _isRecording
              ? LinearProgressIndicator(
              value: 100.0 / 160.0 * (_dbLevel ?? 1) / 100,
              valueColor: AlwaysStoppedAnimation<Color>(kGreenColor),
              backgroundColor: kRedColor)
              : Container(),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: kGreyColor,
                          offset: Offset(1, 2),
                          blurRadius: 1,
                          spreadRadius: 2),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: TextButton(
                        onPressed: onStartRecorderPressed(),
                        //padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.mic,
                          color: starRecording == true
                              ? kPrimaryColor
                              : kRedColor,
                          size: size.width * 0.08,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ]);

    Widget playerSection = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width * 0.09,
              height: 50.0,
              child: ClipOval(
                child: TextButton(
                    onPressed: startPlayer,
                    //disabledColor: Colors.white,
                    //padding: EdgeInsets.all(8.0),
                    child: startPlayer01 == true
                        ? Icon(
                      Icons.play_arrow_rounded,
                      color: kPrimaryColor,
                      size: size.width * 0.08,
                    )
                        : Icon(
                      Icons.pause,
                      color: kPrimaryColor,
                      size: size.width * 0.08,
                    )),
              ),
            ),
            Slider(
              // focusNode: FocusNode(),
                activeColor: kPrimaryColor,
                inactiveColor: kGreyColor,
                value: min(sliderCurrentPosition, maxDuration),
                min: 0.0,
                max: maxDuration,
                onChanged: (value) async {
                  await seekToPlayer(value.toInt());
                },
                divisions: maxDuration == 0.0 ? 1 : maxDuration.toInt()),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
              right: size.width * 0.15, bottom: size.height * 0.01),
          child: Text(
            _playerTxt,
            style: TextStyle(
              fontSize: size.width * 0.03,
              fontFamily: "Poppins",
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentTextStyle: GoogleFonts.mulish(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('Opppsss'),
              content: const Text(
                'Sorry You Can\'t Go Back!',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: GestureDetector(child: Icon(Icons.close)),
          // automaticallyImplyLeading: true,
          toolbarHeight: size.height * 0.07,
          backgroundColor: kPrimaryColor,
          title: Text(widget.title,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: Colors.white,
                fontFamily: "Poppins",
              )),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Viva Voice',
                style: GoogleFonts.mulish(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.06,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.02),
                child: SizedBox(
                  width: size.width * 0.7,
                  height: size.height * 0.32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: size.height * 0.07,
                          child: Text(
                            'What is the significance of O.C. Test?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                        ),
                      ),
                      recorderSection,
                      playerSection,
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Center(
                        child: Text(
                          starRecording == true
                              ? 'Start Recording'
                              : 'Stop Recording',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.036,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.3),
              child: SizedBox(
                height: size.height * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FinalScreen(
                              title: widget.title, quizTitle: widget.quizTitle);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor, elevation: 0),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: size.width * 0.04),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.upload_file),
              onPressed: _onFileUploadButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}
