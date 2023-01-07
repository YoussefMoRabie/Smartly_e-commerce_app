import '../../../../API.dart';
import '../../../../core/class/curd.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);
  getData(String username,String password ) async {
    var response = await crud.postData(AppLink.login,{
        "username":username,
        "password":password
    });
    return response.fold((l) => l, (r) => r);
  }
}