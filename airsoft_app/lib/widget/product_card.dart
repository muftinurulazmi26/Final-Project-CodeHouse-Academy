import 'package:airsoft_app/pages/product_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:airsoft_app/mixins/server.dart';
import 'package:airsoft_app/widget/title_text.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../mixins/constant.dart';
import '../model/product.dart';
import '../theme.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    this.product,
    this.onSelected,
  }) : super(key: key);

  Product? product;
  ValueChanged<Product>? onSelected;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailPage(
          product: widget.product,
        ));
      },
      child: Expanded(
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
            ],
          ),
          margin: EdgeInsets.symmetric(
              vertical: !widget.product!.isSelected! ? 20 : 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      widget.product!.isFavorite!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.product!.isFavorite! ? red : iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        if (widget.product!.isFavorite == false) {
                          widget.product!.isFavorite = true;
                        } else {
                          widget.product!.isFavorite = false;
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_rounded,
                      color: red,
                    ),
                    onPressed: () {
                      // setState(() {

                      // });
                      Get.defaultDialog(
                          title: "Delete Product",
                          radius: 10.0,
                          textCancel: "Cancel",
                          textConfirm: "Yes",
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            homeController.deleteProduct(widget.product!.id!);
                          },
                          onCancel: () {},
                          content: Container());
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: widget.product!.isSelected! ? 15 : 0),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          // CircleAvatar(
                          //   radius: 40,
                          //   backgroundColor: orange.withAlpha(40),
                          // ),
                          Hero(
                            tag: widget.product!.id.toString(),
                            child: CachedNetworkImage(
                              width: 150,
                              imageUrl:
                                  Server.basePhoto + widget.product!.photo!,
                              imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                              ),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(height: 5),
                    TitleText(
                      text: widget.product!.name,
                      fontSize: widget.product!.isSelected! ? 16 : 14,
                    ),
                    TitleText(
                      text: widget.product!.price.toString(),
                      fontSize: widget.product!.isSelected! ? 18 : 16,
                    ),
                    TitleText(
                      text: widget.product!.description,
                      fontSize: widget.product!.isSelected! ? 14 : 12,
                      color: orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
