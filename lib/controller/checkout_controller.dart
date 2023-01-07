import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/core/shared/toast.dart';
import 'package:hive/hive.dart';
import '../core/class/status_request.dart';
import '../view/screen/layout.dart';
import '../view/screen/payment.dart';
import 'cart_controller.dart';
import 'layout_controller.dart';

abstract class CheckOutController extends GetxController {
  changeSC(val);
  makeOrder();
  changePayment(bool credit);
}

class CheckOutControllerImp extends CheckOutController {


  // address form control key
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  // Text Controllers
  late TextEditingController address;
  late TextEditingController city;
  late TextEditingController country;
  late TextEditingController zip;

  int selectedSC =0;
  double total=0;
  bool isCredit=false;



  List items = [];
  List products=[];
  initialData() {
    address = TextEditingController();
    zip = TextEditingController();
    city = TextEditingController();
    country = TextEditingController();
    products = Get.arguments['orders'];
    total = Get.arguments['total'];
    items=[
      {
      "scid": 1,
      "sc_name": "AP Group",
      "cost": 100,
      "delivery_time": 1
    },
      {
        "scid": 2,
        "sc_name": "Cosco",
        "cost": 40,
        "delivery_time": 7
      },
      {
        "scid": 3,
        "sc_name": "CMA Group",
        "cost": 60,
        "delivery_time": 4
      },
      {
        "scid": 4,
        "sc_name": "Hapag-Lloyd",
        "cost": 70,
        "delivery_time": 3
      },
      {
        "scid": 5,
        "sc_name": "ONE",
        "cost": 90,
        "delivery_time": 2
      },
      {
        "scid": 6,
        "sc_name": "Amazon Fresh",
        "cost": 50,
        "delivery_time": 5
      },
      {
        "scid": 7,
        "sc_name": "Shipt",
        "cost": 60,
        "delivery_time": 4
      },
      {
        "scid": 8,
        "sc_name": "Instacart",
        "cost": 20,
        "delivery_time": 9
      },
      {
        "scid": 9,
        "sc_name": "Boxed",
        "cost":30,
        "delivery_time": 8
      },
      {
        "scid": 10,
        "sc_name": "Evergreen",
        "cost": 10,
        "delivery_time": 10
      }
      ];
  }
  late StatusRequest statusRequest;

  @override
  void onInit()  {
    initialData();
  super.onInit();
  }

  @override
  changeSC(val) {
    selectedSC = val;
    update();
  }

@override
  changePayment(bool credit){
    isCredit=credit;
    update();
}


  @override
  makeOrder() async {
    if(formState.currentState!.validate()){
    if(isCredit){
      Get.to(const Payment());
    }
    else {
      products.clear();
      var box = await Hive.openBox('cart');
      box.clear().then((value) {
        CartControllerImp cartController = Get.put(CartControllerImp());
        cartController.getData();
        update();
        toast("57".tr, Colors.green);
        LayoutControllerImp controller = Get.put(LayoutControllerImp());
        controller.changePage(0);
        Get.offAll(const Layout());



      });
    }
    }
  }


}