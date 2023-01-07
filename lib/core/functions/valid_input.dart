import 'package:get/get.dart';

 validInput(String val, int min, int max, String type) {
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "19".tr;
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "20".tr;
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "21".tr;
    }
  }
  if(type=="Date"){
    if(!val.contains('/'))
      {
        return "22".tr;

      }
  }

  if (val.isEmpty) {
    return "23".tr;
  }

  if (val.length < min) {
    return "${"24".tr}$min";
  }

  if (val.length > max) {
    return "${"25".tr}$max";
  }
}