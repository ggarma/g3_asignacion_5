import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> createAccount(dynamic body) async {
  var response = await http.post(
      Platform.isAndroid
          ? Uri.parse('http://10.0.2.2:8000/user/create')
          : Uri.parse('http://127.0.0.1:8000/user/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(body));

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to get user');
  }
}

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
