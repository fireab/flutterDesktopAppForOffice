import 'package:flutter/material.dart';
import 'package:nifas_silk/helpers/Services.helper.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:nifas_silk/constants/Services.dart';

class DetailService extends StatelessWidget {
  DetailService({
    required this.index,
    required this.type_service,
  });

  final int index;
  final String type_service;
  late Services data;
  @override
  Widget build(BuildContext context) {
    data = findServiceByTypeAndIndex(
        index, type_service, AppLocalizations.of(context)!.localeName);
    final size = MediaQuery.of(context).size;
    final requirementHeight = size.height * 0.1;
    final requirement_length = data.requirement.length;
    final requirementWidth = requirement_length <= 12
        ? size.width * 0.6
        : size.width * 0.47; // 40% of the screen width
    final title = type_service == "driver"
        ? AppLocalizations.of(context)!.office_name +
            " " +
            AppLocalizations.of(context)!.driver_services
        : AppLocalizations.of(context)!.office_name +
            " " +
            AppLocalizations.of(context)!.vehicle_services;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(100.0), // Set the desired height here
            child: customAppBar(context, false, title: title)),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      data.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.requirement_to_get_service,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Wrap(
                    alignment: size / 2 == 0
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    spacing: 10.0, // gap between adjacent items
                    runSpacing: 4.0, // gap between lines
                    children: data.requirement.map((String requirement) {
                      return Requirement(
                          requirement, requirementWidth, requirementHeight,
                          requirementLength: data.requirement.length);
                    }).toList(),
                  ),
                ],
              )),
        ));
  }

  Container Requirement(
      String requirement, double requirementWidth, double requirementHeight,
      {int requirementLength = 1}) {
    return Container(
      width: requirementWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              requirement,
              style: TextStyle(
                fontSize: requirementLength > 14 ? 15 : 20,
              ),
              maxLines: null, // Allow unlimited lines
              overflow: TextOverflow
                  .visible, // Allow text to overflow and wrap to the next line
            ),
          )
        ],
      ),
    );
  }
}
