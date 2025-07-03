import 'package:flutter/material.dart';
import 'package:nifas_silk/constants/Employees.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';

class SubOfficersFinders extends StatelessWidget {
  final int officeId;

  SubOfficersFinders({required this.officeId});

  @override
  Widget build(BuildContext context) {
    List<Employee> subEmployees =
        Employees.where((element) => element.team_id == officeId).toList();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(100.0), // Set the desired height here
            child: customAppBar(context, false)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Wrap(
                spacing: 1.0, // gap between adjacent items
                runSpacing: 20.0, // gap between lines

                children: subEmployees.map((Employee employee) {
                  return Officers(
                    employee,
                    context,
                  );
                }).toList(),
              ),
            ),
          ),
        ));
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
          // Profile Image
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: has_color
                  ? Colors.green
                  : Color.fromRGBO(73, 111, 138, 1), // Border color
            ),
            width: 300,
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 60,
                // child: Image(
                //     image: image_path != ""
                //         ? AssetImage('assets/employee/' + image_path)
                //         : AssetImage('assets/icons/profile_holder.jpg')),
                backgroundImage: employee.path != ""
                    ? AssetImage('assets/employee/' + employee.path)
                    : AssetImage('assets/icons/profile_holder.jpg'),
                // backgroundImage: AssetImage(
                //   image_path != ""
                //       ? 'assets/employee/' + image_path
                //       : 'assets/icons/profile_holder.jpg',
                // ),
                // backgroundColor: Colors.white,
              ),
            ),
          ),

          // Employee Name
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
          // pOSITION
          Container(
            height: 20,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(4),
            // color: const Color.fromARGB(255, 234, 240, 235),
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
            // color: const Color.fromARGB(255, 234, 240, 235),
            child: Text(
              AppLocalizations.of(context)!.office + " " + employee.office,
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
