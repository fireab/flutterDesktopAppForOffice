import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nifas_silk/pages/LanguageSelector.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/constants/BaseApi.dart';

class ComplimentForm extends StatefulWidget {
  @override
  _ComplimentFormState createState() => _ComplimentFormState();
}

class _ComplimentFormState extends State<ComplimentForm> {
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _subCityController = TextEditingController();
  final TextEditingController _woredaController = TextEditingController();
  final TextEditingController _homeNoController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _complimentDateController =
      TextEditingController();
  final TextEditingController _placeSubCityController = TextEditingController();
  final TextEditingController _placeWoredaController = TextEditingController();
  final TextEditingController _employerNameController = TextEditingController();
  final TextEditingController _expectedResponseController =
      TextEditingController();

  bool _agreed = false;

  // Function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _agreed) {
      // Prepare data to be sent
      final data = {
        'fullName': _fullNameController.text,
        'city': _cityController.text,
        'subCity': _subCityController.text,
        'woreda': _woredaController.text,
        'homeNo': _homeNoController.text,
        'phoneNumber': _phoneNumberController.text,
        'reason': _reasonController.text,
        'complimentDate': _complimentDateController.text,
        'placeSubCity': _placeSubCityController.text,
        'placeWoreda': _placeWoredaController.text,
        'employerName': _employerNameController.text,
        'expectedResponse': _expectedResponseController.text,
      };

      // Send data to server
      final response = await http.post(
        Uri.parse(Api.baseUrl + '/compliment'),
        body: data,
      );

      if (response.statusCode == 200) {
        // Handle successful submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Container(
                  color: Colors.blue,
                  child: Text(
                    AppLocalizations.of(context)!.form_sumbitted,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ))),
        );
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LanguageSelector()));
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              AppLocalizations.of(context)!.form_sumbitted,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LanguageSelector()));
      }
    } else if (!_agreed) {
      // Handle agreement not checked
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('You must agree to the terms to submit the form.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formWidth = size.width * 0.8; // 40% of the screen width
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Set the desired height here
          child: customAppBar(context, false)),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: formWidth,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.full_name + " *"),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your full name'
                            : null,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _cityController,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.city +
                                          " *"),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your city'
                                  : null,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: TextFormField(
                              controller: _subCityController,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.sub_city +
                                          " *"),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your subcity'
                                  : null,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: TextFormField(
                              controller: _woredaController,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.woreda +
                                          " *"),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your woreda'
                                  : null,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: TextFormField(
                              controller: _homeNoController,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.home_no),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.phone_number +
                                    " *"),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your phone number'
                            : null,
                      ),
                      TextFormField(
                        controller: _reasonController,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                    .compliment_reason +
                                " *"),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter the reason' : null,
                      ),
                      TextFormField(
                        controller: _complimentDateController,
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.date + " *"),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter the compliment date'
                            : null,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _placeSubCityController,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.sub_city +
                                          " *"),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter the subcity'
                                  : null,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: TextFormField(
                              controller: _placeWoredaController,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.woreda +
                                          " *"),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter the woreda'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _employerNameController,
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.case_employee +
                                    " *"),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter the employer name'
                            : null,
                      ),
                      TextFormField(
                        controller: _expectedResponseController,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                    .complilmenter_need +
                                " *"),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter the expected response'
                            : null,
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreed,
                            onChanged: (value) {
                              setState(() {
                                _agreed = value!;
                              });
                            },
                          ),
                          Text(AppLocalizations.of(context)!.agree),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Center(
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            child: Text(AppLocalizations.of(context)!.submit),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(250, 45),
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(11, 73, 118, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        AppLocalizations.of(context)!.reminder,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10.0),
                      Reminder(AppLocalizations.of(context)!.reminder1),
                      Reminder(AppLocalizations.of(context)!.reminder2),
                      Reminder(AppLocalizations.of(context)!.reminder3),
                      Reminder(AppLocalizations.of(context)!.reminder4),
                      Reminder(AppLocalizations.of(context)!.reminder5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row Reminder(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.circle),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
            maxLines: null, // Allow unlimited lines
            overflow: TextOverflow
                .visible, // Allow text to overflow and wrap to the next line
          ),
        )
      ],
    );
  }
}
