import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/model/review_model/review_model.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/domain/repo/request_repo.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_event.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_state.dart';

class ReqDetailBloc extends Bloc<ReqDetailEvent, ReqDetailState>{
  RequestRepo repo = getIt<RequestRepo>();
  FirebaseAuth auth = FirebaseAuth.instance;

  ReqDetailBloc(): super(InitialState()){
    on<GetInterestedScribes>((event, emit) async{
      emit(LoadingInterestedScribes());

      try{
        List<ScribeModel> scribes = await repo.getInterestedScribes(event.reqId);

        emit(InterestedScribesData(scribes: scribes));
      } catch(e){
        emit(FailedInterestedScribes(errorMsg: e.toString()));
      }
    });

    on<SelectScribe>((event, emit) async{
      emit(ScribeSelectLoading());
      try{
        await repo.updateScribeReq(
            event.scribeReqId,
            {
              'scribeId': "+91${event.scribeId}",
              'isOpen': false
            }
        );

        emit(ScribeSelectSuccess());
      } catch(e){
        emit(ScribeSelectError(errorMsg: e.toString()));
      }
    });
  }

  Future<List<ReviewModel>> getScribeReviews(String id) async{
    return await repo.getScribeReviews(id);
  }

  Future<ScribeModel> getScribeFromId(String id) async{
    return await repo.getScribeFromId(id);
  }

  Future<void> createReview(String scribeId, String review, int rating) async{
    return await repo.createScribeReview(
      ReviewModel(
          scribeId: scribeId,
          studentId: auth.currentUser!.phoneNumber!,
          reviewText: review,
          createdAt: DateTime.now().toString(),
          rating: rating
      )
    );
  }
}