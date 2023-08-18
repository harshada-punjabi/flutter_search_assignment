class EmployeesModel {
  int? id;
  String? employee_name;
  int? employee_salary;
  int? employee_age;
  String? profile_image;

  EmployeesModel(
      {this.id,
      this.employee_name,
      this.employee_salary,
      this.employee_age,
      this.profile_image});

  EmployeesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee_name = json['employee_name'];
    employee_salary = json['employee_salary'];
    employee_age = json['employee_age'];
    profile_image = json['profile_image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_name'] = employee_name;
    data['employee_salary'] = employee_salary;
    data['employee_age'] = employee_age;
    data['profile_image'] = profile_image;
    return data;
  }
}
