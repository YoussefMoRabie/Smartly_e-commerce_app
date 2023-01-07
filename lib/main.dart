import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartly/core/localization/translation.dart';
import 'package:smartly/core/services/services.dart';
import 'package:smartly/view/screen/auth/login.dart';
import 'package:smartly/view/screen/layout.dart';
import 'package:smartly/view/screen/onboarding.dart';
import 'package:hive_flutter/adapters.dart';
import 'Binding/initialBinding.dart';
import 'core/localization/changeLang.dart';
import 'core/shared/styles/themes.dart';
var id=-1;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Hive.initFlutter();
  await initialServices();
  MyServices myServices=Get.find();
  Widget startWidget=  const OnBoarding();
  if(myServices.sharedPreferences.getString("onBoarding")=="1") {
    startWidget = const Login();
    if(myServices.sharedPreferences.getString("id")!=null) {
      id = int.parse(myServices.sharedPreferences.getString("id")!);
      if (id == -1) {
        startWidget = const Login();
      } else {
        startWidget = const Layout();
      }
    }
  }
  runApp( MyApp(startWidget: startWidget,));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({super.key,
  required this.startWidget
  });


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: AppTranslation(),
      locale: controller.language,
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      title: 'HardWhere',
      theme: ThemeService().lightTheme,

      darkTheme: ThemeService().darkTheme,

      themeMode: ThemeService().getThemeMode(),
      home:startWidget,
    );
  }
}



