import 'package:bloc/bloc.dart';
import 'package:student/domain/model/student_model/language_model.dart';

class LanguageCubit extends Cubit<List<Language>>{
  LanguageCubit(): super([]);

  void addLang(Language lang){
    emit([...state, lang]);
  }

  void removeLang(Language lang){
    emit(state.where((t) => t != lang).toList());
  }

  void selectAll(){
    emit([...Language.values]);
  }

  void unselectAll(){
    emit([]);
  }

  void setLangList(List<Language> lang){
    emit(lang);
  }
}