import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/view/screen/Setting.dart';
import 'package:smartly/view/screen/home.dart';

import '../core/shared/styles/themes.dart';
import '../view/screen/cart.dart';
import '../view/screen/search.dart';
import 'home_controller.dart';

abstract class LayoutController extends GetxController{
 changePage(int currentPage);
 changeMode();
}
class LayoutControllerImp extends LayoutController{
  int currentIndex=0;

  List<Widget> screens=  [
    const Home(),
    const Cart(),
    const Search(),
    const Setting(),
  ];
  @override
  changePage(int currentPage) {
    currentIndex=currentPage;
    update();
  }

  @override
  changeMode() {
    ThemeService().changeTheme();
    update();

    HomeControllerImp homeController = Get.put(HomeControllerImp());

    homeController.updateHome();

  }
}