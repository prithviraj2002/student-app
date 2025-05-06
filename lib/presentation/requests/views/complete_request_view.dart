import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_bloc.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_state.dart';
import 'package:student/presentation/requests/bloc/scribe_review_bloc/scribe_review_bloc.dart';
import 'package:student/presentation/requests/components/scribe_tile.dart';
import 'package:student/presentation/requests/cubit/select_scribe_cubit.dart';
import 'package:student/presentation/requests/views/add_scribe_review.dart';

import '../bloc/req_detail_bloc/req_detail_event.dart';

class CompleteRequestView extends StatefulWidget {
  final ScribeRequest req;
  const CompleteRequestView({required this.req, super.key});

  @override
  State<CompleteRequestView> createState() => _CompleteRequestViewState();
}

class _CompleteRequestViewState extends State<CompleteRequestView> {
  late ReqDetailBloc bloc;
  late ScribeCubit cubit;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<ReqDetailBloc>();
    cubit = context.read<ScribeCubit>();
    bloc.add(GetInterestedScribes(reqId: widget.req.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Scribe"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12,),
              Text("Select scribes from below", style: TextStyle(fontSize: 20),),
              const SizedBox(height: 12,),
              BlocBuilder<ReqDetailBloc, ReqDetailState>(
                  builder: (BuildContext ctx, ReqDetailState state){
                    if(state is InterestedScribesData){
                      List<ScribeModel> scribes = state.scribes;

                      if(scribes.isEmpty){
                        return Center(child: Text("No scribes here", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),));
                      }
                      else if(scribes.isNotEmpty){
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: BlocBuilder<ScribeCubit, ScribeModel?>(
                            builder: (BuildContext ctx, ScribeModel? scribe){
                              return ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return BlocProvider.value(
                                        value: bloc,
                                        child: InkWell(
                                          onTap: () {
                                            if(scribe != scribes[index]){
                                              cubit.selectScribe(scribes[index]);
                                            }
                                            else{
                                              cubit.resetSelection();
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: scribe != null ? scribe.contact == scribes[index].contact ?
                                                  Border.all(color: AppColors.primaryColor)
                                                  : Border.all(color: Colors.white)
                                                  : Border.all(color: Colors.white)
                                            ),
                                            child: ScribeTile(
                                              scribe: scribes[index],
                                              scribeReqId: widget.req.id,
                                            ),
                                          ),
                                        )
                                    );
                                  },
                                  separatorBuilder: (BuildContext ctx, int index) {
                                    return Container();
                                  },
                                  itemCount: scribes.length
                              );
                            },
                          ),
                        );
                      }
                      else{
                        return Container();
                      }
                    }
                    else if(state is LoadingInterestedScribes){
                      return const Center(
                        child: CircularProgressIndicator()
                      );
                    }
                    else if(state is FailedInterestedScribes){
                      return const Center(child: Text("An error occurred getting scribes data", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),);
                    }
                    else{
                      return const Center(child: Text("Something went wrong", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),);
                    }
                  }
              ),
              const SizedBox(height: 12,),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder<ScribeCubit, ScribeModel?>(
          builder: (BuildContext ctx, ScribeModel? scribe){
            if(scribe != null){
              return CommonLongButton(
                  text: "Add a review",
                  onTap: () {
                    if(cubit.state != null){
                      cubit.selectScribeAndCloseReq(widget.req.id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                create: (ctx) => ScribeReviewBloc(),
                                child: AddScribeReview(
                                  req: widget.req,
                                  selectedScribeId: widget.req.scribeId!,
                                ),
                              )
                          )
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select a scribe")));
                    }
                  }
              );
            }
            else{
              return CommonLongButton(
                  text: "No scribe to select", onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No scribe to select")));
              });
            }
          }
      )
    );
  }
}
