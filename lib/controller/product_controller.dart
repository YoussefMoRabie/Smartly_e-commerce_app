import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/core/shared/toast.dart';
import 'package:hive/hive.dart';

import '../core/class/status_request.dart';
import '../core/functions/handling_data_controller.dart';
import '../data/model/product_model.dart';
import 'cart_controller.dart';

abstract class ProductController extends GetxController {
  void incCount();
  void decCount();
  initialData();
  addToCart();

}

class ProductControllerImp extends ProductController {
int count=1;
late int id;
late ProductModel product;
 Map<String,dynamic> productDetails ={};
late StatusRequest statusRequest;


  @override
  Future<void> onInit() async {
    initialData();
    super.onInit();
  }

  @override
  void decCount() {
      count++;
    update();
  }

  @override
  void incCount() {
    if(count>1) {
      count--;
    }
    update();
  }

  @override
  initialData() {
    product=Get.arguments['selectedPro'];
  }




@override
addToCart() async {
  var box = await Hive.openBox('cart');
  box.put(product.id, {
    "id":product.id,
    "count":count,
    "price":product.price,
    "title":product.title,
    "image":product.image,
  }
  );
  CartControllerImp cartController=Get.put(CartControllerImp());
  cartController.getData();
  toast("58".tr, Colors.green);
  update();
}
}