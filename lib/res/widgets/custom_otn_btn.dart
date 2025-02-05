import 'package:flutter/material.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/widgets/reusable_text.dart';

class CustomOtnlBtn extends StatelessWidget {
  const CustomOtnlBtn({super.key, 
  this.onTap, 
  required this.width, 
  required this.height,
   this.color2, 
   required this.color,
    required this.text
    });

  final void Function()? onTap;
  final double width;
  final double height;
  final Color? color2;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1,color: color),
        ),
        child: Center(
          child: ReusableText(text: text,
          style: appStyle(18, color, FontWeight.bold),
          ),
        ),
      ),
    );
  }
}