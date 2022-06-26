import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  late Map<String, dynamic> users;

  selection() {
    return Timer(Duration(seconds: 2), () {
      if (GetStorage().hasData("users")) {
        users = GetStorage().read("users");
        if (users["doLogin"]) {
          Get.offAllNamed("/home");
        } else {
          Get.offAllNamed("/login");
        }
      } else {
        Get.offAllNamed("/register");
      }
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    selection();
    super.onReady();
  }
}
