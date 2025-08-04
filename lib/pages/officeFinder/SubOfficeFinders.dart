import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nifas_silk/constants/BaseApi.dart';
import 'package:nifas_silk/constants/Employees.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';

class SubOfficersFinders extends StatefulWidget {
  final int officeId;

  const SubOfficersFinders({required this.officeId});

  @override
  _SubOfficersFindersState createState() => _SubOfficersFindersState();
}

class _SubOfficersFindersState extends State<SubOfficersFinders> {
  late Future<List<Employee>> futureSubEmployees;

  @override
  void initState() {
    super.initState();
    futureSubEmployees = fetchSubEmployees();
  }

  Future<List<Employee>> fetchSubEmployees() async {
    final response =
        await http.get(Uri.parse('http://10.33.79.21:2000/employee/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final employees = data.map((e) => Employee.fromJson(e)).toList();
      return employees.where((e) => e.team_id == widget.officeId).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: customAppBar(context, false),
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureSubEmployees,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final subEmployees = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Wrap(
                    spacing: 1.0,
                    runSpacing: 20.0,
                    children:
                        subEmployees.map((e) => buildOfficerCard(e)).toList(),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildOfficerCard(Employee employee, {bool hasColor = false}) {
    return Container(
      width: 300,
      height: 320,
      margin: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3))
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: hasColor ? Colors.green : Color.fromRGBO(73, 111, 138, 1),
            ),
            width: 300,
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: employee.path != ""
                    ? NetworkImage(Api.baseUrl + "/public/" + employee.path)
                    : const AssetImage('assets/icons/profile_holder.jpg'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            height: 20,
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.localeName == "am"
                  ? employee.amharic_name
                  : AppLocalizations.of(context)!.localeName == "es"
                      ? employee.english_name
                      : employee.oromic_name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(4),
            child: Text(
              AppLocalizations.of(context)!.localeName == "am"
                  ? employee.position
                  : AppLocalizations.of(context)!.localeName == "es"
                      ? employee.english_position
                      : employee.oromic_position,
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(4),
            child: Text(
              "${AppLocalizations.of(context)!.office} ${employee.office}",
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
          employee.hasSub
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubOfficersFinders(officeId: employee.id),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 40,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 243, 239),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.team_members,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 41, 174, 70),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
