import 'package:airsoft_app/mixins/constant.dart';
import 'package:airsoft_app/model/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../provider/auth_provider.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final box = GetStorage();
  bool pass_is_visible = true;
  bool confirm_pass_is_visible = true;
  final _authService = Get.find<AuthProvider>();

  void doRegister(BuildContext context) async {
    if (key.currentState!.validate()) {
      final auth = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };
      _authService.doRegister(auth).then((Auth res) {
        if (res.success!) {
          setEmptyRegister();
          Get.snackbar("Message", 'Register Successfully',
              colorText: Colors.white, backgroundColor: greenColor);
        }
      });
    }
  }

  void setEmptyRegister() {
    nameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
