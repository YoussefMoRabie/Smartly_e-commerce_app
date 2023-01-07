import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:smartly/controller/auth/signup_contoller.dart';
import '../../../core/constants/color.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/shared/custom_button.dart';
import '../../widget/auth/custom_text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp controller=Get.put(SignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,),

        ),
        title: Text('18'.tr,style:Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20) ,),
      ),
      body: Form(
        key: controller.formState,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal:35),
          child: ListView(
            children:  [
              const SizedBox(height: 30,),
               Text(
                  '26'.tr,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15,),
              Text(
                '28'.tr,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  wordSpacing: 1,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              AuthTextField(
                  controller: controller.fName,
                  valid: (val){
                    return validInput(val!, 5, 100, "29".tr);
                  },

                  labelText: '29'.tr,
                  sufIcon: Icons.person_outline,
                  hintText: '31'.tr
              ),
              const SizedBox(height: 20,),
               AuthTextField(
                 controller: controller.lName,
                  valid: (val){
                    return validInput(val!, 5, 100, "30".tr);
                  },

                  labelText: '30'.tr,
                  sufIcon: Icons.person_outline,
                  hintText: '32'.tr
              ),
              const SizedBox(height: 20,),
               AuthTextField(
                   controller: controller.email,
                   valid: (val){
                     return validInput(val!, 5, 100, "email");
                   },
                  labelText: 'Email',
                  sufIcon: Icons.email_outlined,
                  hintText: 'Enter your email'
              ),
              const SizedBox(height: 20,),
              AuthTextField(
                  controller: controller.address,
                  valid: (val){
                    return validInput(val!, 5, 100, "Address");
                  },
                  labelText: 'Address',
                  sufIcon: Icons.location_on_outlined,
                  hintText: 'Enter your address'
              ),
              const SizedBox(height: 20,),
               AuthTextField(
                   controller: controller.phone,
                   valid: (val){
                    return validInput(val!, 5, 100, "phone");
                  },
                  labelText: 'Phone',
                  sufIcon: Icons.phone_outlined,
                  hintText: 'Enter your phone'
              ),
              const SizedBox(height: 20,),
               AuthTextField(
                   controller: controller.password,
                   valid: (val){
                     return validInput(val!, 5, 100, "14".tr);
                   },
                  labelText: '14'.tr,
                  sufIcon: Icons.lock_outline_rounded,
                  hintText: '15'.tr
              ),
              const SizedBox(height: 50,),
              customButton(onPressed: () {
                controller.signUp();
              }, text: '18'.tr),
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


            ],
          ),
        ),
      ),

    );
  }
}
