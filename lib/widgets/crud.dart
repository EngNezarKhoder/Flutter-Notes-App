import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('nezar:nezar12345'));

Map<String, String> myHeaders = {'authorization': _basicAuth};

class Crud {
  Future<dynamic> getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url),);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  Future<dynamic> postRequest(String url, Map data) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myHeaders);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  Future<dynamic> postRequestWithFile(String url, Map data, File file) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multiPartFile = http.MultipartFile('file', stream, length,
          filename: basename(file.path));
      request.headers.addAll(myHeaders);
      request.files.add(multiPartFile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
