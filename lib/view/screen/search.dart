import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartly/core/class/status_request.dart';
import 'package:smartly/core/shared/styles/themes.dart';
import '../../controller/search_controller.dart';
import '../../core/constants/color.dart';

class Search extends StatelessWidget {
 const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    Get.put(SearchControllerImp());
    return GetBuilder<SearchControllerImp>(builder: ( controller) {
      return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: false,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                   fontWeight: FontWeight.normal,
                   fontSize: 14
                 ),

          validator: (value) {
                  if (value!.isEmpty) {
                    return "42".tr;
                  }
                  return null;
                },
                controller: searchController,
                keyboardType: TextInputType.text,
                decoration:  InputDecoration(
                  labelText: '37'.tr,
                   labelStyle: Theme.of(context).textTheme.headline1,
                  border: const OutlineInputBorder(),
                  suffixIcon:  IconButton( onPressed: () {
                    if(formKey.currentState!.validate()) {
                          controller.getSearchData(searchController.text);
                        }
                      }, icon: const Icon(Icons.search),),


                ),
              ),
              const SizedBox(height: 20,),
              if(controller.searchResult.isEmpty&&searchController.text.isNotEmpty)
                Center(child: Text("43".tr,style: Theme.of(context).textTheme.headline1,)),
              if(searchController.text.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                                 controller.goToProduct(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 130,
                            child: Row(
                              children: [
                                Stack(alignment: AlignmentDirectional.topStart, children: [
                                  Image(
                                    image: NetworkImage("${controller.searchResult[index]?.image}"),
                                    width: 150,
                                    height: 150,
                                    //fit: BoxFit.fitHeight,
                                  ),

                                ]),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.searchResult[index]?.title}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                            Text(
                                              "${controller.searchResult[index]?.price}\$",
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),




                                          const Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      );
                    },
                    itemCount: controller.searchResult.length,
                  ),
                ),
              if(controller.allSearchResult.isNotEmpty&&searchController.text.isNotEmpty)
                FloatingActionButton(onPressed: (){

                 showModalBottomSheet(context: context,
                   backgroundColor: Colors.transparent,
                   barrierColor: Colors.transparent,
                   builder: (BuildContext context) {
                   return GetBuilder<SearchControllerImp>(builder: (controller) {
                     return Container(
                       height: 200,
                       decoration:  BoxDecoration(
                           color: ThemeService().isSavedDarkMode()?Colors.black:Colors.white,
                           borderRadius: const BorderRadius.only(
                               topRight: Radius.circular(20),
                               topLeft: Radius.circular(20)
                           ) ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: [
                             Text("45".tr,style: Theme.of(context).textTheme.headline1,),
                             RangeSlider(
                               values: controller.currentRangeValues,
                               max: 10000,
                               divisions: 100,
                               labels: RangeLabels(
                                 controller.currentRangeValues.start.round().toString(),
                                 controller.currentRangeValues.end.round().toString(),
                               ),
                               onChanged: (RangeValues values) {
                                 controller.changeSlider(values);
                               },
                             ),
                             MaterialButton(
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(10)),
                                 color: AppColor.primaryColor,
                                 height:40 ,
                                 onPressed: () {
                                   controller.filter();
                                   Navigator.pop(context);
                                 },
                                 child:  Text(
                                   "44".tr,
                                   style: const TextStyle(
                                       color: Colors.white, fontWeight: FontWeight.bold),
                                 ))

                           ],
                         ),
                       ),

                     );
                   },);
                 }, );
                },
                  child: const Icon(Icons.filter_alt_outlined),
                ),


            ],
          ),
        ));
    });
  }
}
