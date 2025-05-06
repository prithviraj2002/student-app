import 'package:bloc/bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/domain/repo/request_repo.dart';

class ScribeCubit extends Cubit<ScribeModel?>{
  RequestRepo repo = getIt<RequestRepo>();

  ScribeCubit(): super(null);

  void selectScribe(ScribeModel scribe){
    emit(scribe);
  }

  void resetSelection(){
    emit(null);
  }

  Future<void> selectScribeAndCloseReq(String id) async{
    if(state != null){
      await repo.updateScribeReq(id, {
        "scribeId": state!.contact,
        "isOpen": false
      });
    }
  }
}