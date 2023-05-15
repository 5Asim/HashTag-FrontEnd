import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/api/post_api.dart';

import '../constant.dart';


// Future<List> getfollowtag(String title) async{
//     var token = await getToken();
//     var response = await http
//       .get(Uri.parse('$baseUrl/tag/followers/$title/'),
//       headers: {
//         // 'Authorization': 'Token $token',
//             'Authorization': 'Token $token',
//   },      );
//   if (response.statusCode == 200)
//   {
//     List<dynamic> data = jsonDecode(response.body);
//     return data;
//   }
//   else {
//     throw Exception('Failed to load tags');
//   }

// }

Future<List> followtag(String title) async{
    var token = await getToken();
    var response = await http
      .post(Uri.parse('$baseUrl/tag/followtag/$title'),
      headers: {
        // 'Authorization': 'Token $token',
            'Authorization': 'Token $token',
  },      );
  if (response.statusCode == 200)
  {
    List<dynamic> data = jsonDecode(response.body);
    return data;
  }
  else {
    throw Exception('Failed to load tags');
  }

}

Future<List> gettagfollowers(String title) async{
    var token = await getToken();
    var response = await http
      .get(Uri.parse('$baseUrl/tag/followers/$title'),
      headers: {
        // 'Authorization': 'Token $token',
            'Authorization': 'Token $token',
  },      );
  if (response.statusCode == 200)
  {
    List<dynamic> data = jsonDecode(response.body);
    return data;
  }
  else {
    throw Exception('Failed to load followers');
  }

}


Future<bool> checkIfFollowingTag(String id) async {
  var token = await getToken();
    var response = await http
      .get(Uri.parse('$baseUrl/tag/usertagfolowingsignal/$id'),
      headers: {
        // 'Authorization': 'Token $token',
            'Authorization': 'Token $token',
  },      );
  

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final following = data['following'];
      print(following);
      return following;
    } else {
      // Handle other response statuses
      return false;
    }
  } 