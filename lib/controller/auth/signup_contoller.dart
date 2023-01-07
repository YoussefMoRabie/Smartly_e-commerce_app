
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';


abstract class SignUpController extends GetxController{
  signUp();
}
class SignUpControllerImp extends SignUpController{
  GlobalKey<FormState> formState=GlobalKey<FormState>();

  late TextEditingController fName;
  late TextEditingController lName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController address;
  late TextEditingController password;

  StatusRequest statusRequest = StatusRequest.none;

   @override
  void onInit() {
    fName = TextEditingController();
    lName = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  signUp() async {

    if(formState.currentState!.validate()) {
      update();
      }
    }




  @override
  void dispose() {
    fName.dispose();
    lName.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    password.dispose();
    super.dispose();
  }



}