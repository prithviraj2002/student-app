import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student/data/endpoints.dart';

class StudentClient{
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<dynamic> get(String endpoint) async{
    try{
      String? token = await auth.currentUser!.getIdToken(true);

      if(token != null && token.isNotEmpty){
        final response = await http.get(
          Uri.parse(Endpoints.baseUrl + endpoint),
          headers: {
            'authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        );

        debugPrint("User token: $token");

        if(response.statusCode == 200 || response.statusCode == 201){
          return jsonDecode(response.body);
        }
        else{
          debugPrint("An error occurred while getting data: ${response.statusCode} - ${response.request}");
        }
      }
      else{
        debugPrint("Token is either null or empty");
        throw Exception("Token is either null or empty");
      }
    } catch(e){
      debugPrint("User not verified: $e");
      throw Exception(e);
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async{
    try{
      String? token = await auth.currentUser!.getIdToken(true);

      if(token != null && token.isNotEmpty){
        try{
          final response = await http.post(
              Uri.parse(Endpoints.baseUrl + endpoint),
              body: jsonEncode(data),
              headers: {
                'authorization': 'Bearer $token',
                'Content-Type': 'application/json'
              }
          );
          debugPrint("User token: $token");

          if(response.statusCode == 200 || response.statusCode == 201){
            return jsonDecode(response.body);
          }
          else{
            debugPrint("An error occurred while posting data: ${response.statusCode} - ${response.request}");
          }
        } catch(e){
          debugPrint("An error occurred while posting data: $e");
        }
      }
      else{
        debugPrint("Token is either null or empty");
        throw Exception("Token is either null or empty");
      }
    } catch(e){
      debugPrint("User not verified: $e");
      throw Exception(e);
    }
  }

  Future<dynamic> delete(String endpoint) async{
    try{
      String? token = await auth.currentUser!.getIdToken(true);

      if(token != null && token.isNotEmpty){
        try{
          final response = await http.delete(
              Uri.parse(Endpoints.baseUrl + endpoint),
              headers: {
                'authorization': 'Bearer $token',
                'Content-Type': 'application/json'
              }
          );
          debugPrint("User token: $token");

          if(response.statusCode == 200 || response.statusCode == 201){
            return jsonDecode(response.body);
          }
          else{
            debugPrint("An error occurred while deleting data: ${response.statusCode} - ${response.body}");
          }
        } catch(e){
          debugPrint("An error occurred while deleting data: $e");
          throw Exception(e);
        }
      }
      else{
        debugPrint("Token is either null or empty");
        throw Exception("Token is either null or empty");
      }
    } catch(e){
      debugPrint("User not verified: $e");
      throw Exception(e);
    }
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> data) async {
    try{
      String? token = await auth.currentUser!.getIdToken(true);

      if(token != null && token.isNotEmpty){
        try{
          final response = await http.patch(
              Uri.parse(Endpoints.baseUrl + endpoint),
              body: jsonEncode(data),
              headers: {
                'authorization': 'Bearer $token',
                'Content-Type': 'application/json'
              }
          );
          debugPrint("User token: $token");

          if(response.statusCode == 200 || response.statusCode == 201){
            return jsonDecode(response.body);
          }
          else{
            debugPrint("An error occurred while patching data: ${response.statusCode} - ${response.body}");
          }
        } catch(e){
          debugPrint("An error occurred while patching data: $e");
          throw Exception(e);
        }
      }
      else{
        debugPrint("Token is either null or empty");
        throw Exception("Token is either null or empty");
      }
    } catch(e){
      debugPrint("User not verified: $e");
      throw Exception(e);
    }
  }
}