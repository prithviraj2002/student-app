import 'dart:async';
import 'package:bloc/bloc.dart';

class TimerCubit extends Cubit<int>{
  Timer? _timer;
  final int initialTime;

  TimerCubit({this.initialTime = 45}) : super(initialTime);

  void startTimer() {
    emit(initialTime);
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}