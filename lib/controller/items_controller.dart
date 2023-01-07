import 'package:get/get.dart';
import 'package:smartly/view/screen/product.dart';

import '../core/class/status_request.dart';
import '../data/model/product_model.dart';

abstract class ItemsController extends GetxController{
  initialData();
  changeCat(int val);
  goToProduct(int selectedPro);
}
class ItemsControllerImp extends ItemsController{
  List categories = [];
  String? catid;
  int selectedCat=0;


  List laptops = [];
  List screens = [];
  List headphones = [];
  List mobiles = [];
  List accessories = [];
  List<List> lists = [];
  List length= [];


  List categoriesName = [];

  late StatusRequest statusRequest;

  @override
  Future<void> onInit() async {

    initialData();
    super.onInit();
  }
  List<ProductModel?> products=[];
  List<ProductModel?> productsByCat=[];
  @override
  initialData() {
    products = Get.arguments['products'];
    categoriesName = Get.arguments['cat'];
    selectedCat = Get.arguments['selectedCat'];
    changeCat(selectedCat);
  }

  @override
  changeCat(val) {
     selectedCat = val;
     productsByCat.clear();
     for (var i = 0; i < products.length; i++) {
       if(products[i]?.category==categoriesName[selectedCat])
         {
           productsByCat.add(products[i]);
         }
     }
     update();
  }

  @override
  goToProduct(int selectedPro) {
    Get.to(()=> const Product() ,arguments: {
      "selectedPro":  productsByCat[selectedPro],
    });
  }
}