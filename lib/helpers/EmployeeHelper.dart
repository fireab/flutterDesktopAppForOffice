import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nifas_silk/constants/Employees.dart';

class EmployeeService {
  static const String apiUrl = 'http://10.33.79.21:2000/employee/';
  // static const String apiUrl = 'http://localhost:2000/employee/';

  static Future<List<Employee>> fetchEmployees() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
