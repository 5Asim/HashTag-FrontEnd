import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/api/auth/auth_api.dart';
import 'package:untitled/api/post_api.dart';
import "package:untitled/constant.dart";
import 'package:untitled/models/follow_tag_model.dart';
import 'package:untitled/models/post_model.dart';
import 'package:untitled/models/user_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/tag_model.dart';

Future<String?> getToken() async {
  var box = await Hive.openBox(tokenBox);
  var token = box.get("token") as String?;
  return token;
} 

// List<Post> self_tags=[];
Future<List<Tag>> getSelf_tag() async {
  print("Done");
  var token = await getToken();
  var response = await http
      .get(Uri.parse('$baseUrl/tag/self/'),
      headers: {
        // 'Authorization': 'Token $token',
            'Authorization': 'Token $token',
  },      );
  var data = jsonDecode(response.body.toString());
  print(data);
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print(response.body);
    List<Tag> self_tags = data.map((postJson) => Tag.fromJson(postJson)).toList();
    return self_tags;
  } else {
    throw Exception('Failed to load tags');
  }
}

List<Post> tag_postlist=[];

Future<List<Post>> getTag_Post(String tag_name) async {

  var token = await getToken();
  var response = await http
      .get(Uri.parse('$baseUrl/post/list/$tag_name'),
      headers: {
        // 'Authorization': 'Token $token',
            'Authorization': 'Token $token',
  },      );
  var data = jsonDecode(response.body.toString());
  print(data);
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print(response.body);
    List<Post> tag_post = data.map((postJson) => Post.fromJson(postJson)).toList();
    return tag_post;
  } else {
    throw Exception('Failed to load tags');
  }
}

Future followTag(String tagName) async{
  var token = await getToken();
  var response = await http
      .post(Uri.parse('$baseUrl/tag/followtag/$tagName'),
      headers: {
        // 'Authorization': 'Token $token',
            'Authorization': 'Token $token',
  },      );
 
  if(response.statusCode == 200)
  {
    print("Unfollowed Tag sucessfully");
  }
  else if(response.statusCode ==201)
  {
    print("Followed Tag Sucessfully");
  }
  else 
  {
    throw Exception("Failed");
  }
}

Future<List<Follows_Tag>> getTagFollowers(String tagName)async
{
    var token = await getToken();
  var response = await http
      .post(Uri.parse('$baseUrl/tag/followers/$tagName'),
      headers: {
        // 'Authorization': 'Token $token',
            'Authorization': 'Token $token',
  },      );
  var data = jsonDecode(response.body.toString());
  print(data);
  if(response.statusCode == 200)
  {
    List<dynamic> data = jsonDecode(response.body);
    print(response.body);
    List<Follows_Tag> followers = data.map((postJson) => Follows_Tag.fromJson(postJson)).toList();
    return followers;
  }
  
  else 
  {
    throw Exception("Failed");
  }
}


Future<List> getTotalPostTag() async {
  var token = await getToken();
  var response = await http
      .get(Uri.parse('$baseUrl/post/totalposttag/'),
      headers: {
        // 'Authorization': 'Token $token',
            'Authorization': 'Token $token',
  },      );
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load tags');
  }
}
Future<Tag> getTagDetail(String title) async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$baseUrl/tag/detail/$title'),
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return Tag.fromJson(data);
  } else {
    throw Exception('Failed to load tags');
  }
}


// Future<List<dynamic>> getTagDetail(String title)
// async
// {
//   var token = await getToken();
//   var response = await http
//       .get(Uri.parse('$baseUrl/tag/detail/$title'),
//       headers: {
//         // 'Authorization': 'Token $token',
//             'Authorization': 'Token $token',
//   },      );
//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(response.body);
//     return data;
//   } else {
//     throw Exception('Failed to load tags');
//   }

// }
Future<int> getTagId(String title) async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$baseUrl/tag/detail/$title'),
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    int id = data['id'];
    return id;
  } else {
    throw Exception('Failed to load tag details');
  }
}

Future<void> createTag(
  String title,
  String content,
  String relevant_tags,
  bool follow_to_post
) async {
    var token = await getToken();
    String url = '$baseUrl/tag/'; // Replace with your API endpoint URL

    

    Map<String, dynamic> requestBody = {
      'title': title,
      'content': content,
      'relevant_tags': relevant_tags,
      'follow_to_post': follow_to_post.toString(),
    };

    try {
      final response = await http.post(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization':'Token ${token}',
      },
      body: jsonEncode(requestBody)
    );

      if (response.statusCode == 201) {
        // Tag creation successful
        print('Tag created successfully');
        
        // You can perform any additional actions here
      } else {
        // Tag creation failed
        print('Tag creation failed');
        // Handle the error or show an error message to the user
      }
    } catch (error) {
      print('Error creating tag: $error');
      // Handle the error or show an error message to the user
    }
  }


Future<String> getContent(String title) async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$baseUrl/tag/detail/$title'),
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    print(response.body);
    String content = data['content'] ?? '';
    print(content);
    return content;
  } else {
    throw Exception('Failed to load tag details');
  }
}
Future<int> getpost_count(String title) async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$baseUrl/tag/detail/$title'),
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    print(response.body);
    int post_count = data['post_count'] ?? '';
    print(post_count);
    return post_count;
  } else {
    throw Exception('Failed to load tag details');
  }
}
Future<int> getfollower_count(String title) async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$baseUrl/tag/detail/$title'),
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    print(response.body);
    int follower_count = data['follower_count'] ?? '';
    print(follower_count);
    return follower_count;
  } else {
    throw Exception('Failed to load tag details');
  }
}
Future<int> getTotalSelfTag() async
{
  var token = await getToken();
  var response = await http
      .get(Uri.parse('$baseUrl/tag/self/count'),
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


