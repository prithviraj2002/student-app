import 'package:flutter/material.dart';
import 'package:student/presentation/components/common_text_field.dart';

class CommonPage extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const CommonPage({
    super.key,
    required this.title,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        const SizedBox(height: 12,),
        CommonTextField(
            controller: controller,
            hintText: title
        ),
      ],
    );
  }
}
