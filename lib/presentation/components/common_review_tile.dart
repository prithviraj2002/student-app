import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/domain/model/review_model/review_model.dart';
import 'package:student/domain/model/student_model/gender_model.dart';
import 'package:student/presentation/requests/bloc/student_bloc/student_bloc.dart';
import 'package:student/presentation/requests/bloc/student_bloc/student_state.dart';

class CommonReviewTile extends StatelessWidget {
  final ReviewModel review;
  const CommonReviewTile({required this.review, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
        builder: (BuildContext ctx, StudentState state){
          if(state is StudentLoading){
            return const Center(child: CircularProgressIndicator());
          }
          else if(state is StudentDataError){
            return Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 220,
              child: Card(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20,),
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Center(child: Text(
                              "E",
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.primaryColor),))
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Could not get student name",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(
                              "Could not get student data", style: TextStyle(fontSize: 16),),
                          ],
                        ),
                        const SizedBox(width: 20,),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        width: 200,
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctx, int index){
                            return Icon(Icons.star, color: AppColors.primaryColor, size: 20,);
                          },
                          itemCount: review.rating,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(review.reviewText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            );
          }
          else if(state is StudentData){
            return Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 180,
              child: Card(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20,),
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Center(child: Text(
                              state.student.name.substring(0, 1),
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.primaryColor),))
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.student.name,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(
                              "${state.student.age} years old, ${getStringFromGender(state.student.gender)}", style: TextStyle(fontSize: 16),),
                          ],
                        ),
                        const SizedBox(width: 20,),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        width: 200,
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctx, int index){
                            return Icon(Icons.star, color: AppColors.primaryColor, size: 20,);
                          },
                          itemCount: review.rating,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(review.reviewText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            );
          }
          else{
            return Container();
          }
        }
    );
  }
}
