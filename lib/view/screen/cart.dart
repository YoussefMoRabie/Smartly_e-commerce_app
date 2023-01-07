import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/core/constants/color.dart';

import '../../controller/cart_controller.dart';
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.black87,
  backgroundColor: AppColor.primaryColor,
 // minimumSize: Size(88, 36),

  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    CartControllerImp cartController=Get.put(CartControllerImp());

    return GetBuilder<CartControllerImp>(
      builder: (controller){
        return controller.items.isEmpty? Center(
            child: Text('41'.tr,
                style: Theme.of(context).textTheme.headline1,)):Scaffold(
          body:
          Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) =>Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 140,
                      child: Row(
                        children: [
                          Stack(alignment: AlignmentDirectional.topStart, children: [
                            //Image(image: NetworkImage(model?.image??''),width: double.infinity,height: 100,),
                            Image(
                              image: NetworkImage(controller.items[index]["image"]),
                              width: 150,
                              height: 150,
                              //fit: BoxFit.fitHeight,
                            ),
                          ]),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.items[index]["title"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Row(
                                  children: [
                                      Text(
                                        "\$${controller.items[index]["price"]}",
                                        style: const TextStyle(
                                            color: AppColor.primaryColor, fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          controller.deleteItem(controller.items[index]["id"]);
                                        },
                                        icon: const Icon(
                                          Icons.delete_forever_rounded,
                                          color:
                                          Colors.red,
                                        ))
                                  ],
                                ),
                                Container(
                                  width: 130,
                                  height: 40,
                                  alignment: Alignment.center,
                                  color: Colors.grey[300],
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    IconButton(onPressed: () {
                                      cartController.decCount(controller.items[index]["id"],index);
                                    }, icon: const Icon(Icons.remove)),
                                    Padding(

                                      padding: const EdgeInsets.all(1.0),
                                      child: GetBuilder<CartControllerImp>(
                                        builder: (controller){
                                          return Text("${controller.items[index]["count"]}",
                                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),);
                                        },
                                      ),

                                    ),
                                    IconButton(onPressed: () {
                                      cartController.incCount(controller.items[index]["id"],index);
                                    }, icon: const Icon(Icons.add)),


                                  ],),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    );
                  },
                  itemCount: controller.items.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Text(
                            '40'.tr,
                            style:Theme.of(context).textTheme.headline1?.copyWith(
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 15,),
                          Text(
                            '\$ ${controller.getTotal()?.toStringAsFixed(2)}',
                            style:
                            TextStyle(fontSize: 18, color: AppColor.primaryColor),
                          ),

                        ],
                      ),
                    ),

                    Expanded(

                      child: SizedBox(
                        height:40,
                        child: TextButton(
                            style: flatButtonStyle,

                            onPressed: (){
                              controller.goToCheckOut();
                            },

                            child: Text('39'.tr, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        );
      },
    );

  }
}


