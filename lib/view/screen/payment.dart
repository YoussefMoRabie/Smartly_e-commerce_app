import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartly/controller/payment_controller.dart';
import 'package:smartly/core/constants/color.dart';
import '../../core/functions/valid_input.dart';


class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentController payController=Get.put(PaymentController());

    return GetBuilder<PaymentController>(builder: (controller) {

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();

            },
            icon: const Icon(Icons.arrow_back_ios_outlined,),

          ),
          title: Row(
            children: const [
              Text('Smartly'),
            ],
          ),

        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              CreditCard(
                cardNumber: controller.cardNumber,
                cardExpiry: controller.expiryDate,
                cardHolderName: controller.cardHolderName,
                cvv: controller.cvv,
                bankName: 'Smartly',
                showBackSide: controller.showBack,
                frontBackground: CardBackgrounds.black,
                backBackground: CardBackgrounds.white,
                showShadow: true,
                // mask: getCardTypeMask(cardType: CardType.americanExpress),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: controller.formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (val){
                          return validInput(val!, 16, 16, "");

                        },

                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly

                        ],
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                        controller: controller.cardNumberCtrl,

                        decoration: InputDecoration(hintText: 'Card Number',
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          counterStyle: const TextStyle(color: AppColor.primaryColor),

                        ),
                        maxLength: 16,
                        onChanged: (value) {
                          final newCardNumber = value.trim();
                          var newStr = '';
                          final step = 4;

                          for (var i = 0; i < newCardNumber.length; i += step) {
                            newStr += newCardNumber.substring(
                                i, math.min(i + step, newCardNumber.length));
                            if (i + step < newCardNumber.length) newStr += ' ';
                          }
                          controller.changCardNumber(newStr);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (val){
                          return validInput(val!,5, 5, "Date");
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly

                        ],
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),

                        controller: controller.expiryFieldCtrl,

                        decoration: InputDecoration(hintText: 'Card Expiry',
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          counterStyle: const TextStyle(color: AppColor.primaryColor),

                        ),
                        maxLength: 5,
                        onChanged: (value) {
                          var newDateValue = value.trim();
                          final isPressingBackspace =
                              controller.expiryDate.length > newDateValue.length;
                          final containsSlash = newDateValue.contains('/');

                          if (newDateValue.length >= 2 &&
                              !containsSlash &&
                              !isPressingBackspace) {
                            newDateValue = newDateValue.substring(0, 2) +
                                '/' +
                                newDateValue.substring(2);
                          }
                          controller.changExpiryDate( newDateValue);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        validator: (val){
                          return validInput(val!, 3, 100, "");

                        },
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                        decoration: InputDecoration(hintText: 'Card Holder Name',
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                        ),

                        onChanged: (value) {
                          controller.changCardHolderName(value);

                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: TextFormField(
                        validator: (val){
                          return validInput(val!, 3, 3, "");

                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                        decoration: InputDecoration(hintText: 'CVV',
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          counterStyle: const TextStyle(color: AppColor.primaryColor),

                      ),
                        maxLength: 3,

                        onChanged: (value) {
                          controller.changCvv(value);
                        },
                        focusNode: controller.focusNode_,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar:Container(
          padding: const EdgeInsets.all(10.0),

          width: double.infinity,
          child:MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: AppColor.primaryColor,
              height:40 ,
              onPressed: () {
                 controller.makeOrder();
              },
              child: Text(
                "52".tr,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),


        ),
      );
    },);
  }
}
