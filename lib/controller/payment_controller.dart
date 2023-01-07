import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/view/screen/layout.dart';
import 'package:hive/hive.dart';
import '../core/shared/toast.dart';
import 'cart_controller.dart';
import 'layout_controller.dart';

class PaymentController extends GetxController {

  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;
  GlobalKey<FormState> formState=GlobalKey<FormState>();

  late FocusNode focusNode_;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  changCardNumber(cardNumber_){
    cardNumber=cardNumber_;
    update();
  }
  changCvv(cvv_){
    cvv=cvv_;
    update();
  }
  changCardHolderName(cardHolderName_){
    cardHolderName=cardHolderName_;
    update();
  }
  changExpiryDate(newDateValue){
    expiryDate=newDateValue;
    expiryFieldCtrl.text = newDateValue;
    expiryFieldCtrl.selection = TextSelection.fromPosition(TextPosition(offset: newDateValue.length));
    expiryDate = newDateValue;
    update();
  }
  changShowBack(showBack_){
    showBack=showBack_;
    update();
  }


  @override
  void onInit() {
    focusNode_ = FocusNode();
    focusNode_.addListener(() {
         focusNode_.hasFocus ? showBack = true : showBack = false;
    });
    super.onInit();
  }
  makeOrder() async {
    if (formState.currentState!.validate()) {
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
  @override
  void dispose() {
    focusNode_.dispose();
    super.dispose();
  }
}