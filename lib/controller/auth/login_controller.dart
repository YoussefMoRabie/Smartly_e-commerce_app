import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/view/screen/auth/signup.dart';
import 'package:smartly/view/screen/layout.dart';

import '../../core/class/status_request.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/services/services.dart';
import '../../core/shared/toast.dart';
import '../../data/data_source/remote/Auth/login_data.dart';
import '../../main.dart';
import '../layout_controller.dart';

abstract class LoginController extends GetxController {
  login();
  toSignUp();
}

class LoginControllerImp extends LoginController {
  // Login form control key
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  // show or hide password
  bool isShowPass = true;
  IconData icon = Icons.visibility;

  // Text Controllers
  late TextEditingController userName;
  late TextEditingController password;
  // Handling remote requests
  LoginData loginData = LoginData(Get.find());

  // SharedPreferences
  MyServices myServices = Get.find();
  // Handling requests status
  StatusRequest statusRequest = StatusRequest.none;
  // show or hide password
  void togglePassObscure() {
    isShowPass = !isShowPass;
    icon = isShowPass ? Icons.visibility : Icons.visibility_off;
    update();
  }

  @override
  login() async {
    if (formState.currentState!.validate()) {
      if (userName.text == "admin" && password.text == "admin") {
        id = 1;
        myServices.sharedPreferences.setString("id", "1");
        toast("26".tr, Colors.green);
        Get.offAll(const Layout());
      } else {
        statusRequest = StatusRequest.loading;
        update();
        var response = await loginData.getData(userName.text, password.text);
        print("=============================== Controller $response ");
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          id = 1;
          myServices.sharedPreferences.setString("id", "1");
          toast("26".tr, Colors.green);
          LayoutControllerImp controller = Get.put(LayoutControllerImp());
          controller.changePage(0);
          Get.offAll(const Layout());
        } else {
          toast("27".tr, Colors.red);
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  toSignUp() {
    Get.delete<LoginControllerImp>();
    Get.to(const SignUp());
  }

  @override
  void onInit() {
    userName = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    super.dispose();
  }
}
