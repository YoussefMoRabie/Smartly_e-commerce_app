import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:smartly/controller/auth/login_controller.dart';
import 'package:smartly/core/functions/exit_alert.dart';
import 'package:smartly/core/functions/valid_input.dart';
import '../../../core/constants/color.dart';
import '../../../core/shared/custom_button.dart';
import '../../widget/auth/custom_text_field.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerImp loginController= Get.put(LoginControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: AppColor.lightBackGroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('9'.tr,style:Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20) ,),
      ),
      body: WillPopScope(onWillPop: exitAlert,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal:35),
        child: Form(
          key: loginController.formState,
          child: ListView(
            children:  [
              const SizedBox(height: 30,),
              Text(
                '10'.tr,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15,),
              Text(
                '11'.tr,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  wordSpacing: 1,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30,),
              AuthTextField(
                  controller: loginController.userName,

                  valid: (val){
                    return validInput(val!, 3, 100, "username");
                  },
                  labelText: '12'.tr,
                  sufIcon: Icons.person_outline,
                  hintText: '13'.tr
              ),
              const SizedBox(height: 30,),
              GetBuilder<LoginControllerImp>(builder: (controller)=>AuthTextField(
                controller: loginController.password,
                  valid: (val){
                    return validInput(val!, 4, 100, "password");
                  },
                  hide: loginController.isShowPass,
                  labelText: '14'.tr,
                  sufIcon: Icons.lock_outline_rounded,
                  hintText: '15'.tr
              )),
              const SizedBox(height: 30,),
              Row(
                children: [
                  GetBuilder<LoginControllerImp>(builder: (controller)=>IconButton(

                      onPressed: (){
                        loginController.togglePassObscure();
                      },
                      icon: Icon(loginController.icon)
                  )),
                  const Spacer(),
                  InkWell(
                    onTap: (){},
                    child: Text("16".tr,style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 14,
                        decoration:TextDecoration.underline
                    ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30,),
              customButton(onPressed: () {
                loginController.login();
              }, text: '9'.tr),
              const SizedBox(height: 30,),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterSocialButton(
                      onTap: () {},
                      mini: true,
                      buttonType: ButtonType.apple, // Button type for different type buttons
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterSocialButton(
                      onTap: () {},
                      mini: true,
                      buttonType: ButtonType.facebook, // Button type for different type buttons
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterSocialButton(
                      onTap: () {},
                      mini: true,

                      buttonType: ButtonType.twitter, // Button type for different type buttons
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text("17".tr,style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),),
                    InkWell(
                      onTap: (){
                        loginController.toSignUp();
                      },
                      child:  Text("18".tr,style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      ),
                    )
                  ],
                ),
              ),


            ],
          ),
        ),
      ),),

    );
  }
}
