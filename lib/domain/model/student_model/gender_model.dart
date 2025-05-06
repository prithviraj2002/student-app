enum Gender {male, female, other}

String getStringFromGender(Gender g){
  if(g == Gender.male){
    return "male";
  }
  else if(g == Gender.female){
    return "female";
  }
  else{
    return "other";
  }
}

Gender getGenderFromString(String s){
  if(s == "male" || s == "Male"){
    return Gender.male;
  }
  else if(s == "female" || s == "Female"){
    return Gender.female;
  }
  else{
    return Gender.other;
  }
}