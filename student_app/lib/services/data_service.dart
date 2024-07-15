import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/models/teacher.dart';

class DataService {
  final String baseUrl = 'https://667cb0ca3c30891b865d4c81.mockapi.io/';
  Future<Teacher> downloadTeacher() async {
    final response = await http.get(Uri.parse('$baseUrl/teacher/1'));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load teacher ${response.statusCode}');
    }
  }
}

final dataServiceProvider = Provider((ref) {
  return DataService();
});