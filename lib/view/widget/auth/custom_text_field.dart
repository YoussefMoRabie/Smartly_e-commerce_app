import 'package:flutter/material.dart';
import 'package:smartly/core/shared/styles/themes.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData  sufIcon;
  final TextEditingController controller;
  final String? Function(String?) valid;
  final bool ? hide;
  const AuthTextField({Key? key,this.hide,required this.labelText,required this.sufIcon, required this.hintText,required this.valid, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valid,
      controller: controller,
      style: Theme.of(context).textTheme.headline1?.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 14
      ),
      obscureText: (hide==null||hide==false)? false:true ,
      decoration:  InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: ThemeService().isSavedDarkMode()?Colors.white:Colors.black,
      ),
    ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 12,fontWeight: FontWeight.normal),
        // hintStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 25,vertical:15 ),
        suffixIcon: Icon(sufIcon,color: ThemeService().isSavedDarkMode()?Colors.white:Colors.black),
        labelStyle: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 18,fontWeight: FontWeight.normal),
        label:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(labelText),
        ),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
