import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/presentation/components/common_scribe_req.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_bloc.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_events.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_states.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  late RequestBloc bloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<RequestBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.yourReq),
      ),
      body: BlocConsumer<RequestBloc, RequestState>(
          builder: (BuildContext ctx, RequestState state){
            if(state is LoadingScribeReq){
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is ScribeReqError){
              return const Center(child: Text("Something went wrong!"));
            }
            else if(state is ScribeReqData){
              final List<ScribeRequest> requests = state.requests;

              if(requests.isEmpty){
                return const Center(child: Text("No scribe requests created yet!"));
              }
              else{
                return RefreshIndicator(
                  onRefresh: () async{
                    bloc.add(GetScribeReq());
                  },
                  child: ListView.separated(
                      itemBuilder: (ctx, index){
                        return CommonScribeRequest(
                            request: requests[index]
                        );
                      },
                      separatorBuilder: (ctx, index){
                        return const SizedBox(height: 12,);
                      },
                      itemCount: requests.length
                  ),
                );
              }
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, RequestState state){
            if(state is ScribeReqError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
          }
      ),
    );
  }
}
