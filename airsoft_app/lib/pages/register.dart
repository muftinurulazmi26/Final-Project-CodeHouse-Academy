import 'package:airsoft_app/mixins/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/register_controller.dart';
import '../widget/background.dart';
import '../widget/custom_surfix_icon.dart';
import '../widget/form_error.dart';
import '../widget/size_config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterController registerController;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  bool remember = false;
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
  Widget build(BuildContext context) {
    registerController = Get.find<RegisterController>();
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Form(
              key: registerController.key,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.offAllNamed("/login");
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 18,
                              color: blackColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(
                      "Register to create an account",
                      style: TextStyle(color: greyColor),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    buildNameFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildEmailFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildPassFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildConfirmPassFormField(),
                    FormError(errors: errors),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    GestureDetector(
                      onTap: () {
                        // saveToPref();
                        registerController.doRegister(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greenColor),
                        child: Center(
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 145,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: greyColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed("/login");
                          },
                          child: Text(
                            "Log in",
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

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      controller: registerController.confirmPasswordController,
      obscureText: registerController.confirm_pass_is_visible,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            if (registerController.confirm_pass_is_visible) {
              registerController.confirm_pass_is_visible = false;
            } else {
              registerController.confirm_pass_is_visible = true;
            }
            setState(() {});
          },
          child: (registerController.confirm_pass_is_visible)
              ? Image.asset("assets/icons/ic_eye.png")
              : Image.asset("assets/icons/ic_hidden_eye.png"),
        ),
        fillColor: fieldColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        labelText: "Confirm Password",
        hintText: "Re-enter your Password",
      ),
      style: TextStyle(color: blackColor2),
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
      controller: registerController.passwordController,
      obscureText: registerController.pass_is_visible,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            if (registerController.pass_is_visible) {
              registerController.pass_is_visible = false;
            } else {
              registerController.pass_is_visible = true;
            }
            setState(() {});
          },
          child: (registerController.pass_is_visible)
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
      controller: registerController.emailController,
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

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      controller: registerController.nameController,
      decoration: InputDecoration(
        fillColor: fieldColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        labelText: "Name",
        hintText: "Enter Name",
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
      ),
      style: TextStyle(color: blackColor2),
    );
  }
}
