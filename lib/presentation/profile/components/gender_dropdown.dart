import 'package:flutter/material.dart';
import 'package:student/domain/model/student_model/gender_model.dart';
import 'package:student/presentation/register/cubit/gender_cubit.dart';

class GenderDropdown extends StatelessWidget {
  final GenderCubit cubit;
  const GenderDropdown({
    required this.cubit,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Gender>(
        value: cubit.state,
        items: List.generate(
            Gender.values.length,
                (int index) => DropdownMenuItem(
                value: Gender.values[index],
                child: Center(child: Text(getStringFromGender(Gender.values[index]).toUpperCase()))
            )
        ),
        onChanged: (Gender? g){
          if(g != null){
            cubit.selectGender(g);
          }
        }
    );
  }
}
