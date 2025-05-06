import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/domain/model/student_model/gender_model.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/components/common_text_field.dart';
import 'package:student/presentation/profile/bloc/profile_bloc.dart';
import 'package:student/presentation/profile/bloc/profile_event.dart';
import 'package:student/presentation/profile/bloc/profile_state.dart';
import 'package:student/presentation/profile/components/gender_dropdown.dart';
import 'package:student/presentation/register/cubit/gender_cubit.dart';

class PersonalDetailView extends StatefulWidget {
  const PersonalDetailView({super.key});

  @override
  State<PersonalDetailView> createState() => _PersonalDetailViewState();
}

class _PersonalDetailViewState extends State<PersonalDetailView> {
  late ProfileBloc bloc;
  late GenderCubit cubit;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<ProfileBloc>();
    cubit = context.read<GenderCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.personalDetails),),
      body: BlocConsumer<ProfileBloc, ProfileState>(
          builder: (BuildContext ctx, ProfileState state){
            if(state is StudentDataState){
              cubit.selectGender(state.student.gender);
              return Form(
                  key: bloc.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          Text(AppStrings.name),
                          const SizedBox(height: 8,),
                          CommonTextField(
                              controller: bloc.name,
                              hintText: ""
                          ),
                          const SizedBox(height: 12,),
                          Row(
                            children: [
                              Expanded(child: Text(AppStrings.age)),
                              const SizedBox(width: 16,),
                              Expanded(child: Text(AppStrings.gender)),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                    controller: bloc.age,
                                    textInputType: TextInputType.number,
                                    hintText: ""
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black45
                                      ),
                                      borderRadius: const BorderRadius. all(Radius. circular(4.0))
                                  ),
                                  child: Center(
                                    child: BlocBuilder<GenderCubit, Gender>(
                                      bloc: cubit,
                                      builder: (BuildContext ctx, Gender gender) {
                                        return GenderDropdown(cubit: cubit);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12,),
                          Text(AppStrings.email),
                          const SizedBox(height: 8,),
                          CommonTextField(
                              controller: bloc.email,
                              textInputType: TextInputType.emailAddress,
                              hintText: ""
                          ),
                          const SizedBox(height: 12,),
                          Text(AppStrings.address),
                          const SizedBox(height: 8,),
                          CommonTextField(
                              showCounter: true,
                              controller: bloc.address,
                              hintText: ""
                          ),
                          const SizedBox(height: 12,),
                          Row(
                            children: [
                              Expanded(child: Text(AppStrings.city)),
                              const SizedBox(width: 16,),
                              Expanded(child: Text(AppStrings.pincode)),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                    controller: bloc.city,
                                    hintText: ""
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CommonTextField(
                                    controller: bloc.pincode,
                                    maxLength: 6,
                                    textInputType: TextInputType.number,
                                    hintText: ""
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 48,),
                          Center(
                            child: CommonLongButton(
                                text: AppStrings.update,
                                onTap: () {
                                  bloc.add(
                                      UpdateProfile(gender: cubit.state)
                                  );
                                }
                            ),
                          ),
                          const SizedBox(height: 24,),
                        ],
                      ),
                    ),
                  )
              );
            }
            else if(state is StudentDataErrorState){
              return const Center(child: Text("Couldn't get Student data"));
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, ProfileState state){
            if(state is UpdateProfileLoading){
              showAboutDialog(
                  context: context,
                  children: [
                    Center(child: CircularProgressIndicator())
                  ]
              );
            }
            else if(state is UpdateProfileDone){
              Navigator.pop(context);
              showAboutDialog(
                  context: context,
                  applicationName: "Done!",
                  children: [
                    Center(child: Icon(Icons.check, color: Colors.green, size: 24,))
                  ]
              );
            }
            else if(state is UpdateProfileError){
              Navigator.pop(context);
              showAboutDialog(
                  context: context,
                  applicationName: "Error!",
                  children: [
                    Center(child: Icon(Icons.cancel_outlined, color: Colors.red, size: 24,))
                  ]
              );
            }
          }
      ),
    );
  }
}
