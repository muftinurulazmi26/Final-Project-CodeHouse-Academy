import 'package:airsoft_app/provider/auth_provider.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthProvider());
    // TODO: implement dependencies
  }

}