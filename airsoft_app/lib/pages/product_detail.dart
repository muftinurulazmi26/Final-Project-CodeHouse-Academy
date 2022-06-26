import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airsoft_app/controller/product_detail_controller.dart';
import 'package:airsoft_app/mixins/constant.dart';
import 'package:airsoft_app/widget/title_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/home_controller.dart';
import '../mixins/server.dart';
import '../model/product.dart';
import '../widget/appbar_button.dart';
import '../widget/size_config.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({
    Key? key,
    this.product,
  }) : super(key: key);

  Product? product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  late ProductDetailController productDetailController;
  late AnimationController controller;
  late Animation<double> animation;
  late HomeController homeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    homeController = Get.find<HomeController>();
    productDetailController = Get.put(ProductDetailController());

    return Scaffold(
      floatingActionButton: floatingButton(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //AppBar
                    AppBarButton(
                      product: widget.product,
                    ),
                    ProductImageDetail(
                      animation: animation,
                      product: widget.product,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleText(
                            text: "Description",
                            fontSize: 14,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${widget.product!.description}',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.mulish(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialogEdit(context);
      },
      backgroundColor: orange,
      child: Icon(
        Icons.mode_edit_outline_outlined,
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
      ),
    );
  }

  void showDialogEdit(BuildContext context) {
    homeController.nameController.text = widget.product!.name!;
    homeController.descriptionController.text = widget.product!.description!;
    homeController.priceController.text = widget.product!.price!.toString();
    Get.defaultDialog(
      title: 'Edit Airsoft',
      radius: 10.0,
      textConfirm: "Edit",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        homeController.editProduct(widget.product!.id.toString());
      },
      onCancel: () {
        homeController.setEmptyAddProduct();
      },
      content: Form(
        key: homeController.keyEdit,
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
                    validator: (String? value) {
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
                    validator: (String? value) {
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
                    homeController.imagePath.value.isNotEmpty
                        ? homeController.imagePath.value
                        : widget.product!.photo.toString(),
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

class ProductImageDetail extends StatelessWidget {
  ProductImageDetail({Key? key, required this.animation, this.product})
      : super(key: key);

  Product? product;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return AnimatedOpacity(
          opacity: animation.value,
          duration: const Duration(
            milliseconds: 500,
          ),
          child: child,
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: 250,
            child: Hero(
              tag: product!.id.toString(),
              child: CachedNetworkImage(
                imageUrl: Server.basePhoto + product!.photo!,
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          TitleText(
            text: '${product!.name}',
            fontSize: 24,
            color: blackColor,
          ),
        ],
      ),
    );
  }
}
