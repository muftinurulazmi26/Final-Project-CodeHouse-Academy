import 'package:flutter/material.dart';

const kAppName = "AirsoftApp";
const kConnectionTimeout = 40000;

Color kTextColor = const Color(0xFF757575);
Color primaryColor = const Color(0XFF6A62B7);
Color blackColor = const Color(0xff000000);
Color blackColor2 = const Color(0xff313030);
Color whiteColor = const Color(0xffffffff);
Color greyColor = const Color(0xff6A6A6A);
Color greenColor = const Color(0xff63A375);
Color greyColor3 = const Color(0xff363A3D);
Color greyColor4 = const Color(0xffAEB9C2);
Color greyColor5 = const Color(0xff718493);
Color greyColor6 = const Color(0xff797979);
Color greyColor7 = const Color(0xffAEAEAE);
Color greyColor8 = const Color(0xFF979797);
Color blueColor = const Color(0xff5686E1);
Color fieldColor = const Color(0xffA9BCCF).withOpacity(0.2);
const Color iconColor =  Color(0xffa8a09b);
Color red = const Color(0xffF72804);
Color orange = const Color(0xffE65829);
const Color titleTextColor = Color(0xff1d2635);
const Color subTitleTextColor = Color(0xff797878);
const Color lightGrey = Color(0xffE1E2E4);


const kAnimationDuration = Duration(milliseconds: 200);
const defaultAnimation = Duration(milliseconds: 250);

//Form Error
final RegExp emailValidationRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Password don't match";
const String kNameNullError = "Please Enter your name";
