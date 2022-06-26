import 'package:flutter/material.dart';

import '../mixins/constant.dart';

class iconButton extends StatelessWidget {
  IconData icon;
  Color color;
  double size;
  double padding;
  bool isOutLine;
  Function onPressed;

  iconButton({
    Key? key,
    required this.icon,
    this.color = iconColor,
    this.size = 20,
    this.padding = 10,
    this.isOutLine = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            border: Border.all(
              color: iconColor,
              style: isOutLine ? BorderStyle.solid : BorderStyle.none,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            color: isOutLine ? Colors.transparent : whiteColor,
            boxShadow: const [
              BoxShadow(
                  color: Color(0xfff8f8f8),
                  blurRadius: 5,
                  spreadRadius: 10,
                  offset: Offset(5, 5))
            ]),
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
