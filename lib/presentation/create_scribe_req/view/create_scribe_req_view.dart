import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/create_scribe_req/bloc/create_scribe_req_bloc.dart';
import 'package:student/presentation/create_scribe_req/bloc/create_scribe_req_event.dart';
import 'package:student/presentation/create_scribe_req/bloc/create_scribe_req_state.dart';
import 'package:student/presentation/register/cubit/page_cubit.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_bloc.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_events.dart';

class CreateScribeReqView extends StatefulWidget {
  const CreateScribeReqView({super.key});

  @override
  State<CreateScribeReqView> createState() => _CreateScribeReqViewState();
}

class _CreateScribeReqViewState extends State<CreateScribeReqView> {
  late CreateScribeReqBloc bloc;
  late PageCubit pageCubit;
  late RequestBloc reqBloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<CreateScribeReqBloc>();
    bloc.generatePages();
    pageCubit = context.read<PageCubit>();
    pageCubit.reset();
    reqBloc = context.read<RequestBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.createScribeReq),
      ),
      body: BlocConsumer<CreateScribeReqBloc, CreateScribeReqState>(
          builder: (BuildContext ctx, CreateScribeReqState state){
            if(state is InitialCreateScribeReq){
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    BlocBuilder<PageCubit, int>(
                        builder: (BuildContext ctx, int page){
                          return bloc.pages[page];
                        }),
                    Expanded(child: Container()),
                    CommonLongButton(
                        text: pageCubit.state < bloc.pages.length -1 ? AppStrings.next : "Create Scribe Request",
                        onTap: () {
                          if(pageCubit.state < bloc.pages.length -1){
                            pageCubit.increment();
                          }
                          else{
                            bloc.add(CreateScribeReq());
                          }
                        }
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              if(pageCubit.state != 0){
                                pageCubit.decrement();
                              }
                            },
                            icon: Icon(Icons.arrow_back)
                        ),
                        TextButton(onPressed: () {
                          pageCubit.reset();
                        }, child: Text("Reset")),
                        IconButton(
                            onPressed: () {
                              if(pageCubit.state < bloc.pages.length -1){
                                pageCubit.increment();
                              }
                            },
                            icon: Icon(Icons.arrow_forward)
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              );
            }
            else if(state is CreateScribeReqLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is CreateScribeReqError){
              return const Center(child: Icon(Icons.error_outline));
            }
            else if(state is CreateScribeReqDone){
              return Column(
                children: [
                  Text("Request created successfully!, find it in your requests"),
                  const SizedBox(height: 12,),
                  TextButton(
                      onPressed: () {
                        bloc.add(ResetScribeCreation());
                        pageCubit.reset();
                      },
                      child: Text("Create new")
                  )
                ]);
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, CreateScribeReqState state){
            if(state is CreateScribeReqError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
            else if(state is CreateScribeReqDone){
              reqBloc.add(GetScribeReq());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Done!")));
            }
          }
      ),
    );
  }
}
