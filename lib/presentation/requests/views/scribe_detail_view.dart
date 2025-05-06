import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/core/pages/app_pages.dart';
import 'package:student/domain/model/review_model/review_model.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/domain/model/student_model/gender_model.dart';
import 'package:student/domain/model/student_model/language_model.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/components/common_review_tile.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_bloc.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_event.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_state.dart';
import 'package:student/presentation/requests/bloc/review_bloc/review_bloc.dart';
import 'package:student/presentation/requests/bloc/review_bloc/review_state.dart';
import 'package:student/presentation/requests/bloc/student_bloc/student_bloc.dart';
import 'package:student/presentation/requests/bloc/student_bloc/student_event.dart';
import 'package:url_launcher/url_launcher.dart';

class ScribeDetailView extends StatefulWidget {
  final ScribeModel scribe; final String scribeReqId;
  const ScribeDetailView({required this.scribe, required this.scribeReqId, super.key});

  @override
  State<ScribeDetailView> createState() => _ScribeDetailViewState();
}

class _ScribeDetailViewState extends State<ScribeDetailView> {
  late ReviewBloc reviewBloc;
  late ReqDetailBloc reqBloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    reviewBloc = context.read<ReviewBloc>();
    reqBloc = context.read<ReqDetailBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ReqDetailBloc, ReqDetailState>(
        listener: (BuildContext context, ReqDetailState state) {
          if(state is ScribeSelectLoading){
            showAboutDialog(
                context: context,
                applicationName: "Selecting...",
                children: [
                  Center(child: CircularProgressIndicator())
                ]
            );
          }
          else if(state is ScribeSelectSuccess){
            Navigator.pop(context);
            showAboutDialog(
                context: context,
                applicationName: "Scribe selected successfully!",
                children: [
                  Center(child: Icon(Icons.check, color: Colors.green, size: 24,))
                ]
            );
            Future.delayed(Duration(seconds: 5), () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (dynamic) => false);
            });
          }
          else if(state is ScribeSelectError){
            Navigator.pop(context);
            showAboutDialog(
                context: context,
                applicationName: "Error",
                children: [
                  Center(child: Text("An error occurred!", style: TextStyle(fontSize: 24),))
                ]
            );
            reqBloc.add(GetInterestedScribes(reqId: widget.scribeReqId));
          }
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Scribe details",
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
                          title: Text("Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(widget.scribe.name, style: TextStyle(fontSize: 18),),
                        ),
                        ListTile(
                          title: Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(widget.scribe.email, style: TextStyle(fontSize: 18),),
                        ),
                        ListTile(
                          title: Text("Gender", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(getStringFromGender(widget.scribe.gender), style: TextStyle(fontSize: 18),),
                        ),
                        ListTile(
                          title: Text("Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text("${widget.scribe.address}, ${widget.scribe.city}, ${widget.scribe.pincode}", style: TextStyle(fontSize: 18),),
                        ),
                        ListTile(
                          title: Text("Age", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(widget.scribe.age.toString(), style: TextStyle(fontSize: 18),),
                        ),
                        ListTile(
                          title: Text("Languages known", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Row(
                            children:[
                              Wrap(
                                spacing: 10,
                              children: List.generate(
                                  widget.scribe.langKnown.length,
                                      (int index) => Center(child: Text(
                                          getStringFromLanguage(widget.scribe.langKnown[index]).toUpperCase(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      )
                              ),
                            ),
                            ]
                          )
                        ),
                        const SizedBox(height: 12,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reviews",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                ),
                BlocBuilder<ReviewBloc, ReviewState>(
                    builder: (BuildContext ctx, ReviewState state){
                      if(state is ReviewErrorState){
                        return Center(child: Text("Could not get reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),));
                      }
                      else if(state is ReviewLoadingState){
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if(state is ReviewDataState){
                        List<ReviewModel> reviews = state.reviews;

                        if(reviews.isEmpty){
                          return const Center(child: Text("No reviews added yet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),));
                        }
                        else{
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ListView.separated(
                              shrinkWrap: true,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return BlocProvider(
                                    create: (ctx) => StudentBloc()..add(GetStudentData(studentId: reviews[index].studentId)),
                                      child: CommonReviewTile(review: reviews[index]));
                                },
                                separatorBuilder: (BuildContext ctx, int index){
                                  return const Divider();
                                },
                                itemCount: reviews.length),
                          );
                        }
                      }
                      else{
                        return Container();
                      }
                    }
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                reqBloc.add(SelectScribe(
                  scribeReqId: widget.scribeReqId,
                    scribeId: widget.scribe.contact));
              },
              child: Container(
                height: 52,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: AppColors.primaryColor)
                ),
                child: Center(child: Text("Select Scribe", style: TextStyle(color: AppColors.primaryColor, fontSize: 24),)),
              ),
            )
          ),
          const SizedBox(height: 12,),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CommonLongButton(
                text: "Call scribe",
                onTap: () {
                  launchUrl(Uri.parse('tel:${widget.scribe.contact}'));
                }
            ),
          ),
        ],
      ),
    );
  }
}
