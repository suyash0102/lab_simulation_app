import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';

class CustomizedTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
 final dynamic keyboardType;


  const CustomizedTextFormField({Key? key, required this.hintText, required this.obscureText, required this.validator, this.onSaved, this.onFieldSubmitted, this.controller, required this.readOnly, this.keyboardType, this.onChanged}) : super(key: key);

  @override
  _CustomizedTextFormFieldState createState() => _CustomizedTextFormFieldState();
}

class _CustomizedTextFormFieldState extends State<CustomizedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      // textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.next,
      validator: widget.validator,
      // style: const TextStyle(fontSize: 18.0),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 12,fontFamily: "Poppins",),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kRedColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.blue,
          ),
        ),
        fillColor: Colors.white,
        border: InputBorder.none,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 16,color: Color(0xFF555555),fontFamily: "Poppins",),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kPrimaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
