import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/presentation/board/bloc/board_bloc.dart';
import 'package:student/presentation/board/bloc/board_event.dart';
import 'package:student/presentation/board/bloc/board_state.dart';
import 'package:student/presentation/components/common_scribe_req.dart';

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  late BoardBloc bloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<BoardBloc>();
    bloc.add(GetOngoingReq());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request Board")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "On-going requests",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text("Requests where you have selected a scribe for your scribe request, will be visible here", style: TextStyle(fontSize: 20),),
              const SizedBox(height: 12),
              BlocBuilder<BoardBloc, BoardState>(
                builder: (BuildContext ctx, BoardState state) {
                  if (state is OngoingReqData) {
                    List<ScribeRequest> ongoingReqs = state.reqs;
                    List<ScribeRequest> completedReqs = state.completedReqs;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ongoingReqs.isNotEmpty
                            ? SizedBox(
                              height: 280,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return CommonScribeRequest(
                                    request: ongoingReqs[index],
                                  );
                                },
                                separatorBuilder: (
                                  BuildContext ctx,
                                  int index,
                                ) {
                                  return const SizedBox(width: 12);
                                },
                                itemCount: ongoingReqs.length,
                              ),
                            )
                            : const Center(
                              child: Text(
                                "No ongoing requests",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        const SizedBox(height: 12),
                        Text(
                          "Completed requests",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Requests marked as completed by you, will be visible here", style: TextStyle(fontSize: 20),),
                        const SizedBox(height: 20),
                        completedReqs.isNotEmpty
                            ? SizedBox(
                              height: 280,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return CommonScribeRequest(
                                    request: completedReqs[index],
                                  );
                                },
                                separatorBuilder: (
                                  BuildContext ctx,
                                  int index,
                                ) {
                                  return const SizedBox(width: 12);
                                },
                                itemCount: completedReqs.length,
                              ),
                            )
                            : const Center(
                              child: Text(
                                "No completed requests",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      ],
                    );
                  }
                  else if(state is OngoingReqError){
                    return const Center(child: Text("An error occurred", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),));
                  }
                  else if(state is OngoingReqLoading){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else{
                    return const Center(child: Text("Something went wrong", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
