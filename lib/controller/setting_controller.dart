import 'package:get/get.dart';

import '../core/services/services.dart';
import '../view/screen/auth/login.dart';

abstract class SettingController extends GetxController {
  void logOut();
}

class SettingControllerImp extends SettingController {
  MyServices myServices = Get.find();

  @override
  void logOut() {
    myServices.sharedPreferences.setString("id", "-1") ;

    Get.offAll(const Login());
  }

}