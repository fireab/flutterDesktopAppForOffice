import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nifas_silk/constants/Employees.dart';
import 'package:nifas_silk/pages/officeFinder/SubOfficeFinders.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:nifas_silk/constants/BaseApi.dart';

class Officefinder extends StatefulWidget {
  @override
  _OfficefinderState createState() => _OfficefinderState();
}

class _OfficefinderState extends State<Officefinder> {
  List<Employee> employees = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      final response = await http.get(Uri.parse("${Api.baseUrl}/employee"));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          employees = data.map((json) => Employee.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load employees");
      }
    } catch (e) {
      print("Error loading employees: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String OfficeName(int id, BuildContext context, String office_number) {
    List<int> office_group = []; // Add office group ids here if needed
    if (office_group.contains(id)) {
      return AppLocalizations.of(context)!.office + " - " + office_number;
    } else {
      return AppLocalizations.of(context)!.burueu + " - " + office_number;
    }
  }

  Widget Officers(Employee employee, BuildContext context,
      {bool has_color = false}) {
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: has_color
                  ? Colors.green
                  : const Color.fromRGBO(73, 111, 138, 1),
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
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.localeName == "am"
                ? employee.amharic_name
                : AppLocalizations.of(context)!.localeName == "es"
                    ? employee.english_name
                    : employee.oromic_name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context)!.localeName == "am"
                ? employee.position
                : AppLocalizations.of(context)!.localeName == "es"
                    ? employee.english_position
                    : employee.oromic_position,
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            OfficeName(employee.id, context, employee.office),
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          employee.hasSub == true
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubOfficersFinders(
                                officeId: employee.id,
                              )),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 243, 239),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      employee.id == 288
                          ? AppLocalizations.of(context)!.group_members
                          : AppLocalizations.of(context)!.team_members,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 41, 174, 70),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : const SizedBox(height: 0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    List<Employee> mainEmployees =
        employees.where((e) => e.team_id == 0).toList();
    List<Employee> directors = mainEmployees.where((e) => e.id != 1).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: customAppBar(context, false),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if (mainEmployees.isNotEmpty)
                Center(
                  child: Officers(mainEmployees[0], context, has_color: true),
                ),
              const SizedBox(height: 20),
              Center(
                child: Wrap(
                  spacing: 1.0,
                  runSpacing: 30.0,
                  children: directors.map((e) {
                    return Officers(e, context);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
