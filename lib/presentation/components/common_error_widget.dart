import 'package:flutter/material.dart';

class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(child: Text("Something went wrong!"))
    );
  }
}
