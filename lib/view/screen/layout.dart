import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartly/core/shared/styles/themes.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:switcher_button/switcher_button.dart';
import '../../controller/layout_controller.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LayoutControllerImp());


    return GetBuilder<LayoutControllerImp>(builder: (controller)=>Scaffold(
      appBar: AppBar(
        title: const Text('Smartly'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SwitcherButton(
                value:  !ThemeService().isSavedDarkMode(),
                onColor: Colors.grey[200]!,
                onChange: (value) {
                  controller.changeMode();
                },
              ),
            ),
          ),
        ],
      ),
      body: controller.screens.elementAt(controller.currentIndex),
      bottomNavigationBar:  Container(
        decoration: BoxDecoration(
          color: ThemeService().isSavedDarkMode() ?Colors.black:Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: ThemeService().isSavedDarkMode() ?Colors.white.withOpacity(.1):Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[900]!,
              haptic: true, // haptic feedback
              gap: 8,
              tabActiveBorder: Border.all(color: Colors.black, width: 1),
              activeColor: ThemeService().isSavedDarkMode() ?Colors.white:Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: ThemeService().isSavedDarkMode() ?HexColor('333739'):Colors.white,
              color: Colors.grey,
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: '35'.tr,
                ),
                GButton(
                  icon: Icons.shopping_cart_outlined,
                  text: '36'.tr,
                ),
                GButton(
                  icon: Icons.search_outlined,
                  text: '37'.tr,
                ),
                GButton(
                  icon: Icons.settings,
                  text: '38'.tr,
                ),
              ],
              onTabChange: (index) {
                controller.changePage(index);
              },
            ),
          ),
        ),
      ),
    ));

  }
}
