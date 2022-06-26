import 'dart:io';

import 'package:airsoft_app/model/product.dart';
import 'package:airsoft_app/model/res/product_res.dart';
import 'package:airsoft_app/widget/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../mixins/constant.dart';
import '../mixins/dialog.dart';
import '../provider/auth_provider.dart';
// import 'package:news_apps/model/news.dart';
// import 'package:news_apps/repository/news_repository.dart';

class HomeController extends GetxController {
  final GlobalKey<FormState> keyAdd = GlobalKey<FormState>();
  final GlobalKey<FormState> keyEdit = GlobalKey<FormState>();
  File? image;
  RxString imagePath = "".obs;
  final _picker = ImagePicker();
  RxString name = "".obs;
  RxString description = "".obs;
  RxInt price = 0.obs;
  RxString token = "".obs;
  final _authService = Get.find<AuthProvider>();
  late Map<String, dynamic> user;
  int page = 1;
  RxList<Product> _listProducts = <Product>[].obs;
  RxList get listProducts => _listProducts;
  RxBool _isNoLoadMore = false.obs;
  bool get isNoLoadMore => _isNoLoadMore.value;
  RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  int getItemLength() {
    if (_isNoLoadMore.value == true) {
      return _listProducts.length;
    }
    return _listProducts.length + 1;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void callAPI({bool refresh = false}) {
    // isLoading.value=true;
    // newsRepository.getNews().then((List<News> value) {
    //   list_news.addAll(value);
    //   isLoading.value=false;
    // }).catchError((err, track) {
    //   print("Something wrong ${err} ${track}");
    // });
    if (refresh == true) {
      _isNoLoadMore.value = false;
      page = 1;
      _listProducts.clear();
    }
    _isLoading.value = true;
    _authService.getProduct(page, token.value).then((ProductRes res) {
      _isLoading.value = false;
      if (res.resultsGet!.isEmpty) {
        _isNoLoadMore.value = true;
      }
      if (res.resultsGet!.isNotEmpty) {
        page++;
        _listProducts.addAll(res.resultsGet!);
        print(_listProducts);
      }
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    }).catchError((err, track) {
      print("Something wrong ${err} ${track}");
    });
  }

  void getStorage() {
    if (GetStorage().hasData("user")) {
      user = GetStorage().read("user");
      token.value = user["token"];
      name.value = user["name"];
      print(user["doLogin"]);
      print(user["token"]);
    } else {
      print("users not found!");
    }
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath.value = pickedFile.path.split('/').last;
      print(imagePath);
      update();
    } else {
      print('No image selected');
    }
  }

  void addProduct() {
    if (keyAdd.currentState!.validate()) {
      if (imagePath.value.isNotEmpty) {
        LoadingView();
        final product = FormData({
          'name': nameController.text,
          'description': descriptionController.text,
          'price': priceController.text,
          'file': MultipartFile(image, filename: imagePath.value),
        });

        _authService.addProduct(product, token.value).then((ProductRes res) {
          if (res.success!) {
            //set empty
            setEmptyAddProduct();
            callAPI(refresh: true);
            Get.back();
          }
        });
      } else {
        Get.snackbar("Message", 'image file not found',
            colorText: Colors.white, backgroundColor: red);
      }
    }
  }

  void editProduct(String id) {
    if (keyEdit.currentState!.validate()) {
      final product = FormData({
        'id': id,
        'name': nameController.text,
        'description': descriptionController.text,
        'price': priceController.text,
        'file': imagePath.value.isNotEmpty
            ? MultipartFile(image, filename: imagePath.value)
            : "",
      });

      _authService.editProduct(product, token.value).then((ProductRes res) {
        if (res.success!) {
          //set empty
          setEmptyAddProduct();
          callAPI(refresh: true);
          Get.toNamed("/home");
        }
      });
    }
  }

  void deleteProduct(int id) {
    _authService.deleteProduct(id, token.value).then((ProductRes res) {
      if (res.success!) {
        callAPI(refresh: true);
        Get.back();
      }
    });
  }

  void setEmptyAddProduct() {
    nameController.text = "";
    descriptionController.text = "";
    priceController.text = "";
    imagePath.value = "";
  }

  @override
  void onReady() {
    getStorage();
    callAPI();
    super.onReady();
  }
}
