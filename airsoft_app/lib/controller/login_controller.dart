// import 'package:another_flushbar/flushbar.dart';
import 'package:airsoft_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/auth.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final _authService = Get.find<AuthProvider>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool is_visible = true;
  RxList<Auth> _listAuth = <Auth>[].obs;
  RxString email = "".obs;
  RxString password = "".obs;
  late Map<String, dynamic> users;
  final box = GetStorage();

  void getStorage() {
    if (GetStorage().hasData("user")) {
      users = GetStorage().read("user");
      email.value = users["email"];
      password.value = users["password"];
    } else {
      print("users not found!");
    }
  }

  void doLogin(BuildContext context) {
    if (key.currentState!.validate()) {
      // if (emailController.text == email.value &&
      //     passwordController.text == password.value) {
      //   users["doLogin"] = true;
      //   Get.offAllNamed("/home");
      //   Flushbar(
      //     flushbarPosition: FlushbarPosition.TOP,
      //     backgroundColor: const Color(0xFF22bb33),
      //     message: 'login berhasil',
      //     duration: const Duration(seconds: 3),
      //   ).show(context);
      // } else {
      //   Flushbar(
      //     flushbarPosition: FlushbarPosition.TOP,
      //     backgroundColor: const Color(0xFFFF5C83),
      //     message: 'email atau password yang Anda masukkan salah!',
      //     duration: const Duration(seconds: 3),
      //   ).show(context);
      //   // print("Alamat email atau password yang kamu masukkan salah.");
      // }
      final auth = {
        'email': emailController.text,
        'password': passwordController.text
      };
      _authService.doLogin(auth).then((Auth res) {
        if (res.success!) {
          Map<String, dynamic> user = {
            "name": res.results!.name,
            "email": res.results!.email,
            "token": res.results!.token,
            "doLogin": false,
          };
          box.write('user', user).then((value) {
            Get.offAllNamed("/home");
          });
        }
      });
    }
  }

  void doLogout(BuildContext context) {
    GetStorage().erase();
    Get.offAllNamed("/login");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    // getStorage();
    super.onReady();
  }
}
