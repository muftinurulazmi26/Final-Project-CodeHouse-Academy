import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';
import '../widget/size_config.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  late SplashController splashController;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    splashController = Get.find<SplashController>();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Opacity(
                  opacity: 1.0,
                  child: new Image.asset('assets/images/logo.png')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Made With ❤ '),
                      TextSpan(
                          text: 'Azmi',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
