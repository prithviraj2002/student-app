import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintTextStyle;
  final TextEditingValue? value;
  final FormFieldValidator<String?>? validator;
  final TextInputType? textInputType;
  final int maxLength;
  final bool showCounter;
  final bool? isEnabled;

  const CommonTextField({
    required this.controller,
    required this.hintText,
    this.hintTextStyle,
    this.maxLength = 100,
    this.showCounter = false,
    this.value,
    this.validator,
    this.textInputType,
    this.isEnabled,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled ?? true,
      controller: controller,
      keyboardType: textInputType ?? TextInputType.text,
      validator: value == null ? validator ?? (String? value){
        if(value == null || value.isEmpty){
          return "Empty value";
        }
        else if(value.length > maxLength){
          return "Too many characters!";
        }
        else{
          return null;
        }
      } : null,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          semanticCounterText: showCounter ? maxLength.toString() : null,
          hintStyle: hintTextStyle ?? TextStyle(
            color: Colors.grey,
          )
      ),
    );
  }
}
