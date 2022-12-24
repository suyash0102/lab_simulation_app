import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/services/helper.dart';
import 'package:lab_simulation_app/ui/auth/authentication_bloc.dart';
import 'package:lab_simulation_app/ui/auth/onBoarding/on_boarding_cubit.dart';
import 'package:lab_simulation_app/ui/auth/welcome/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  final List<dynamic> images;
  final List<String> titles, subtitles;

  const OnBoardingScreen(
      {Key? key,
        required this.images,
        required this.titles,
        required this.subtitles})
      : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<OnBoardingCubit, OnBoardingInitial>(
          builder: (context, state) {
            return Stack(
              children: [
                PageView.builder(
                  itemBuilder: (context, index) => OnBoardingPage(
                    image: widget.images[index],
                    title: widget.titles[index],
                    subtitle: widget.subtitles[index],
                  ),
                  controller: pageController,
                  itemCount: widget.titles.length,
                  onPageChanged: (int index) {
                    context.read<OnBoardingCubit>().onPageChanged(index);
                  },
                ),
                Visibility(
                  visible: state.currentPageCount + 1 == widget.titles.length,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Directionality.of(context) == TextDirection.ltr
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      child:
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state.authState == AuthState.unauthenticated) {
                            pushAndRemoveUntil(
                                context, const WelcomeScreen(), false);
                          }
                        },
                        child: OutlinedButton(
                          onPressed: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(FinishedOnBoardingEvent());
                          },
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: kPrimaryColor),
                              shape: const StadiumBorder()),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontFamily: "Poppins",
                                fontSize: size.width*0.04,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:size.height*0.12 ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: widget.titles.length,
                      effect: ScrollingDotsEffect(
                          activeDotColor: kPrimaryColor,
                          dotColor: Colors.grey.shade400,
                          dotWidth: 10,
                          dotHeight: 10,
                          fixedCenter: true),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  final dynamic image;
  final String title, subtitle;

  const OnBoardingPage(
      {Key? key, this.image, required this.title, required this.subtitle})
      : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Image.asset(
          widget.image,
          width:size.width*0.8,
          height: size.height*0.4,
          // fit: BoxFit.cover,
        ),
        SizedBox(height: size.height*0.01),
        Text(
          widget.title.toUpperCase(),
          style: TextStyle(fontSize: size.width*0.1,color: Colors.black,fontFamily: "Hubballi",fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.all(size.width*0.03),
          child: Text(
            widget.subtitle,
            style: TextStyle(color: Colors.black, fontSize: size.width*0.04,fontWeight: FontWeight.w400,fontFamily: "Poppins"),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
