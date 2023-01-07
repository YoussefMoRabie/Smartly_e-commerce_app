import 'package:get/get.dart';

import '../core/class/curd.dart';
// Dependency Injection to use it in app
class InitialBindings extends Bindings{
  @override
  void dependencies() {
      Get.put(Crud());
  }

}