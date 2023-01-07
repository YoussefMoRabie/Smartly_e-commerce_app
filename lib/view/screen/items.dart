import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../controller/items_controller.dart';
import '../../core/constants/color.dart';
import '../../core/shared/styles/themes.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemsControllerImp ItemsController = Get.put(ItemsControllerImp());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();

          },
          icon: const Icon(Icons.arrow_back_ios_outlined,),

        ),
        title: const Text('Smartly'),

      ),
      body:  GetBuilder<ItemsControllerImp>(builder: ( controller) =>ConditionalBuilder(
        condition: controller.productsByCat.isNotEmpty,
        builder: (BuildContext context) {
          return ListView(
            children: [
              SizedBox(height: 40,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                  const SizedBox(width: 10),
                  itemCount: ItemsController.categoriesName.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        ItemsController.changeCat(index);
                      },
                      child: Container(
                        decoration: (ItemsController.selectedCat== index)! ? const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 3,color: AppColor.primaryColor),
                          ),
                        ):null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                              ItemsController.categoriesName[index],
                              style: TextStyle(
                                  fontSize: 20, color: ThemeService().isSavedDarkMode()?Colors.white:Colors.black,
                                  fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                    );
                  },
                ),),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:controller.productsByCat.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                        onTap: (){
                          controller.goToProduct(index);
                        },
                        child: Card(
                          color: ThemeService().isSavedDarkMode()?Colors.black:Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Hero(
                                    tag: "${controller.productsByCat[index]?.id}",
                                    child: Image(
                                      image:
                                      NetworkImage("${controller.productsByCat[index]?.image}"),
                                      height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(height: 10) ,
                                  Text("${controller.productsByCat[index]?.title}",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: ThemeService().isSavedDarkMode()?Colors.white:Colors.black,
                                          fontSize: 14
                                      )),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Rating ${controller.productsByCat[index]?.rating.rate}", textAlign: TextAlign.center,
                                          style:  TextStyle(
                                              color: ThemeService().isSavedDarkMode()?Colors.white:Colors.black,
                                              fontSize: 14
                                          )
                                      ),
                                      RatingBarIndicator(

                                        rating: double.parse("${controller.productsByCat[index]?.rating.rate}"),

                                        itemBuilder: (context, index) => const Icon(

                                          Icons.star,

                                          color: Colors.amber,

                                        ),

                                        itemCount: 5,
                                        unratedColor: ThemeService().isSavedDarkMode()?Colors.grey[200]:Colors.grey[600],
                                        itemSize: 18.0,

                                        direction: Axis.horizontal,

                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${controller.productsByCat[index]?.price}\$",//"${itemsModel.itemsPrice} \$",
                                          style: const TextStyle(
                                              color: AppColor.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "sans")),
                                    ],
                                  )
                                ]),
                          ),
                        ));

                  }),

            ],
          );
        },
        fallback: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    )
    );
  }
}



