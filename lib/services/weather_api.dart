import 'package:http/http.dart' as http;
import 'dart:convert';

const weatherApiKey = "a88a9e86141e368103084b4cac5cae89";

const currentWeatherEndpoint = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=a88a9e86141e368103084b4cac5cae89";

Future<Map<String, dynamic>> getWeatherForCity ({required String city}) async {
  final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?units=metric&q=$city&appid=$weatherApiKey");

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Successful response
      final data = jsonDecode(response.body);
      return jsonDecode(response.body);
    } else {
      // Handle HTTP errors
      throw Exception('There was a problem with the request: status ${response.statusCode} received');
    }
  } catch (e) {
    // Handle other errors
    throw Exception('There was a problem with the request:  $e');
  }
}