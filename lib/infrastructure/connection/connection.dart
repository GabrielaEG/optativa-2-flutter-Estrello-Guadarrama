import 'dart:convert';
import 'package:http/http.dart' as http;
import 'i_connection.dart';

class Connection implements IConnection{
  @override

  Future<T> get<T>(String url, {Map<String, String>? headers}) async{
    final response = await http.get(Uri.parse(url), headers: headers); 
    return jsonDecode(response.body) as T; 
  } 

  @override   

  Future<T> post<T, D>(String url, D data, {Map<String, String>? headers}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    return jsonDecode(response.body) as T;
  }
}