import 'package:airsoft_app/model/product.dart';
import 'package:airsoft_app/widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mixins/constant.dart';

class AppBarButton extends StatefulWidget {
  AppBarButton({Key? key, this.product}) : super(key: key);

  Product? product;

  @override
  State<AppBarButton> createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconButton(
            icon: Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Get.back();
            },
          ),
          iconButton(
            icon: widget.product!.isFavorite!
                ? Icons.favorite
                : Icons.favorite_border,
            color: widget.product!.isFavorite! ? red : iconColor,
            size: 15,
            padding: 12,
            isOutLine: false,
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
        ],
      ),
    );
  }
}
