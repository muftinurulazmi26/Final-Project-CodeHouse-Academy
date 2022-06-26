import 'package:airsoft_app/mixins/network/binding.dart';
import 'package:airsoft_app/pages/home.dart';
import 'package:airsoft_app/pages/login.dart';
import 'package:airsoft_app/pages/product_detail.dart';
import 'package:airsoft_app/pages/register.dart';
import 'package:airsoft_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';

import 'injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Airsoft App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBinding(),
      initialRoute: "/splash",
      getPages: [
        GetPage(
            name: "/splash",
            page: ()=>SplashPage(),
            binding: Injector()
        ),
        GetPage(
            name: "/login",
            page: ()=>LoginPage(),
            binding: Injector()
        ),
        GetPage(
            name: "/register",
            page: ()=>RegisterPage(),
            binding: Injector()
        ),
        GetPage(
            name: "/home",
            page: ()=>HomePage(),
            binding: Injector()
        ),
        GetPage(
            name: "/detail",
            page: ()=>ProductDetailPage(),
            binding: Injector()
        ),
        // GetPage(
        //     name: "/profile",
        //     page: ()=>ProfilePage(),
        //     binding: Injector()
        // )
      ],
    );
  }
}
