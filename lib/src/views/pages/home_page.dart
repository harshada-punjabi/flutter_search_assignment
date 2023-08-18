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
  int selectedAgeGroup = 0;
  bool _isLoading = true;

  List<EmployeesModel> get filteredEmployees {
    if (selectedAgeGroup == 0) {
      return _employeesDisplay;
    } else {
      final int lowerBound = selectedAgeGroup;
      final int upperBound = selectedAgeGroup + 9;
      return _employeesDisplay
          .where((employee) =>
              employee.employee_age! >= lowerBound &&
              employee.employee_age! <= upperBound)
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    getEmployees().then((value) {
      setState(() {
        _isLoading = false;
        _employees.addAll(value);
        _employeesDisplay = _employees;
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
                      value: selectedAgeGroup,
                      selectedAgeGroup: (ageGroup) {
                        setState(() {
                          selectedAgeGroup = ageGroup!;
                          if (selectedAgeGroup == 0) {
                            _employeesDisplay = _employees.toList();
                          } else {
                            _employeesDisplay = _employees.where((u) {
                              return u.employee_age! >= selectedAgeGroup &&
                                  u.employee_age! <= selectedAgeGroup + 10;
                            }).toList();
                          }
                        });
                      },
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
