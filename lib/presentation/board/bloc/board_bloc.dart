import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/domain/repo/request_repo.dart';
import 'package:student/presentation/board/bloc/board_event.dart';
import 'package:student/presentation/board/bloc/board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState>{
  final RequestRepo repo = getIt<RequestRepo>();

  BoardBloc(): super(InitialState()){
    on<GetOngoingReq>((event, emit) async{
      emit(OngoingReqLoading());
      try{
        List<ScribeRequest> ongoingReqs = await repo.getOngoingReq();
        List<ScribeRequest> completedReqs = await repo.getCompletedReq();

        emit(OngoingReqData(reqs: ongoingReqs.reversed.toList(), completedReqs: completedReqs.reversed.toList()));
      } catch(e){
        emit(OngoingReqError(errorMsg: e.toString()));
      }
    });
  }
}