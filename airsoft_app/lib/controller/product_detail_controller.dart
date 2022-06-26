import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/product.dart';

class ProductDetailController extends GetxController {
  RxList<Product> _listProducts = <Product>[].obs;

  void getStorage() {
    if (GetStorage().hasData("product")) {
      _listProducts = GetStorage().read("product");
      print(_listProducts);
    } else {
      print("product not found!");
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    // getStorage();
    super.onReady();
  }
}
