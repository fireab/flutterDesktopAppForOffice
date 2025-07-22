import 'package:flutter/material.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:nifas_silk/helpers/Services.helper.dart';
import 'package:nifas_silk/pages/services/DetailService.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/constants/Services.dart';

class VehicleServices extends StatelessWidget {
  const VehicleServices({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonWidth = size.width * 0.22; // 40% of the screen width
    final buttonHeight = size.height * 0.19; // 10% of the screen height
    final gap = size.height * 0.01;
    double fontSize = 17;
    List<Services> data =
        getMineralResourceService(AppLocalizations.of(context)!.localeName);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(100.0), // Set the desired height here
            child: customAppBar(context, false,
                title: AppLocalizations.of(context)!.office_name +
                    " " +
                    AppLocalizations.of(context)!
                        .mineral_resource_research_Licensing_and_management)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Wrap(
                  spacing: 10.0, // gap between adjacent items
                  runSpacing: 30.0, // gap between lines)
                  children: data.map((Services serv) {
                    return ServiceButton(
                        context,
                        serv.id - 1,
                        buttonWidth,
                        buttonHeight,
                        data,
                        fontSize,
                        data[serv.id - 1].name,
                        data[serv.id - 1].time_it_takes);
                  }).toList()),
            ),
          ),
        ));
  }

  GestureDetector ServiceButton(
      BuildContext context,
      int index,
      double buttonWidth,
      double buttonHeight,
      List<Services> data,
      double fontSize,
      String name,
      int minutes) {
    String time_decription = "";
    // displayTimeItTakes(context, minutes);
    return GestureDetector(
      onTap: () {
        // VehicleServices
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailService(
                    index: index,
                    type_service: 'mineral resource',
                  )),
        );
      },
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //       colors: [
            //         Colors.blue,
            //         Colors.green,
            //       ],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color.fromRGBO(11, 73, 118, 1), // Border color
              width: 0.8, // Border width
            ),
          ),
          width: buttonWidth,
          height: buttonHeight,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 8, // 80% of the space
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (index + 1).toString() + ". " + name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(11, 73, 118, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.0), // Add some space between the texts
              Flexible(
                flex: 2, // 20% of the space
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      time_decription,
                      style: TextStyle(
                          fontSize:
                              AppLocalizations.of(context)!.time_it_takes ==
                                      "am"
                                  ? 15.0
                                  : 14.0,
                          color: Color.fromARGB(255, 106, 119, 10)),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

String displayTimeItTakes(BuildContext context, int minutes) {
  return AppLocalizations.of(context)!.localeName == "am"
      ? AppLocalizations.of(context)!.time_it_takes +
          " " +
          minutes.toString() +
          " " +
          AppLocalizations.of(context)!.minute
      : AppLocalizations.of(context)!.time_it_takes +
          " " +
          AppLocalizations.of(context)!.minute +
          " " +
          minutes.toString();
}
