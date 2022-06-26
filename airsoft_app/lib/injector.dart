import 'package:airsoft_app/controller/product_detail_controller.dart';
import 'package:airsoft_app/provider/auth_provider.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';
import 'controller/login_controller.dart';
import 'controller/register_controller.dart';
import 'controller/splash_controller.dart';

class Injector extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(()     => ProductDetailController());
    // Get.lazyPut(() => ProfileController());
    // Get.lazyPut(() => NewsRepository());
  }
}
