import 'dart:convert';
import 'package:json_ui/src/parsers/api/request.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<Map<String, dynamic>?> sendNetworkRequest(
      String url, RequestType requestType,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      if (requestType == RequestType.post) {
        http.Response response =
            await http.post(Uri.parse(url), headers: headers, body: body);
        return json.decode(response.body);
      } else if (requestType == RequestType.put) {
        http.Response response =
            await http.put(Uri.parse(url), headers: headers, body: body);
        return json.decode(response.body);
      } else if (requestType == RequestType.get) {
        http.Response response =
            await http.get(Uri.parse(url), headers: headers);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
