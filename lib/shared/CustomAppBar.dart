import 'package:flutter/material.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';

import 'package:nifas_silk/shared/LanguageSelectDropDown.dart';

Widget customAppBar(BuildContext context, bool? first, {String title = ""}) {
  first ??= false;
  final size = MediaQuery.of(context).size;
  final title_width = size.width * 0.7;
  return Container(
    color: Color.fromRGBO(11, 73, 118, 1), // Border color
    child: SafeArea(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!first)
              IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            else
              SizedBox(),
            Container(
              width: title_width,
              child: Row(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Center(
                  //     child: CircleAvatar(
                  //         radius: 50,
                  //         backgroundImage:
                  //             AssetImage('assets/icons/newLogo3.jpg')),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 86,
                      height: 86,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors
                            .white, // optional: background for transparency
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0), //
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icons/newLogo3.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20),
                  Expanded(
                    child: Center(
                      child: Text(
                        title == ""
                            ? AppLocalizations.of(context)!.welcome
                            : title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.4,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        maxLines: null, // Allow unlimited lines
                        overflow: TextOverflow
                            .visible, // Allow text to overflow and wrap to the next line
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildLanguageSelectorDropdown(context),
          ],
        ),
      ),
    ),
  );
}
