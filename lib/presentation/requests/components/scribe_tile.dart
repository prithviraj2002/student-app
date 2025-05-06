import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/requests/bloc/req_detail_bloc/req_detail_bloc.dart';
import 'package:student/presentation/requests/bloc/review_bloc/review_bloc.dart';
import 'package:student/presentation/requests/bloc/review_bloc/review_event.dart';
import 'package:student/presentation/requests/views/scribe_detail_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ScribeTile extends StatelessWidget {
  final ScribeModel scribe; final String scribeReqId;
  const ScribeTile({required this.scribe, required this.scribeReqId, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200, width: 320,
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
                Text(scribe.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                const SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${scribe.age.toString()} years", style: TextStyle(fontSize: 18),),
                    Text(" | ", style: TextStyle(color: Colors.black45, fontSize: 18),),
                    Text("Lives in ${scribe.city}", style: TextStyle(fontSize: 18),)
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text("Available for HSC exam", style: TextStyle(fontSize: 18),),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (ctx) => ReviewBloc()..add(GetReviews(scribeId: "+91${scribe.contact}")),
                                            ),
                                            BlocProvider.value(value: context.read<ReqDetailBloc>())
                                          ],
                                          child: ScribeDetailView(
                                            scribe: scribe,
                                            scribeReqId: scribeReqId,
                                          )
                                      )
                                  ));
                            },
                            child: Text("View details")
                        )
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: CommonLongButton(
                        text: "Call scribe",
                        onTap: () {
                          launchUrl(Uri.parse('tel:${scribe.contact}'));
                        },
                        height: 32, fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
