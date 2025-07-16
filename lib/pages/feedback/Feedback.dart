import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:nifas_silk/constants/BaseApi.dart';
import 'package:nifas_silk/pages/LanguageSelector.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/constants/Employees.dart';

class FeedBackForm extends StatefulWidget {
  @override
  _FeedBackFormState createState() => _FeedBackFormState();
}

class _FeedBackFormState extends State<FeedBackForm> {
  List<Employee> offices = [];
  bool isLoading = true;

  Map<String, int?> selectedValues = {
    'CustomerService': null,
    'StandardService': null,
    'FairService': null,
    'ResponseForCompliment': null,
    'ServiceRate': null,
  };

  String? selectedOffice;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<Standard> standards = [
    Standard(
        'CustomerService',
        'አገልግሎት ሰጪ ባለሙያ የተገልጋይ አቀባበል ሁኔታ',
        'Haala simannaa maamiltootaa dhiyeessaa tajaajilaa',
        "The service provider's customer reception"),
    Standard(
        'StandardService',
        'በስታንዳርዱ መሠረት አገልግሎት ስለማግኘትዎ',
        "Akkaataa istaandaardiitiin tajaajila argachuu",
        "Access to services according to standards"),
    Standard('FairService', 'ፍትሃዊ አገልግሎት ስለማግኘትዎ',
        "Tajaajila haqa qabeessa argachuu", "Access to fair services"),
    Standard(
        'ResponseForCompliment',
        'ለቅሬታዎ ግልጽና ፈጣን ምላሽ ስለመሰጠቱ',
        "Deebii ifaafi ariifataa komii keessaniif kennamu ilaalchisee",
        "Clear and prompt responses to complaints"),
    Standard('ServiceRate', 'አጠቃላይ የሚሰጠውን አገልግሎት እንዴት ይመዝኑታል',
        "Tajaajila waliigalaa akkamitti madaaltu?", "Overall service rating"),
  ];

  List<Rating> ratings = [
    Rating('Bad', 'ዝቅተኛ', "Gadi bu'aa", "Bad"),
    Rating('Good', 'ጥሩ', 'Gaarii', "Good"),
    Rating('Intermediate', 'መካከለኛ', 'Giddu galeessa', "Intermediate"),
    Rating('VeryGood', 'በጣም ጥሩ', "Baay'ee gaarii", "VeryGood"),
    Rating('Excellent', 'እጅግ በጣም ጥሩ', "Baay'ee bayyeessaa", "Excellent")
  ];

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      final res = await http.get(Uri.parse(Api.baseUrl + "/employee"));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        setState(() {
          offices = data.map((e) => Employee.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load employees");
      }
    } catch (e) {
      print("Error loading employees: $e");
      setState(() => isLoading = false);
    }
  }

  int? findEmployeeIdByAmharicName(String name) {
    return offices
        .firstWhere(
          (e) => e.amharic_name == name,
          orElse: () => Employee(
            id: -1,
            amharic_name: "",
            oromic_name: "",
            english_name: "",
            position: "",
            oromic_position: "",
            english_position: "",
            path: "",
            office: "",
            hasSub: false,
          ),
        )
        .id;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && selectedOffice != null) {
      int employee_id = findEmployeeIdByAmharicName(selectedOffice!)!;
      Map<String, String> data = {
        'CustomerService': (selectedValues["CustomerService"]! + 1).toString(),
        'StandardService': (selectedValues["StandardService"]! + 1).toString(),
        'FairService': (selectedValues["FairService"]! + 1).toString(),
        'ResponseForCompliment':
            (selectedValues["ResponseForCompliment"]! + 1).toString(),
        'ServiceRate': (selectedValues["ServiceRate"]! + 1).toString(),
        'EmployeeId': employee_id.toString(),
        'name': _fullNameController.text,
        'phone': _phoneController.text
      };

      try {
        final response =
            await http.post(Uri.parse(Api.baseUrl + '/rate'), body: data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text(AppLocalizations.of(context)!.form_sumbitted,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ));
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LanguageSelector()));
      } catch (e) {
        print("Submit failed: $e");
      }
    }
  }

  String getEmployeeName(Employee e) {
    final locale = AppLocalizations.of(context)!.localeName;
    return locale == "am"
        ? e.amharic_name
        : locale == "es"
            ? e.english_name
            : e.oromic_name;
  }

  @override
  Widget build(BuildContext context) {
    final formWidth = MediaQuery.of(context).size.width * 0.7;

    if (isLoading) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: customAppBar(context, false)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: customAppBar(context, false)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              Text(AppLocalizations.of(context)!.service_rate_title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              DropdownButton<String>(
                hint: Text(AppLocalizations.of(context)!.select_an_office),
                value: selectedOffice,
                onChanged: (val) => setState(() => selectedOffice = val),
                items: offices.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.amharic_name,
                    child: Row(
                      children: [
                        // Image.asset(
                        //   e.path != ""
                        //       ? 'assets/employee/${e.path}'
                        //       : 'assets/icons/profile_holder.jpg',
                        //   width: 50,
                        //   height: 60,
                        //   fit: BoxFit.cover,
                        // ),
                        e.path != null && e.path != ""
                            ? Image.network(
                                '${Api.baseUrl}/public/${e.path}',
                                width: 50,
                                height: 70,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/icons/profile_holder.jpg',
                                width: 50,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                        SizedBox(width: 10),
                        Text(getEmployeeName(e)),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: formWidth,
                child: TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.name),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your name' : null,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: formWidth,
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.phone_number),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter phone number' : null,
                ),
              ),
              SizedBox(height: 25),
              Table(
                border: TableBorder.all(width: 0),
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.localeName == "am"
                              ? Evaluation.amharic_name
                              : AppLocalizations.of(context)!.localeName == "es"
                                  ? Evaluation.english_name
                                  : Evaluation.oromic_name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ...ratings.map((r) => TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.localeName == "am"
                                  ? r.amharic_name
                                  : AppLocalizations.of(context)!.localeName ==
                                          "es"
                                      ? r.english_name
                                      : r.oromic_name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                  ]),
                  ...standards.map((s) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.localeName == "am"
                                ? s.amharic_name
                                : AppLocalizations.of(context)!.localeName ==
                                        "es"
                                    ? s.english_name
                                    : s.oromic_name,
                          ),
                        ),
                        ...ratings.asMap().entries.map((entry) {
                          return Radio<int>(
                            value: entry.key,
                            groupValue: selectedValues[s.value],
                            activeColor: Colors.green,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValues[s.value] = value;
                              });
                            },
                          );
                        }).toList()
                      ],
                    );
                  }).toList()
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(AppLocalizations.of(context)!.submit),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(250, 45),
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromRGBO(11, 73, 118, 1),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class Standard {
  String value;
  String amharic_name;
  String oromic_name;
  String english_name;
  Standard(this.value, this.amharic_name, this.oromic_name, this.english_name);
}

class Rating {
  String value;
  String amharic_name;
  String oromic_name;
  String english_name;
  Rating(this.value, this.amharic_name, this.oromic_name, this.english_name);
}

class Evaluation {
  static String amharic_name = "የግምገማ ነጥብ ደረጃ";
  static String oromic_name = "Sadarkaa Qabxii Madaallii";
  static String english_name = "Rating Points";
}
