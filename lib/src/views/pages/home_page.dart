import 'package:api_search_list/src/controllers/employee_controller.dart';
import 'package:flutter/material.dart';

// Model
import '../../models/employee_model.dart';
import '../components/list.dart';
// Components
import '../components/loading.dart';
import '../components/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<EmployeesModel> _employees = <EmployeesModel>[];
  List<EmployeesModel> _employeesDisplay = <EmployeesModel>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getEmployees().then((value) {
      setState(() {
        _isLoading = false;
        _employees.addAll(value);
        _employeesDisplay = _employees;
        // print(_usersDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (!_isLoading) {
              return index == 0
                  ? MySearch(
                      hintText: 'ex: name, age or salary.',
                      onChanged: (searchText) {
                        searchText = searchText.toLowerCase();
                        setState(() {
                          _employeesDisplay = _employees.where((u) {
                            var nameLowerCase = u.employee_name!.toLowerCase();
                            var employeeAge = u.employee_age!.toString();
                            var employeeSalary = u.employee_salary!.toString();
                            return nameLowerCase.contains(searchText) ||
                                employeeAge.contains(searchText) ||
                                employeeSalary.contains(searchText);
                          }).toList();
                        });
                      },
                    )
                  : MyList(employee: _employeesDisplay[index - 1]);
            } else {
              return const MyLoading();
            }
          },
          itemCount: _employeesDisplay.length + 1,
        ),
      ),
    );
  }
}
