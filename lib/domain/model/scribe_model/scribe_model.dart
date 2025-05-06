import 'package:student/domain/model/student_model/gender_model.dart';
import 'package:student/domain/model/student_model/language_model.dart';

class ScribeModel{
  final String name;
  final String email;
  final Gender gender;
  final String address;
  final String city;
  final String pincode;
  final int age;
  final String contact;
  final List<Language> langKnown;

  ScribeModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.address,
    required this.city,
    required this.pincode,
    required this.age,
    required this.contact,
    required this.langKnown,
  });

  factory ScribeModel.fromJson(Map<String, dynamic> json){
    List<Language> langs = [];

    for(String l in json['languagesKnown']){
      langs.add(getLangFromString(l));
    }
    return ScribeModel(
      name: json['name'],
      email: json['email'],
      gender: getGenderFromString(json['gender']),
      address: json['address'],
      city: json['city'],
      pincode: json['pincode'],
      age: json['age'],
      contact: json['contact'],
      langKnown: langs,
    );
  }

  Map<String, dynamic> toMap(){
    List<String> langs = [];

    for(Language l in langKnown){
      langs.add(getStringFromLanguage(l));
    }

    return {
      'name': name,
      'email': email,
      'gender': getStringFromGender(gender),
      'address': address,
      'city': city,
      'pincode': pincode,
      'age': age,
      'contact': contact,
      'languagesKnown': langs,
    };
  }
}