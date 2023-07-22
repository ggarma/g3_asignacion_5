import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> getUserValidation(String uid) async {
  var response = await http.get(
    Platform.isAndroid
        ? Uri.parse('http://10.0.2.2:8000/user/fetch_one?uid=$uid')
        : Uri.parse('http://127.0.0.1:8000/user/fetch_one?uid=$uid'),
  );
  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    throw Exception('Failed to get user');
  }
}

Future<dynamic> getUser(String id) async {
  var response = await http.get(
    Platform.isAndroid
        ? Uri.parse('http://10.0.2.2:8000/user?id=$id')
        : Uri.parse('http://127.0.0.1:8000/user?id=$id'),
  );
  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    throw Exception('Failed to get user');
  }
}

Future<dynamic> getUserPosts(String id) async {
  var response = await http.get(
    Platform.isAndroid
        ? Uri.parse('http://10.0.2.2:8000/user/pokemon?id=$id')
        : Uri.parse('http://127.0.0.1:8000/user/pokemon?id=$id'),
  );
  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    throw Exception('Failed to get posts');
  }
}

Future<dynamic> getUserFollowers(String id) async {
  var response = await http.get(
    Platform.isAndroid
        ? Uri.parse('http://10.0.2.2:8000/user/follower?user_id=$id')
        : Uri.parse('http://127.0.0.1:8000/user/follower?user_id=$id'),
  );
  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    throw Exception('Failed to get followers');
  }
}

Future<dynamic> getUserFollowings(String id) async {
  var response = await http.get(
    Platform.isAndroid
        ? Uri.parse('http://10.0.2.2:8000/user/following?user_id=$id')
        : Uri.parse('http://127.0.0.1:8000/user/following?user_id=$id'),
  );
  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    throw Exception('Failed to get followings');
  }
}

Future<dynamic> updateUserData(Object body) async {
  var response = await http.post(Platform.isAndroid
        ? Uri.parse('http://10.0.2.2:8000/user/update')
        : Uri.parse('http://127.0.0.1:8000/user/update'), body: body);
  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    print(responseBody);
    return responseBody;
  } else {
    throw Exception('Failed to update user');
  }
}

Future<dynamic> updateUserPassword(Object body) async {
  var response = await http.post(Platform.isAndroid
        ? Uri.parse('http://10.0.2.2:8000/user/password')
        : Uri.parse('http://127.0.0.1:8000/user/password'), body: body);
  if(response.statusCode == 200){
    var responseBody = json.decode(response.body);
    print(responseBody);
    return responseBody;
  }else{
    throw Exception('Failed to update password');
  }
}