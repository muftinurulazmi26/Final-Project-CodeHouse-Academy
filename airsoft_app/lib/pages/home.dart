import 'package:airsoft_app/controller/login_controller.dart';
import 'package:airsoft_app/model/product.dart';
import 'package:airsoft_app/widget/product_card.dart';
import 'package:airsoft_app/widget/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../mixins/constant.dart';
import '../theme.dart';
import '../widget/loading_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void selectedIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List pagesList = [
    HomeScreen(),
    // const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: selectedIndex,
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: blueColor),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile"),
        ],
      ),
      body: pagesList[_currentIndex],
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  late HomeController homeController;
  late LoginController loginController;

  @override
  Widget build(BuildContext context) {
    homeController = Get.find<HomeController>();
    loginController = Get.find<LoginController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogAdd(context);
        },
        child: const Icon(
          Icons.save,
        ),
        elevation: 12,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed("/profile");
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/person1.png"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "hi, ${homeController.name.value}",
                          style: TextStyle(
                            color: greyColor3,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        loginController.doLogout(context);
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          "assets/icons/ic_logout.png",
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Welcome to",
                  style: TextStyle(
                    color: greyColor5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 19),
                  child: Text(
                    "Airsoft Apps",
                    style: TextStyle(
                      color: greyColor5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Obx(
                    () => homeController.listProducts.isEmpty
                        ? const LoadingView()
                        : NotificationListener<ScrollNotification>(
                            onNotification:
                                (ScrollNotification scrollNotification) {
                              if (scrollNotification.metrics.pixels ==
                                  scrollNotification.metrics.maxScrollExtent) {
                                if (homeController.isNoLoadMore == false) {
                                  if (homeController.isLoading == false) {
                                    homeController.callAPI();
                                  }
                                }
                              }
                              return true;
                            },
                            child: RefreshIndicator(
                              onRefresh: () async {
                                homeController.callAPI(refresh: true);
                              },
                              child: Container(
                                // margin: EdgeInsets.symmetric(vertical: 10),
                                // width: AppTheme.fullWidth(context),
                                // height: AppTheme.fullWidth(context) * .7,
                                child: GridView(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          childAspectRatio: 4 / 3,
                                          mainAxisSpacing: 30,
                                          crossAxisSpacing: 20),
                                  scrollDirection: Axis.vertical,
                                  children: List.generate(
                                      homeController.listProducts.length,
                                      (index) {
                                    if (index <
                                        homeController.listProducts.length) {
                                      return ProductCard(
                                          product: homeController
                                              .listProducts[index]);
                                    } else {
                                      return LoadingView();
                                    }
                                  }),
                                ),
                              ),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogAdd(BuildContext context) {
    Get.defaultDialog(
      title: 'Add Airsoft',
      radius: 10.0,
      textConfirm: "Save",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        homeController.addProduct();
      },
      onCancel: () {
        homeController.setEmptyAddProduct();
      },
      // cancel: SizedBox(
      //   width: MediaQuery.of(context).size.width * 0.20,
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     child: const Text('Cancel'),
      //     style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(30.0))),
      //   ),
      // ),
      // confirm: SizedBox(
      //   width: MediaQuery.of(context).size.width * 0.20,
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     child: const Text('Save'),
      //     style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(30.0))),
      //   ),
      // ),
      content: Form(
        key: homeController.keyAdd,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          // height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  TextFormField(
                    controller: homeController.nameController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Name tidak boleh kosong!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: greyColor8,
                          width: 4.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  TextFormField(
                    controller: homeController.descriptionController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    validator: (String? value){
                      if (value!.isEmpty) {
                          return "Description tidak boleh kosong!";
                        }
                        return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: greyColor8,
                          width: 4.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  TextFormField(
                    controller: homeController.priceController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    validator: (String? value){
                      if (value!.isEmpty) {
                          return "Price tidak boleh kosong!";
                        }
                        return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Price',
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: greyColor8,
                          width: 4.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      homeController.getImage();
                    },
                    child: const Text('Choose File'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    homeController.imagePath.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
