import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/api/auth/auth_api.dart';
import "package:untitled/constant.dart";
import 'package:untitled/models/post_model.dart';
import 'package:untitled/models/user_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/tag_model.dart';

// Future<String?> getToken() async {
//   await Hive.openBox('tokenBox'); // Open the Hive box

//   final box = Hive.box('tokenBox'); // Get a reference to the box
//   final token = box.get('token');
//   print(token) // Get the token value from the box

//   return token; // Return the token value (which may be null)
// }


Future<String?> getToken() async {
  var box = await Hive.openBox(tokenBox);
  var token = box.get("token") as String?;
  return token;
} 

List<Post> postList =[];
List<Post> selfpostList =[];

Future<void> createPost(
  String id,
  String content,
  
) async {
    var token = await getToken();
    String url = '$baseUrl/post/$id'; // Replace with your API endpoint URL

    

    Map<String, dynamic> requestBody = {

      'content': content,
    };

    try {
      final response = await http.post(Uri.parse(url), body: requestBody,headers: {
      'Authorization':'Token ${token}',
    });
      print(response.body);
      if (response.statusCode == 201 || response.statusCode==200) {
        // Tag creation successful
        print('Post created successfully');
        
        // You can perform any additional actions here
      } else {
        // Tag creation failed
        print('Post creation failed');
        // Handle the error or show an error message to the user
      }
    } catch (error) {
      print('Error creating Post: $error');
      // Handle the error or show an error message to the user
    }
  }


Future<List<Post>> getPost() async {
  var token = await getToken();
  var response = await http
      .get(Uri.parse('$baseUrl/post/list/'),
      headers: {
        // 'Authorization': 'Token $token',
    'Authorization': 'Token $token',
  },      );
  var data = jsonDecode(response.body.toString());
  // print(data);
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print(response.body);
    List<Post> posts = data.map((postJson) => Post.fromJson(postJson)).toList();
    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}



Future<List<Post>> getSelfPost() async {
  var token = await getToken();
  var response = await http
      .get(Uri.parse('$baseUrl/post/self/'),
      headers: {
        // 'Authorization': 'Token $token',
    'Authorization': 'Token $token',
  },      );
  var data = jsonDecode(response.body.toString());
  // print(data);
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print(response.body);
    List<Post> selfposts = data.map((postJson) => Post.fromJson(postJson)).toList();
    return selfposts;
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<int> getTotalSelfPost() async
{
  var token = await getToken();
  var response = await http
      .get(Uri.parse('$baseUrl/post/self/count/'),
      headers: {
        // 'Authorization': 'Token $token',
    'Authorization': 'Token $token',
  },      );
  var data = jsonDecode(response.body);
  if(response.statusCode==200)
  {
    int data = jsonDecode(response.body);
    return data;
  }
  else{
    throw Exception('Failed to load count');
  }
}


Future<bool> verifyPost(String id) async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$baseUrl/post/verify/$id'),
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final verification = responseData['verification'];

    if (verification) {
      // Post verified
      print(verification);
      return true;
    } else {
      // Post unverified
      print(verification);
      return false;
    }
  } else {
    // Error occurred
    print('Error: ${response.statusCode}');
    throw Exception('Error occurred while verifying post');
  }
}


Future<List<Tag>> getRecomendedPost() async {
  var token = await getToken();
  var response = await http
      .get(Uri.parse('$baseUrl/tag/recommend/'),
      headers: {
        // 'Authorization': 'Token $token',
    'Authorization': 'Token $token',
  },      );
  var data = jsonDecode(response.body.toString());
  // print(data);
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print(response.body);
    List<Tag> posts = data.map((postJson) => Tag.fromJson(postJson)).toList();
    return posts;
  } else {
    throw Exception('Failed to load tags');
  }
}
