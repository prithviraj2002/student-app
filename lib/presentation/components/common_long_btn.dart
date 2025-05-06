import 'package:flutter/material.dart';
import 'package:student/core/colors/app_colors.dart';

class CommonLongButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double fontSize;
  final double height;
  const CommonLongButton({
    required this.text,
    required this.onTap,
    this.fontSize = 24,
    this.height = 52,
    super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: height, width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: fontSize),)),
        )
    );
  }
}
