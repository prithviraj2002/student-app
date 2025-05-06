import 'package:flutter/material.dart';
import 'package:student/presentation/components/common_text_field.dart';

class TimePage extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const TimePage({
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
            TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now()
            );

            if(time != null){
              controller.text = time.toString();
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
