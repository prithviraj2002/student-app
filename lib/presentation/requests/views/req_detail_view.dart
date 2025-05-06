import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_bloc.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_event.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_state.dart';
import 'package:student/presentation/requests/components/scribe_tile.dart';

class ReqDetailView extends StatefulWidget {
  final ScribeRequest req;
  const ReqDetailView({required this.req, super.key});

  @override
  State<ReqDetailView> createState() => _ReqDetailViewState();
}

class _ReqDetailViewState extends State<ReqDetailView> {
  late ReqDetailBloc bloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<ReqDetailBloc>();
    bloc.add(GetInterestedScribes(reqId: widget.req.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.req.examName),
      ),
      body: BlocConsumer<ReqDetailBloc, ReqDetailState>(
          builder: (BuildContext ctx, ReqDetailState state){
            if(state is LoadingInterestedScribes){
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is FailedInterestedScribes){
              return const Center(child: Text("Failed to get interested scribes!"));
            }
            else if(state is InterestedScribesData){
              List<ScribeModel> scribes = state.scribes;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      widget.req.scribeId!.isNotEmpty ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Selected scribe",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                      ) : Container(),
                      widget.req.scribeId!.isNotEmpty ? const SizedBox(height: 12,) : Container(),
                      widget.req.scribeId!.isNotEmpty ? FutureBuilder<ScribeModel>(
                          future: bloc.getScribeFromId(widget.req.scribeId!),
                          builder: (BuildContext ctx, AsyncSnapshot snapshot){
                            if(snapshot.hasData){
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ScribeTile(
                                    scribe: snapshot.data,
                                    scribeReqId: widget.req.id
                                ),
                              );
                            }
                            else if(snapshot.hasError){
                              return Center(child: Text("Could not get requested scribe details!"));
                            }
                            else if(snapshot.connectionState == ConnectionState.waiting){
                              return Center(child: CircularProgressIndicator());
                            }
                            else{
                              return Container();
                            }
                          }
                      ) : Container(),
                      widget.req.scribeId!.isNotEmpty ? const SizedBox(height: 12,) : Container(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Interested scribes",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                      ),
                      const SizedBox(height: 12,),
                      scribes.isNotEmpty ?
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, int index) {
                              return BlocProvider.value(
                                value: bloc,
                                  child: ScribeTile(
                                      scribe: scribes[index],
                                    scribeReqId: widget.req.id,
                                  )
                              );
                            },
                            separatorBuilder: (BuildContext ctx, int index) {
                              return Container();
                            },
                            itemCount: scribes.length
                        ),
                      ) : SizedBox(
                          height: 100,
                          child: Card(
                              color: Colors.white,
                              child: Center(
                                  child: Text("No scribes have applied yet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                              )
                          )
                      ),
                      const SizedBox(height: 12,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Exam Details",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                      ),
                      const SizedBox(height: 12,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12,),
                              ListTile(
                                title: Text("Exam name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                subtitle: Text(widget.req.examName, style: TextStyle(fontSize: 18),),
                              ),
                              ListTile(
                                title: Text("Subject", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                subtitle: Text(widget.req.subject, style: TextStyle(fontSize: 18),),
                              ),
                              ListTile(
                                title: Text("Language", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                subtitle: Text(widget.req.language, style: TextStyle(fontSize: 18),),
                              ),
                              ListTile(
                                title: Text("Date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                subtitle: Text(DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.req.date)), style: TextStyle(fontSize: 18),),
                              ),
                              ListTile(
                                title: Text("Time", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                subtitle: Text(widget.req.time, style: TextStyle(fontSize: 18),),
                              ),
                              ListTile(
                                title: Text("Duration", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                subtitle: Text("${widget.req.duration} hours", style: TextStyle(fontSize: 18),),
                              ),
                              ListTile(
                                title: Text("Exam center", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                subtitle: Text("${widget.req.address}, ${widget.req.city}, ${widget.req.pincode}", style: TextStyle(fontSize: 18),),
                              ),
                              ListTile(
                                title: Text("Board", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                subtitle: Text(widget.req.board, style: TextStyle(fontSize: 18),),
                              ),
                              const SizedBox(height: 12,),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                    ],
                  ),
                ),
              );
            }
            else{
              return const Center(child: Text("Something went wrong!"));
            }
          },
          listener: (BuildContext ctx, ReqDetailState state){
            if(state is FailedInterestedScribes){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("An error occurred!")));
            }
          }
      ),
    );
  }
}
