import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zelrap/data/models/account.dart';

class ApiService {
  final _baseUrl = "TODO"; // TODO

  Future<Account> login(String username) async {
    var authResponse = await http.post('$_baseUrl/v1/users', body: {'sender': username});
    var authToken = json.decode(authResponse.body)['authToken'];
    var feedResponse = await http.post('$_baseUrl/v1/stream-feed-credentials',
        headers: {'Authorization': 'Bearer $authToken'});
    var feedToken = json.decode(feedResponse.body)['token'];

    return Account(username: username, authToken: authToken, feedToken: feedToken);
  }
}
