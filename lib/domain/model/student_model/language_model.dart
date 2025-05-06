enum Language {english, hindi, gujarati}

String getStringFromLanguage(Language l){
  if(l == Language.english){
    return "english";
  }
  else if(l == Language.hindi){
    return "hindi";
  }
  else if(l == Language.gujarati){
    return "gujarati";
  }
  else{
    return "";
  }
}

Language getLangFromString(String l){
  if(l == "hindi" || l == "Hindi"){
    return Language.hindi;
  }
  else if(l == "english" || l == "English"){
    return Language.english;
  }
  else if(l == "Gujarati" || l == "gujarati"){
    return Language.gujarati;
  }
  else{
    return Language.hindi;
  }
}