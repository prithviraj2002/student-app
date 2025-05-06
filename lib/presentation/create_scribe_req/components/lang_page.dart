import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/domain/model/student_model/language_model.dart';
import 'package:student/presentation/create_scribe_req/components/lang_list.dart';
import 'package:student/presentation/create_scribe_req/cubit/lang_cubit.dart';

class LangPage extends StatelessWidget {
  const LangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectLanguage, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        const SizedBox(height: 40,),
        BlocBuilder<LanguageCubit, List<Language>>(
          builder: (BuildContext context, List<Language> language) {
            return LangList(langCubit: context.read<LanguageCubit>());
          },
        ),
      ],
    );
  }
}
