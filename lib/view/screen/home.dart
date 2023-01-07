import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../core/constants/color.dart';
import '../../core/shared/styles/themes.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeControllerImp homeController = Get.put(HomeControllerImp());
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Image(image: AssetImage('assets/images/banner.png'),fit: BoxFit.fitWidth,),
          ),
           Text("34".tr,
              style: const TextStyle(
                  fontSize: 20,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: GetBuilder<HomeControllerImp>(
                builder: (controller) => ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: homeController.categoriesName.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.goToItems(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: ThemeService().isSavedDarkMode()
                                    ? AppColor.lightBackGroundColor
                                    : AppColor.darkBackGroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              controller.categoriesName[index],
                              style: TextStyle(
                                  color: ThemeService().isSavedDarkMode()
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    )),
          ),
          const SizedBox(height: 10),
           Text("33".tr,
              style: const TextStyle(
                  fontSize: 20,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GetBuilder<HomeControllerImp>(builder: (controller) {
            return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                      onTap: () {
                        controller.goToProduct(index);
                      },
                      child: Card(
                        color: ThemeService().isSavedDarkMode()
                            ? Colors.black
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: "${controller.products[index]?.id}",
                                  child: Image(
                                    image: NetworkImage(
                                        "${controller.products[index]?.image}"),
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${controller.products[index]?.title}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ThemeService().isSavedDarkMode()
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14)),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    RatingBarIndicator(
                                      rating: double.parse(
                                          "${controller.products[index]?.rating.rate}"),
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      unratedColor:
                                          ThemeService().isSavedDarkMode()
                                              ? Colors.grey[200]
                                              : Colors.grey[600],
                                      itemSize: 18.0,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${controller.products[index]?.price}\$", //"${itemsModel.itemsPrice} \$",
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
                });
          })
        ],
      ),
    );
  }
}
