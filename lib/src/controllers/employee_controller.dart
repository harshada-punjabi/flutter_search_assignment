import 'dart:convert';

// Http
import 'package:http/http.dart';

// Model
import '../models/employee_model.dart';

String employeeUrl = 'https://dummy.restapiexample.com/api/v1/employees';

Future<List<EmployeesModel>> getEmployees() async {
  Response response = await get(Uri.parse(employeeUrl));

  if (response.statusCode == 200) {
    final List result = jsonDecode(response.body)['data'];
    return result.map((e) => EmployeesModel.fromJson(e)).toList();
  } else {
    throw Exception(response.reasonPhrase);
  }
}
