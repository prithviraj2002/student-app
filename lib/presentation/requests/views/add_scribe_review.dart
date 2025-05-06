import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/components/common_text_field.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_bloc.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_event.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_state.dart';
import 'package:student/presentation/requests/components/scribe_tile.dart';
import 'package:student/presentation/requests/views/mark_as_complete.dart';

class AddScribeReview extends StatefulWidget {
  final ScribeRequest req; final String selectedScribeId;

  const AddScribeReview({required this.req, required this.selectedScribeId, super.key});

  @override
  State<AddScribeReview> createState() => _AddScribeReviewState();
}

class _AddScribeReviewState extends State<AddScribeReview> {
  late ScribeReviewBloc bloc;
  TextEditingController reviewController = TextEditingController();
  TextEditingController ratingController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<ScribeReviewBloc>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    reviewController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a review")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: BlocListener<ScribeReviewBloc, ScribeReviewState>(
            listener: (BuildContext context, ScribeReviewState state) {
              if(state is ScribeReviewLoading){
                showDialog(
                    context: context,
                    builder: (BuildContext ctx){
                      return AlertDialog(
                        title: Text("Adding review"),
                        content: Center(child: CircularProgressIndicator(),),
                      );
                    }
                );
              }
              else if(state is ScribeReviewError){
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
              else if(state is ScribeReviewDone){
                // showDialog(
                //     context: context,
                //     builder: (BuildContext ctx){
                //       return AlertDialog(
                //         title: Text("Review Added!"),
                //         content: Center(child: Icon(Icons.check, color: Colors.green, size: 24,),),
                //       );
                //     }
                // );
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (ctx) => BlocProvider.value(
                        value: bloc,
                        child: MarkAsComplete(
                          reqId: widget.req.id,
                          selectedScribeId: widget.selectedScribeId,),
                      )
                  ));
                });
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selected scribe",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 12),
                FutureBuilder<ScribeModel>(
                  future: bloc.getScribeFromId(widget.selectedScribeId),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ScribeTile(
                          scribe: snapshot.data,
                          scribeReqId: widget.req.id,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Could not get requested scribe details!"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  "Leave a remark",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                CommonTextField(
                  controller: reviewController,
                  hintText: "Review",
                ),
                const SizedBox(height: 12),
                Text(
                  "Enter rating out of five",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                CommonTextField(
                  controller: ratingController,
                  hintText: "Rating",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CommonLongButton(text: "Create review", onTap: () {
                  bloc.add(
                      CreateScribeReview(
                          scribeId: widget.selectedScribeId,
                          reviewText: reviewController.text.trim(),
                          rating: int.parse(ratingController.text)
                      )
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
