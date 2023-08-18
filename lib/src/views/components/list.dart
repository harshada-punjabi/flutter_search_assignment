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
    // Generate initials from the user's name
    String initials = employee.employee_name!.isNotEmpty
        ? employee.employee_name!.substring(0, 2).toUpperCase()
        : "?";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: employee.id.toString(),
              child: employee.profile_image!.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(employee.profile_image!),
                    )
                  : CircleAvatar(
                      backgroundColor:
                          Colors.blue, // Set the background color of the circle
                      child:
                          Text(initials, style: TextStyle(color: Colors.white)),
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
