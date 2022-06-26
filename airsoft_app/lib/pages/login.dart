import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/login_controller.dart';
import '../mixins/constant.dart';
import '../theme.dart';
import '../widget/background.dart';
import '../widget/custom_surfix_icon.dart';
import '../widget/size_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController loginController;
  String? email;
  String? password;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  void initState() {
    // initShared();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginController = Get.find<LoginController>();
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Form(
              key: loginController.key,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 18,
                          color: blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(
                      "Sign In to continue",
                      style: TextStyle(color: greyColor),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    buildEmailFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildPassFormField(),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    GestureDetector(
                      onTap: () {
                        loginController.doLogin(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greenColor),
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 234,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont’t have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: greyColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed("/register");
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPassFormField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      controller: loginController.passwordController,
      obscureText: loginController.is_visible,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            if (loginController.is_visible) {
              loginController.is_visible = false;
            } else {
              loginController.is_visible = true;
            }
            setState(() {});
          },
          child: (loginController.is_visible)
              ? Image.asset("assets/icons/ic_eye.png")
              : Image.asset("assets/icons/ic_hidden_eye.png"),
        ),
        fillColor: fieldColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
            labelText: "Password",
        hintText: "Enter your password",
      ),
      style: TextStyle(color: blackColor2),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidationRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidationRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      controller: loginController.emailController,
      decoration: InputDecoration(
        fillColor: fieldColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
            labelText: "Email",
        hintText: "Enter your email",
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      style: TextStyle(color: blackColor2),
    );
  }
}
