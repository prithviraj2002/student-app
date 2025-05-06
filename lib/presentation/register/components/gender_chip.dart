import 'package:flutter/material.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/domain/model/student_model/gender_model.dart';
import 'package:student/presentation/register/cubit/gender_cubit.dart';

class GenderChip extends StatelessWidget {
  final GenderCubit cubit; final Gender gender;
  const GenderChip({required this.cubit, required this.gender, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cubit.selectGender(gender);
      },
      child: Container(
          width: 100,
          decoration: BoxDecoration(
              color: cubit.state == gender ? AppColors.primaryColor : Colors.white,
              border: Border.all(
                color: cubit.state == gender ? AppColors.primaryColor : Colors.black45,
              ),
              borderRadius: BorderRadius.circular(4)
          ),
          child: Center(
            child: Text(
              getStringFromGender(gender).toUpperCase(),
              style: TextStyle(
                  color: cubit.state == gender ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
      ),
    );
  }
}
