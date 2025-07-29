/*************  ✨ Codeium Command ⭐  *************/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nifas_silk/constants/BaseApi.dart';
import 'package:nifas_silk/constants/TopRatedEmployees.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class TopRatedEmployees extends StatefulWidget {
  @override
  State<TopRatedEmployees> createState() => _TopRatedEmployeesState();
}

class _TopRatedEmployeesState extends State<TopRatedEmployees> {
  late Future<List<TopRatedEmployee>> _futureEmployees;

  Future<List<TopRatedEmployee>> fetchEmployees() async {
    Uri url = Uri.parse('${Api.baseUrl}/stat/find_top_10');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> employeesApi = json.decode(response.body);
      List<dynamic> top_employees = [];
      if (employeesApi.length > 3) {
        top_employees = employeesApi.sublist(0, 3);
      } else {
        top_employees = employeesApi;
      }
      return top_employees
          .map((employee) => TopRatedEmployee.fromJson(employee))
          .toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureEmployees = fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Set the desired height here
          child: customAppBar(context, false)),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              AppLocalizations.of(context)!.top_rated_description,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<TopRatedEmployee>>(
              future: _futureEmployees,
              builder: (context, snapshot) {
                print("11111111111111111111");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading indicator
                } else if (snapshot.hasError) {
                  print("Error: ${snapshot}");
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ); // Display error message
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                } else {
                  final employees = snapshot.data!;
                  print("22222222222222222222222");
                  return DataTable(
                    columns: <DataColumn>[
                      displayeTableHeader("ID"),
                      displayeTableHeader(AppLocalizations.of(context)!.name),
                      displayeTableHeader(
                          AppLocalizations.of(context)!.position),
                      displayeTableHeader(AppLocalizations.of(context)!.point),
                    ],
                    rows: employees.map((employee) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(employee.employee.id.toString())),
                          // DataCell(
                          //   AppLocalizations.of(context)!.localeName == "am"
                          //       ? Text(employee.employee.amharic_name)
                          //       : Text(employee.employee.oromic_name),
                          // ),
                          DataCell(
                            AppLocalizations.of(context)!.localeName == "am"
                                ? Text(employee.employee.amharic_name)
                                : AppLocalizations.of(context)!.localeName ==
                                        "es"
                                    ? Text(employee.employee.english_name)
                                    : Text(employee.employee.oromic_name),
                          ),

                          // DataCell(
                          //   AppLocalizations.of(context)!.localeName == "am"
                          //       ? Text(employee.employee.position)
                          //       : Text(employee.employee.oromic_position),
                          // ),
                          DataCell(
                            AppLocalizations.of(context)!.localeName == "am"
                                ? Text(employee.employee.position)
                                : AppLocalizations.of(context)!.localeName ==
                                        "es"
                                    ? Text(employee.employee.english_position)
                                    : Text(employee.employee.oromic_position),
                          ),

                          DataCell(
                              Text(employee.getAverageScoreToPercentage())),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  DataColumn displayeTableHeader(String text) {
    return DataColumn(
      label: Expanded(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 8, 73, 127),
              fontSize: 16,
              fontStyle: FontStyle.normal),
        ),
      ),
    );
  }
}
