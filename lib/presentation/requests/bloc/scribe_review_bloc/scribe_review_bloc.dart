import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/model/review_model/review_model.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/domain/repo/request_repo.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_event.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_state.dart';

class ScribeReviewBloc extends Bloc<ScribeReviewEvent, ScribeReviewState>{
  RequestRepo repo = getIt<RequestRepo>();
  FirebaseAuth auth = FirebaseAuth.instance;

  ScribeReviewBloc(): super(InitialState()){
    on<CreateScribeReview>((event, emit) async{
      emit(ScribeReviewLoading());
      try{
        await repo.createScribeReview(
            ReviewModel(
                scribeId: event.scribeId,
                studentId: auth.currentUser!.phoneNumber!,
                reviewText: event.reviewText,
                createdAt: DateTime.now().toString(),
                rating: event.rating
            )
        );

        emit(ScribeReviewDone());
      } catch(e){
        emit(ScribeReviewError(errorMsg: e.toString()));
      }
    });

    on<CompleteReq>((event, emit) async{
      emit(CompleteReqLoading());
      try{
        await repo.updateScribeReq(
            event.id,
            {
              'isComplete': true,
              'isOpen': false,
              'scribeId': event.selectedScribeId
            }
          );

        emit(CompleteReqDone());
      } catch(e){
        emit(CompleteReqError(errorMsg: e.toString()));
      }
    });
  }

  Future<ScribeModel> getScribeFromId(String id) async{
    return await repo.getScribeFromId(id);
  }
}