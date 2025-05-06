import 'package:flutter/material.dart';
import 'package:student/domain/model/student_model/gender_model.dart';
import 'package:student/presentation/register/components/gender_chip.dart';
import 'package:student/presentation/register/cubit/gender_cubit.dart';

class GenderList extends StatelessWidget {
  final GenderCubit genderCubit;
  const GenderList({required this.genderCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index){
            return GenderChip(
                cubit: genderCubit,
                gender: Gender.values[index]
            );
          },
          separatorBuilder: (ctx, index){
            return const SizedBox(width: 12,);
          },
          itemCount: Gender.values.length
      ),
    );
  }
}
