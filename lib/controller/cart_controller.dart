import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/core/shared/toast.dart';
import 'package:hive/hive.dart';
import '../core/class/status_request.dart';
import '../view/screen/checkout.dart';

abstract class CartController extends GetxController {
  void incCount(proId,index);
  void decCount(proId,index);
  deleteItem(int proId) ;
  getData();
  goToCheckOut();
  num? getTotal();
}

class CartControllerImp extends CartController {
  // Handling requests status
  late StatusRequest statusRequest;


  @override
  void onInit() {
    getData();
    super.onInit();
  }
  // cart products
List items = [];
  // cart total price
num? count=0;

// get cart products from local database
@override
getData() async {
  items.clear();
  var box = await Hive.openBox('cart');
   items= box.values.toList();
  update();
}
// delete cart product from local database
@override
deleteItem(proId) async {

  items.clear();
  var box = await Hive.openBox('cart');
  box.delete(proId);
  items= box.values.toList();
toast("53".tr, Colors.green);
  update();
}
// increment cart product count in local database
  @override
  void incCount(proId,index) async {
    items[index]["count"]++;
    var box = await Hive.openBox('cart');
    box.put(proId, items[index]);
    toast("54".tr, Colors.green);
    update();
  }
// decrement cart product count in local database
  @override
  void decCount(proId,index) async {
  if(items[index]["count"]>1) {
      items[index]["count"]--;
      var box = await Hive.openBox('cart');
      box.put(proId, items[index]);
      toast("55".tr, Colors.green);
    }
  else{
    toast("56".tr, Colors.red);

  }
    update();
  }
// get cart total price
  @override
  num? getTotal() {
      count=0;
    for(var i = 0; i < items.length; i++) {
        count = count! + items[i]["price"]! * items[i]["count"]!;
    }
    return count;
  }

@override
goToCheckOut() {
  Get.to(const CheckOut() ,arguments: {
    "orders": items,
    "total":count,
  });
}
}