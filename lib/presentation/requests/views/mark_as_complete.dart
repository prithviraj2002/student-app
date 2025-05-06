import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/core/pages/app_pages.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_bloc.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_event.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_state.dart';

class MarkAsComplete extends StatefulWidget {
  final String selectedScribeId; final String reqId;
  const MarkAsComplete({required this.selectedScribeId, required this.reqId, super.key});

  @override
  State<MarkAsComplete> createState() => _MarkAsCompleteState();
}

class _MarkAsCompleteState extends State<MarkAsComplete> {
  late ScribeReviewBloc bloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<ScribeReviewBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ScribeReviewBloc, ScribeReviewState>(
          listener: (BuildContext ctx, ScribeReviewState state){
            if(state is CompleteReqLoading){
              showDialog(
                  context: context,
                  builder: (BuildContext ctx){
                    return AlertDialog(
                      title: Text("Marking as complete"),
                      content: Center(child: CircularProgressIndicator(),),
                    );
                  }
              );
            }
            else if(state is CompleteReqError){
              showDialog(
                  context: context,
                  builder: (BuildContext ctx){
                    return AlertDialog(
                      title: Text("An error occurred!"),
                      content: Center(child: Text("Try again later"),),
                    );
                  }
              );
            }
            else if(state is CompleteReqDone){
              showDialog(
                  context: context,
                  builder: (BuildContext ctx){
                    return AlertDialog(
                      title: Text("Scribe Request Completed!"),
                      content: Center(child: Icon(Icons.check, color: Colors.green, size: 24,),),
                    );
                  }
              );
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (dynamic) => false);
            }
          },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Review Added, click below to complete request",
                style: TextStyle(
                    fontSize: 24,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50,),
              CommonLongButton(
                  text: "Complete Request",
                  onTap: () {
                    bloc.add(
                        CompleteReq(
                            id: widget.reqId,
                            selectedScribeId: widget.selectedScribeId
                        )
                    );
                  }
              )
            ],
        ),),
      ),
    );
  }
}
