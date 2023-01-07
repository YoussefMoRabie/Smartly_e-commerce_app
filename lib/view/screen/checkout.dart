import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/controller/checkout_controller.dart';
import 'package:smartly/core/constants/color.dart';

import '../../core/functions/valid_input.dart';
import '../../core/shared/styles/themes.dart';
import '../widget/auth/custom_text_field.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});
  @override
  Widget build(BuildContext context) {
    CheckOutControllerImp coController=Get.put(CheckOutControllerImp());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();

          },
          icon: const Icon(Icons.arrow_back_ios_outlined,),

        ),
        title: const Text('Smartly'),

      ),
      body: GetBuilder<CheckOutControllerImp>(builder: (controller) {
        return ConditionalBuilder(
          condition: true ,//controller.items.isNotEmpty,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            "36".tr,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color:ThemeService().isSavedDarkMode()?Colors.grey.shade200: Colors.grey.shade700),
                          ),
                          Spacer(),
                          Text("COD",style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal
                          ),),
                          Radio(value: false, groupValue: controller.isCredit, onChanged: (val){
                            controller.changePayment(val!);
                          }),
                          Text("Credit",style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.normal
                          ),),
                          Radio(value: true, groupValue: controller.isCredit, onChanged: (val){
                            controller.changePayment(val!);
                          })
                        ],
                      )
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: coController.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(right: 10.0,left: 10, bottom: 10.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(5.0),
                                elevation: 3.0,
                                child: Container(
                                  color: ThemeService().isSavedDarkMode()?Colors.black:Colors.white,
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children:[
                                      Container(
                                        height: 80,
                                        child: Image(image:NetworkImage(controller.products[index]["image"]),),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                            "${controller.products[index]["title"]}  X ${controller.products[index]["count"]}",
                                              style: Theme.of(context).textTheme.headline1?.copyWith(
                                                fontSize: 16
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                              Text(
                                                "\$${controller.products[index]["price"]}",
                                                style: const TextStyle(
                                                    color: AppColor.primaryColor, fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                        itemCount: controller.items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              controller.changeSC(index);
                            },
                            child: Column(
                              children: [
                                Container(

                                  decoration: BoxDecoration(
                                      border:(controller.selectedSC== index)! ?const Border(
                                        bottom: BorderSide(width: 3,color: AppColor.primaryColor),
                                        top: BorderSide(width: 3,color: AppColor.primaryColor),
                                        left: BorderSide(width: 3,color: AppColor.primaryColor),
                                        right: BorderSide(width: 3,color: AppColor.primaryColor),
                                      ): null,
                                      color: ThemeService().isSavedDarkMode()?AppColor.darkBackGroundColor:AppColor.lightBackGroundColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 120,
                                  width: 200,
                                  child: Column(

                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Text("${controller.items[index]["sc_name"]}",style: TextStyle(color: AppColor.primaryColor,fontWeight: FontWeight.bold,fontSize: 22),),
                                      Text("${"50".tr} : ${controller.items[index]["delivery_time"]} ${"51".tr}",style: Theme.of(context).textTheme.headline1,),
                                      Text("${controller.items[index]["cost"]}\$",style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 15),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "47".tr,
                                style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                              Text(
                                "\$${controller.total}",
                                style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "48".tr,
                                style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                              Text(
                                "\$${controller.items[controller.selectedSC]["cost"]}",
                                style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "${"49".tr}     \$${(controller.items[controller.selectedSC]["cost"]+controller.total).toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.headline1
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child:MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: AppColor.primaryColor,
                              height:40 ,
                              onPressed: () {
                                showBottomSheet(context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return GetBuilder<CheckOutControllerImp>(builder: (controller) {
                                      return Container(
                                        decoration:  BoxDecoration(
                                            color: ThemeService().isSavedDarkMode()?Colors.black:Colors.white,
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20)
                                            ) ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            key: controller.formState,
                                            child: ListView(
                                              children: [
                                                Text("61".tr,style: Theme.of(context).textTheme.headline1,),
                                                const SizedBox(height: 30,),
                                                AuthTextField(
                                                    controller: controller.address,

                                                    valid: (val){
                                                      return validInput(val!, 3, 100, "address");
                                                    },
                                                    labelText: '61'.tr,
                                                    sufIcon: Icons.maps_home_work_outlined,
                                                    hintText: ""
                                                ),
                                                const SizedBox(height: 30,),
                                                AuthTextField(
                                                    controller: controller.country,

                                                    valid: (val){
                                                      return validInput(val!, 3, 100, "");
                                                    },
                                                    labelText: '63'.tr,
                                                    sufIcon: Icons.location_pin,
                                                    hintText: ""
                                                ),
                                                const SizedBox(height: 30,),
                                                AuthTextField(
                                                    controller: controller.city,

                                                    valid: (val){
                                                      return validInput(val!, 3, 100, "");
                                                    },
                                                    labelText: '64'.tr,
                                                    sufIcon: Icons.map,
                                                    hintText: ""
                                                ),
                                                const SizedBox(height: 30,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: AuthTextField(
                                                          controller: controller.zip,
                                                          valid: (val){
                                                            return validInput(val!, 3, 100, "zip");
                                                          },
                                                          labelText: '62'.tr,
                                                          sufIcon: Icons.qr_code_2,
                                                          hintText: ""
                                                      ),
                                                    ),
                                                    const Expanded(
                                                      child: SizedBox(),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30,),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: MaterialButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10)),
                                                      color: AppColor.primaryColor,
                                                      height:40 ,
                                                      onPressed: () {
                                                         controller.makeOrder();
                                                      },
                                                      child:  Text(
                                                        "52".tr,
                                                        style: const TextStyle(
                                                            color: Colors.white, fontWeight: FontWeight.bold),
                                                      )),
                                                )

                                              ],
                                            ),
                                          ),
                                        ),

                                      );
                                    },);
                                  }, );
                                // controller.makeOrder();
                              },
                              child:  Text(
                                "52".tr,
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              )),


                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          fallback: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },),
    );
  }
}