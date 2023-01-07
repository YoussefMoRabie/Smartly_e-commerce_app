import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/setting_controller.dart';
import '../../core/constants/color.dart';
import '../../core/localization/changeLang.dart';

class Setting extends GetView<LocaleController> {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text("59".tr, style: Theme.of(context).textTheme.headline1),
              const SizedBox(height: 20),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: AppColor.primaryColor,
                  height:40 ,
                  onPressed: () {
                controller.changeLang("ar");
              },
                  child: const Text(
                    "AR",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: AppColor.primaryColor,
                  height:40 ,
                  onPressed: () {
                controller.changeLang("en");
              },
                  child: const Text(
                    "EN",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),


              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("60".tr,style: Theme.of(context).textTheme.headline1),
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: AppColor.primaryColor,
                          height:40 ,
                          onPressed: () {
                            SettingControllerImp settingController= Get.put(SettingControllerImp());
                            settingController.logOut();
                      },
                          child: const Text(
                            "LOGOUT",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),


                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
