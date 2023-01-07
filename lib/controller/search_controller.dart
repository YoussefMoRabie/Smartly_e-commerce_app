
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/status_request.dart';

import '../data/model/product_model.dart';
import '../view/screen/product.dart';
import 'home_controller.dart';

abstract class SearchController extends GetxController {
  getSearchData(txt);
  goToProduct(int selectedPro);
}

class SearchControllerImp extends SearchController {
late StatusRequest statusRequest;
bool checkedValue=false;
RangeValues currentRangeValues = RangeValues(0, 10000);

List<ProductModel?> allProducts=[];
List<ProductModel?> searchResult=[];
List<ProductModel?> allSearchResult=[];

  @override
  void onInit() {
    statusRequest = StatusRequest.loading;
    HomeControllerImp homeController = Get.put(HomeControllerImp());
    allProducts=homeController.products;
    super.onInit();
  }
@override

goToProduct(int selectedPro) {
  Get.to(()=> const Product() ,arguments: {
    "selectedPro": searchResult[selectedPro],
  });
}

  @override
  getSearchData(txt) {
    searchResult.clear();
    allSearchResult.clear();
    for (var i = 0; i < allProducts.length; i++) {
      if("${allProducts[i]?.title}".toLowerCase().contains(txt.toLowerCase()))
      {
        searchResult.add(allProducts[i]);
        allSearchResult.add(allProducts[i]);
      }
    }
    currentRangeValues = RangeValues(0, 10000);
        update();
  }
  filter(){
    searchResult.clear();
    for (var i = 0; i < allSearchResult.length; i++) {
      double price=0;
      price=allSearchResult[i]?.price??0;
      if(price>=currentRangeValues.start&&price<=currentRangeValues.end)
        {
          searchResult.add(allSearchResult[i]);
        }
    }
    update();
  }
  changeSlider(RangeValues values){
    currentRangeValues=values;
    update();
  }





}