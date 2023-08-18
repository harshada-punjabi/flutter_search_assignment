import 'package:flutter/material.dart';

// Model
import '../../models/employee_model.dart';
// Page
import '../pages/employee_details_page.dart';

class MyList extends StatelessWidget {
  final EmployeesModel employee;
  const MyList({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: employee.id.toString(),
              child: CircleAvatar(
                backgroundImage: NetworkImage(employee.profile_image!),
              ),
            ),
            title: Text(employee.employee_name!),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(employee.employee_age!.toString()),
                Text(employee.employee_salary!.toString()),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EmployeeDetailsPage(employee: employee)));
            },
          ),
          const Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
