import 'package:flutter/material.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:nifas_silk/pages/TopRatedEmployees.dart';
import 'package:nifas_silk/pages/feedback/CompanyFeedback.dart';
import 'package:nifas_silk/pages/feedback/Feedback.dart';
import 'package:nifas_silk/pages/officeFinder/OfficeFinder.dart';
import 'package:nifas_silk/pages/services/SelectMainService.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/pages/compliment/Compliment.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("size " + size.width.toString());
    final buttonWidth = size.width * 0.4; // 40% of the screen width
    final buttonHeight = size.height * 0.31; // 10% of the screen height
    // final overallbuttonHeight = size.height * 0.21;
    final horizontalGap = size.height * 0.08; // 10% of the screen height
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Set the desired height here
          child: customAppBar(context, false)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 40),
          child: Center(
            // child: Wrap(
            //   // mainAxisAlignment: MainAxisAlignment.center,
            //   // spacing: 10.0, // gap between adjacent items
            //   runSpacing: 30.0, // gap between lines
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         // buildButton(
            //         //     context,
            //         //     SelectMainService(),
            //         //     AppLocalizations.of(context)!.services,
            //         //     AppLocalizations.of(context)!.service_description,
            //         //     buttonWidth,
            //         //     buttonHeight),
            //         // IgnorePointer(
            //         //   ignoring: false,
            //         //   child: Opacity(
            //         //     opacity: 0.4, // faded to show disabled
            //         //     child: buildButton(
            //         //       context,
            //         //       SelectMainService(),
            //         //       AppLocalizations.of(context)!.services,
            //         //       AppLocalizations.of(context)!.service_description,
            //         //       buttonWidth,
            //         //       buttonHeight,
            //         //     ),
            //         //   ),
            //         // ),

            //         SizedBox(width: horizontalGap), // Space between buttons
            //         buildButton(
            //             context,
            //             Officefinder(),
            //             AppLocalizations.of(context)!.direction,
            //             AppLocalizations.of(context)!.direction_description,
            //             buttonWidth,
            //             buttonHeight),
            //         // IgnorePointer(
            //         //   ignoring: true,
            //         //   child: Opacity(
            //         //     opacity: 0.4, // faded to show disabled
            //         //     child: buildButton(
            //         //       context,
            //         //       Officefinder(),
            //         //       AppLocalizations.of(context)!.direction,
            //         //       AppLocalizations.of(context)!.direction_description,
            //         //       buttonWidth,
            //         //       buttonHeight,
            //         //     ),
            //         //   ),
            //         // )
            //       ],
            //     ),
            //     SizedBox(height: horizontalGap), // Space between rows
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         buildButton(
            //           context,
            //           ComplimentForm(),
            //           AppLocalizations.of(context)!.comment,
            //           AppLocalizations.of(context)!.comment_description,
            //           buttonWidth,
            //           buttonHeight,
            //         ),
            //         SizedBox(width: horizontalGap), // Space between buttons
            //         // buildButton(
            //         //     context,
            //         //     FeedBackForm(),
            //         //     AppLocalizations.of(context)!.rate,
            //         //     AppLocalizations.of(context)!.rate_description,
            //         //     buttonWidth,
            //         //     buttonHeight),
            //         IgnorePointer(
            //           ignoring: false,
            //           child: Opacity(
            //             opacity: 1, // faded to show disabled
            //             child: buildButton(
            //                 context,
            //                 FeedBackForm(),
            //                 AppLocalizations.of(context)!.rate,
            //                 AppLocalizations.of(context)!.rate_description,
            //                 buttonWidth,
            //                 buttonHeight),
            //           ),
            //         )
            //       ],
            //     ),
            //     SizedBox(height: horizontalGap), // Space between rows
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         buildButton(
            //             context,
            //             CompanyFeedbackForm(),
            //             AppLocalizations.of(context)!.comment_company,
            //             AppLocalizations.of(context)!.rate_overall_service,
            //             // AppLocalizations.of(context)!.rate_company_description,
            //             buttonWidth,
            //             buttonHeight),
            //         SizedBox(width: horizontalGap), // Space between buttons
            //         buildButton(
            //             context,
            //             TopRatedEmployees(),
            //             AppLocalizations.of(context)!.top_rated_tile,
            //             AppLocalizations.of(context)!.top_rated_description,
            //             buttonWidth,
            //             buttonHeight),
            //       ],
            //     ),
            //   ],
            // ),
            child: Wrap(
              alignment:
                  WrapAlignment.center, // center all buttons horizontally
              spacing: horizontalGap, // horizontal gap between buttons
              runSpacing: 30.0, // vertical gap between rows
              children: [
                // Uncomment and add if you want this button:
                // buildButton(
                //   context,
                //   SelectMainService(),
                //   AppLocalizations.of(context)!.services,
                //   AppLocalizations.of(context)!.service_description,
                //   buttonWidth,
                //   buttonHeight,
                // ),

                // If you want the disabled faded button:
                // IgnorePointer(
                //   ignoring: false,
                //   child: Opacity(
                //     opacity: 0.4,
                //     child: buildButton(
                //       context,
                //       SelectMainService(),
                //       AppLocalizations.of(context)!.services,
                //       AppLocalizations.of(context)!.service_description,
                //       buttonWidth,
                //       buttonHeight,
                //     ),
                //   ),
                // ),

                buildButton(
                  context,
                  Officefinder(),
                  AppLocalizations.of(context)!.direction,
                  AppLocalizations.of(context)!.direction_description,
                  buttonWidth,
                  buttonHeight,
                ),

                buildButton(
                  context,
                  ComplimentForm(),
                  AppLocalizations.of(context)!.comment,
                  AppLocalizations.of(context)!.comment_description,
                  buttonWidth,
                  buttonHeight,
                ),

                IgnorePointer(
                  ignoring: false,
                  child: Opacity(
                    opacity:
                        1, // fully opaque, can be changed if you want faded
                    child: buildButton(
                      context,
                      FeedBackForm(),
                      AppLocalizations.of(context)!.rate,
                      AppLocalizations.of(context)!.rate_description,
                      buttonWidth,
                      buttonHeight,
                    ),
                  ),
                ),

                buildButton(
                  context,
                  CompanyFeedbackForm(),
                  AppLocalizations.of(context)!.comment_company,
                  AppLocalizations.of(context)!.rate_overall_service,
                  // AppLocalizations.of(context)!.rate_company_description,
                  buttonWidth,
                  buttonHeight,
                ),

                buildButton(
                  context,
                  TopRatedEmployees(),
                  AppLocalizations.of(context)!.top_rated_tile,
                  AppLocalizations.of(context)!.top_rated_description,
                  buttonWidth,
                  buttonHeight,
                ),
                Opacity(
                  opacity: 0.0,
                  child: IgnorePointer(
                    ignoring: true,
                    child: buildButton(
                      context,
                      Container(),
                      '',
                      '',
                      buttonWidth,
                      buttonHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, Widget NextPage, String title,
      String description, double width, double height) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: width + (size.height * 0.08),
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color.fromRGBO(11, 73, 118, 1), // Border color
            width: 2.0, // Border width
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(11, 73, 118, 1),
                  ),
                ),
              ),
              SizedBox(height: 4),
              Center(
                child: Text(
                  description,
                  style: TextStyle(
                      fontSize: (size.width > 1280) ? 25.0 : 20,
                      color: Color.fromARGB(255, 106, 119, 10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget OverAllButton(BuildContext context, Widget NextPage, String title,
      double width, double height) {
    final size = MediaQuery.of(context).size;
    final gapVertical = size.width * 0.1;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        // width: ,
        width: width * 2 + gapVertical,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color.fromRGBO(11, 73, 118, 1), // Border color
            width: 2.0, // Border width
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(11, 73, 118, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
