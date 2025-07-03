class Employee {
  late int id;
  late String amharic_name;
  late String oromic_name;
  late String oromic_position;
  late String path;
  late String position;
  late String office;
  Employee(
      {required id,
      required amharic_name,
      required oromic_name,
      required oromic_position,
      required path,
      required position,
      required office}) {
    this.id = id;
    this.amharic_name = amharic_name;
    this.oromic_name = oromic_name;
    this.oromic_position = oromic_position;
    this.path = path;
    this.position = position;
    this.office = office;
  }
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'],
        amharic_name: json['amharic_name'],
        oromic_name: json['oromic_name'],
        oromic_position: json['oromic_position'],
        path: json['path'],
        position: json['position'],
        office: json['office']);
  }
}

class TopRatedEmployee {
  late int EmployeeId;
  late String averageScore;
  late Employee employee;
  TopRatedEmployee(
      {required EmployeeId, required averageScore, required employee}) {
    this.EmployeeId = EmployeeId;
    this.averageScore = averageScore;
    this.employee = employee;
  }
  factory TopRatedEmployee.fromJson(Map<String, dynamic> json) {
    return TopRatedEmployee(
        EmployeeId: json['EmployeeId'],
        averageScore: json['averageScore'],
        employee: Employee.fromJson(json['employee']));
  }
  String getAverageScoreToPercentage() {
    return ((double.parse(this.averageScore) * 100) / (4)).toString();
  }
}
