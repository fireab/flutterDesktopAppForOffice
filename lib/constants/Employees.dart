class Employee {
  final int id;
  final String amharic_name;
  final String oromic_name;
  final String english_name;
  final String position;
  final String oromic_position;
  final String english_position;
  final String path;
  final String office;
  final int? team_id;
  final bool hasSub;

  Employee({
    required this.id,
    required this.amharic_name,
    required this.oromic_name,
    required this.english_name,
    required this.position,
    required this.oromic_position,
    required this.english_position,
    required this.path,
    required this.office,
    this.team_id,
    this.hasSub = false,
  });

//   factory Employee.fromJson(Map<String, dynamic> json) {
//     return Employee(
//       id: json['id'],
//       amharic_name: json['amharic_name'],
//       oromic_name: json['oromic_name'],
//       english_name: json['english_name'],
//       position: json['position'],
//       oromic_position: json['oromic_position'],
//       english_position: json['english_position'],
//       path: json['path'] ?? '',
//       office: json['office'],
//       team_id: json['team_id'], // <- THIS LINE IS IMPORTANT
//       hasSub: json['hasSub'] ?? false,
//     );
//   }
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? -1,
      amharic_name: json['amharic_name'] ?? "",
      oromic_name: json['oromic_name'] ?? "",
      english_name: json['english_name'] ?? "",
      position: json['position'] ?? "",
      oromic_position: json['oromic_position'] ?? "",
      english_position: json['english_position'] ?? "",
      path: json['path'] ?? "",
      office: json['office'] ?? "",
      team_id: json['team_id'], // nullable is fine here
      hasSub: json['has_sub'] ?? false,
    );
  }
}
