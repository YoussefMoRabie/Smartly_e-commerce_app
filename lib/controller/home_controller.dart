import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/data/model/product_model.dart';
import 'package:smartly/view/screen/product.dart';

import '../core/class/status_request.dart';
import '../core/functions/handling_data_controller.dart';
import '../core/services/services.dart';
import '../data/data_source/remote/home_data.dart';
import '../view/screen/items.dart';

abstract class HomeController extends GetxController {
  initialData();
  getData();
  goToItems(int selectedCat);
  goToProduct(int selectedPro);
  getCategoriesData();
  void updateHome();
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();

  String? fName;
  String? lName;
  String? id;

  List categoriesName = [];


  HomeData homeData = HomeData(Get.find());
  late StatusRequest statusRequest;


  @override
  initialData() {

    fName = myServices.sharedPreferences.getString("fName") ;
    lName = myServices.sharedPreferences.getString("lName") ;
    id = myServices.sharedPreferences.getString("id") ;
  }


  List<ProductModel?> products=[];
  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await homeData.getHomeData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
        if(response['data']!=null)
        {
          response['data'].forEach((value){
            products.add(ProductModel.fromJson(value));
          });
        }
    }
    update();
  }
  @override
  getCategoriesData() async {
    statusRequest = StatusRequest.loading;
    var response = await homeData.getCategoriesData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      categoriesName.addAll(response['data']);
    }
    update();
  }
  @override
  void onInit() {
    initialData();
    getData();
    getCategoriesData();
    super.onInit();
  }


  @override
  goToItems(selectedCat) {
    Get.to(const Items() ,arguments: {
      "selectedCat": selectedCat,
      "cat":categoriesName,
      "products" :products
    });
  }

  @override
  goToProduct(int selectedPro) {
    Get.to(()=> const Product() ,arguments: {
      "selectedPro":  products[selectedPro],
    });
  }


  @override
  void updateHome(){
    update();
  }
}