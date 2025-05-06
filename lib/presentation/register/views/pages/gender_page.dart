import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/domain/model/student_model/gender_model.dart';
import 'package:student/presentation/register/components/gender_list.dart';
import 'package:student/presentation/register/cubit/gender_cubit.dart';

class GenderPage extends StatelessWidget {
  const GenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectGender, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        const SizedBox(height: 40,),
        BlocBuilder<GenderCubit, Gender>(
            builder: (BuildContext context, Gender gender) {
              return GenderList(genderCubit: context.read<GenderCubit>());
          },
        ),
      ],
    );
  }
}
