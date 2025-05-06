import 'package:flutter/material.dart';
import 'package:student/domain/model/student_model/language_model.dart';
import 'package:student/presentation/create_scribe_req/components/lang_chip.dart';
import 'package:student/presentation/create_scribe_req/cubit/lang_cubit.dart';

class LangList extends StatelessWidget {
  final LanguageCubit langCubit;
  const LangList({required this.langCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index){
            return LangChip(
                cubit: langCubit,
                language: Language.values[index]
            );
          },
          separatorBuilder: (ctx, index){
            return const SizedBox(width: 12,);
          },
          itemCount: Language.values.length
      ),
    );
  }
}
