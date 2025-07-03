import 'package:flutter/material.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:nifas_silk/pages/services/VehicleServiceList.dart';
import 'package:nifas_silk/pages/services/DriverServiceList.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';

class SelectMainService extends StatelessWidget {
  const SelectMainService({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonWidth = size.width * 0.4; // 40% of the screen width
    final buttonHeight = size.height * 0.21; // 10% of the screen height
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(100.0), // Set the desired height here
            child: customAppBar(context, false)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // VehicleServices
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VehicleServices()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(11, 73, 118, 1), // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(15.0), // Border radius
                  ),
                  width: buttonWidth,
                  height: buttonHeight,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                'assets/icons/vehicle.png'), // Replace with your image URL
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context)!.vehicle_services,
                          style: TextStyle(
                            fontSize: size.width * 0.028,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(11, 73, 118, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DriverService()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(11, 73, 118, 1), // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(15.0), // Border radius
                  ),
                  width: buttonWidth,
                  height: buttonHeight,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                'assets/icons/driver2.png'), // Replace with your image URL
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context)!.driver_services,
                          style: TextStyle(
                            fontSize: size.width * 0.028,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(11, 73, 118, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
