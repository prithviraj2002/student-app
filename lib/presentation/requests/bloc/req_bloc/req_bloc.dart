import 'package:bloc/bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/domain/repo/request_repo.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_events.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_states.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState>{
  RequestRepo repo = getIt<RequestRepo>();

  RequestBloc(): super(InitialRequestState()){
    on<GetScribeReq>((event, emit) async{
      emit(LoadingScribeReq());
      try{

        final response = await repo.getScribeReq();

        if(response['data'] != null){
          List<ScribeRequest> reqs = [];

          for(Map<String, dynamic> req in response['data']){
            reqs.add(ScribeRequest.fromJson(req));
          }

          emit(ScribeReqData(requests: reqs.reversed.toList()));
        }
      } catch(e){
        emit(ScribeReqError(errorMsg: e.toString()));
      }
    });
  }
}