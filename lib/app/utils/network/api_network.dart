/*Written by Atul Rawat*/
import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/utils/network/api_constant.dart';
import 'package:surya/app/utils/network/network_connection.dart';


enum RequestType { GET, POST, DELETE, PUT }

class AppNetwork {

  static final String _baseUrl = ApiConstant.app_url;

  final Client _client;

  AppNetwork(this._client);
  NetworkConnection checkConnection=NetworkConnection();

  Future<Response?> request(
      {required RequestType requestType, required String path, dynamic parameter, required String? token}) async {
    Logger().d("Path====> $path");
    Logger().d("Access Token AppNetwork====> $token");

    switch (requestType) {
      case RequestType.GET:
        return _client.get(Uri(path: "$_baseUrl/$path"),headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-session-token':token!=null?token:""});
      case RequestType.POST:
        return _client.post(Uri(path: "$_baseUrl/$path"), headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-session-token': token!=null?token:""},body: json.encode(parameter));
      case RequestType.DELETE:
        return _client.delete(Uri(path: "$_baseUrl/$path"));
      case RequestType.PUT:
        return _client.put(Uri(path: "$_baseUrl/$path"), headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-session-token': token!=null?token:""},body: json.encode(parameter));
      default:
        Logger().e("Not valid request type");
        return null;
    }
  }
}