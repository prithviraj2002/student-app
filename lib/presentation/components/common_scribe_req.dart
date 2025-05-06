import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_bloc.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_bloc.dart';
import 'package:student/presentation/requests/cubit/select_scribe_cubit.dart';
import 'package:student/presentation/requests/views/add_scribe_review.dart';
import 'package:student/presentation/requests/views/complete_request_view.dart';
import 'package:student/presentation/requests/views/req_detail_view.dart';

class CommonScribeRequest extends StatelessWidget {
  final ScribeRequest request;
  const CommonScribeRequest({
    required this.request,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: request.scribeId!.isNotEmpty ? 280 : 260, width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(request.examName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                const SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(request.subject, style: TextStyle(color: Colors.black45, fontSize: 18),),
                    Text(" | ", style: TextStyle(color: Colors.black45, fontSize: 18),),
                    Text(request.board, style: TextStyle(color: Colors.black45, fontSize: 18),)
                  ],
                ),
                const SizedBox(height: 12,),
                Text(
                  "Date: ${DateFormat.yMMMMEEEEd().format(DateTime.parse(request.date))}", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                const SizedBox(height: 4,),
                Text("Requirement: ${request.language.toUpperCase()} Scribe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                const SizedBox(height: 20,),
                request.scribeId!.isNotEmpty ?
                Text(
                  "Scribe selected!: ${request.language.toUpperCase()} Scribe",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                : Container(),
                request.scribeId!.isNotEmpty ? const SizedBox(height: 12,) : Container(),
                Row(
                  children: [
                    Expanded(
                      child: request.isComplete ?
                          OutlinedButton(
                              onPressed: () {}, child: Center(child: Text("Completed")))
                          : OutlinedButton(
                          onPressed: () {
                            if(request.scribeId!.isEmpty){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(create: (ctx) => ReqDetailBloc()),
                                          BlocProvider(create: (ctx) => ScribeCubit()),
                                        ],
                                        child: CompleteRequestView(req: request),
                                      )
                                  )
                              );
                            }
                            else{
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => BlocProvider(
                                        create: (ctx) => ScribeReviewBloc(),
                                        child: AddScribeReview(
                                            req: request,
                                          selectedScribeId: request.scribeId!,
                                        ),
                                      )
                                  )
                              );
                            }
                          },
                          child: Center(child: Text("Mark as completed"))
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: CommonLongButton(
                        text: "View Details",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => BlocProvider(
                                    create: (ctx) => ReqDetailBloc(),
                                    child: ReqDetailView(req: request),
                                  )
                              )
                          );
                        },
                        height: 32, fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
