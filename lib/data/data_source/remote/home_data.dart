import '../../../../API.dart';
import '../../../../core/class/curd.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);
  getHomeData() async {
    var response = await crud.getData(AppLink.products);
    return response.fold((l) => l, (r) => r);
  }
  getCategoriesData() async {
    var response = await crud.getData(AppLink.categories);
    return response.fold((l) => l, (r) => r);
  }
}