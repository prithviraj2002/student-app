import 'package:flutter/material.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/domain/model/student_model/language_model.dart';
import 'package:student/presentation/create_scribe_req/cubit/lang_cubit.dart';

class LangChip extends StatelessWidget {
  final LanguageCubit cubit; final Language language;
  const LangChip({required this.cubit, required this.language, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(cubit.state.contains(language)){
          cubit.removeLang(language);
        }
        else{
          cubit.addLang(language);
        }
      },
      child: Container(
          width: 100,
          decoration: BoxDecoration(
              color: cubit.state.contains(language) ? AppColors.primaryColor : Colors.white,
              border: Border.all(
                color: cubit.state.contains(language) ? AppColors.primaryColor : Colors.black45,
              ),
              borderRadius: BorderRadius.circular(4)
          ),
          child: Center(
            child: Text(
              getStringFromLanguage(language).toUpperCase(),
              style: TextStyle(
                  color: cubit.state.contains(language) ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
      ),
    );
  }
}
