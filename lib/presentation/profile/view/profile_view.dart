import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/pages/app_pages.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/presentation/profile/bloc/profile_bloc.dart';
import 'package:student/presentation/profile/bloc/profile_event.dart';
import 'package:student/presentation/profile/bloc/profile_state.dart';
import 'package:student/presentation/profile/view/personal_detail_view.dart';
import 'package:student/presentation/register/cubit/gender_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileBloc bloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<ProfileBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profile),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
          builder: (BuildContext ctx, ProfileState state){
            if(state is StudentDataState){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 20,),
                  Container(
                      height: 120, width: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all()
                      ),
                      child: Center(child: Icon(Icons.person, size: 100,))
                  ),
                  const SizedBox(height: 12,),
                  Text(state.student.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 4,),
                  Text(state.student.email, style: TextStyle(color: Colors.grey, fontSize: 16),),
                  const SizedBox(height: 50,),
                  const Divider(),
                  const SizedBox(height: 20,),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(value: bloc),
                                    BlocProvider(create: (ctx) => GenderCubit()),
                                  ],
                                  child: PersonalDetailView()
                              )
                          )
                      );
                    },
                    leading: Icon(Icons.person),
                    title: Text(AppStrings.personalDetails, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              title: Text("Confirm logout?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      bloc.add(Logout());
                                    },
                                    child: Text("Yes")
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No")
                                )
                              ],
                            );
                          }
                      );
                    },
                    leading: Icon(Icons.logout),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20,),
                    title: Text(AppStrings.logout, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  ListTile(
                    onTap: () {
                      //ToDo: Implement delete account flow
                    },
                    leading: Icon(Icons.delete_outline, color: Colors.red,),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20,),
                    title: Text(AppStrings.deleteAccount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),),
                  ),
                  const SizedBox(height: 20,),
                  const Divider(),
                ],
              );
            }
            else if(state is StudentDataErrorState){
              return Center(child: Text("Couldn't get Student data!"));
            }
            else if(state is StudentDataLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, ProfileState state){
            if(state is StudentDataErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
            else if(state is LogoutProfileDone){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.phone, (dynamic) => false);
            }
            else if(state is DeleteAccountDone){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.phone, (dynamic) => false);
            }
          }
      ),
    );
  }
}
