import 'package:flutter/material.dart';
import 'package:student/presentation/components/common_text_field.dart';

class DatePage extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const DatePage({
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
        InkWell(
          onTap: () async{
            DateTime? date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1)
            );

            if(date != null){
              controller.text = date.toString();
            }
          },
          child: CommonTextField(
            isEnabled: false,
              controller: controller,
              hintText: title
          ),
        )
      ],
    );
  }
}
