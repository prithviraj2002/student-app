import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/model/review_model/review_model.dart';
import 'package:student/domain/repo/request_repo.dart';
import 'package:student/presentation/requests/bloc/review_bloc/review_event.dart';
import 'package:student/presentation/requests/bloc/review_bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState>{
  final RequestRepo repo = getIt<RequestRepo>();

  ReviewBloc(): super(InitialState()){
    on<GetReviews>((event, emit) async{
      emit(ReviewLoadingState());
      try{
        List<ReviewModel> reviews = await repo.getScribeReviews(event.scribeId);

        emit(ReviewDataState(reviews: reviews));
      } catch(e){
        emit(ReviewErrorState(errorMsg: e.toString()));
      }
    });
  }
}