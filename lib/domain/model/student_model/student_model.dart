import 'package:student/domain/model/student_model/gender_model.dart';

class StudentModel{
  final String name;
  final String email;
  final Gender gender;
  final int age;
  final String address;
  final String city;
  final String pincode;

  StudentModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.age,
    required this.address,
    required this.city,
    required this.pincode,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json){
    return StudentModel(
      name: json['name'],
      email: json['email'],
      gender: getGenderFromString(json['gender']),
      age: json['age'],
      address: json['address'],
      city: json['city'],
      pincode: json['pincode'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'gender': getStringFromGender(gender),
      'age': age,
      'address': address,
      'city': city,
      'pincode': pincode
    };
  }
}