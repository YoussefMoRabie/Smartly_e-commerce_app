import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';
import '../../core/constants/color.dart';
import '../../core/services/services.dart';
import '../../core/shared/styles/themes.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    ProductControllerImp proController=Get.put(ProductControllerImp());
    return GetBuilder<ProductControllerImp>(builder: (controller) =>Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:AppColor.primaryColor,
          statusBarIconBrightness:ThemeService().isSavedDarkMode()? Brightness.light:Brightness.dark,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();

          },
          icon: const Icon(Icons.arrow_back_ios_outlined,),

        ),
        title: Text('Smartly'),

      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 40,
          child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: AppColor.primaryColor,
              onPressed: () {
                 controller.addToCart();
              },
              child: Text(
                "46".tr,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 220,
                decoration: const BoxDecoration(color: AppColor.primaryColor),
              ),
              Positioned(
                  top: 50.0,
                  right: Get.width / 8,
                  left: Get.width / 8,
                  child: Hero(
                    tag: "${proController.product.id}",

                    child: Image(image: NetworkImage("${proController.product.image}"),
                      height: 230,
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${proController.product.title}",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 30,
                  )),
              RatingBarIndicator(
                rating: double.parse("${proController.product.rating.rate}"),
                unratedColor: ThemeService().isSavedDarkMode()?Colors.grey[200]:Colors.grey[600],
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,

                ),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 50,
                          child: ElevatedButton(

                            onPressed: (){
                              proController.incCount();
                            },

                            child: Icon(CupertinoIcons.minus),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GetBuilder<ProductControllerImp>(builder: (controller) =>
                              AnimatedFlipCounter(
                                curve: Curves.elasticOut,
                                textStyle: Theme.of(context).textTheme.headline1?.copyWith(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal
                                ),
                                value: controller.count ,
                              ),),
                        ),
                        SizedBox(
                          height: 30,
                          width: 50,
                          child: ElevatedButton(
                              child:  const Icon(CupertinoIcons.plus),
                              onPressed: (){
                                proController.decCount();
                              }
                          ),
                        ),
                      ],
                    ),



                  const Spacer(),
                    Text(
                      "${proController.product.price}\$",
                      style: const TextStyle(
                          color: Colors.red, fontSize: 30, height: 1.1),
                    ),
                ],
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 5,),
              Text(
                  "Description : ${controller.product.description}",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ]),
          )
        ],
      )
    ));
  }
}
