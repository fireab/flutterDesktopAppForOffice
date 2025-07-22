import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nifas_silk/constants/BaseApi.dart';
import 'package:nifas_silk/pages/feedback/SoundFeedback.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:nifas_silk/pages/LanguageSelector.dart';

class CompanyFeedbackForm extends StatefulWidget {
  @override
  _CompanyFeedbackFormState createState() => _CompanyFeedbackFormState();
}

class _CompanyFeedbackFormState extends State<CompanyFeedbackForm> {
  String feedbackType = 'comment';
  final TextEditingController contentController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final feedbackData = {
        'feedbackType': feedbackType,
        'content': contentController.text,
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(Api.baseUrl + "/feedback"),
          body: feedbackData,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form submitted successfully!')),
          );
          // Redirect to language page after successful submission
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LanguageSelector()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Submission failed! Please try again.')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submission failed! Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Set the desired height here
          child: customAppBar(context, false)),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.1, 0, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.feed_back_form,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.feed_back_form_description,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordingScreen()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16), // Padding
                        decoration: BoxDecoration(
                          color: Colors.blue, // Background color
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26, // Shadow color
                              blurRadius: 4, // Shadow blur radius
                              offset: Offset(2, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!
                                .choose_feed_back_audio,
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.feed_back_type,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FeedbackTypeButton(
                          label: AppLocalizations.of(context)!.comment,
                          selected: feedbackType == 'comment',
                          onTap: () => setState(() => feedbackType = 'comment'),
                        ),
                        SizedBox(width: 16),
                        FeedbackTypeButton(
                          label: AppLocalizations.of(context)!.suggestion,
                          selected: feedbackType == 'suggestion',
                          onTap: () =>
                              setState(() => feedbackType = 'suggestion'),
                        ),
                        SizedBox(width: 16),
                        FeedbackTypeButton(
                          label: AppLocalizations.of(context)!.question,
                          selected: feedbackType == 'question',
                          onTap: () =>
                              setState(() => feedbackType = 'question'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: contentController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.your_feed_back,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.name,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.phone_number,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: handleSubmit,
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      label: Text(AppLocalizations.of(context)!.submit,
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 22),
                          backgroundColor: Color.fromRGBO(11, 73, 118, 1),
                          textStyle: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeedbackTypeButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  FeedbackTypeButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Theme.of(context).primaryColor : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
          color: selected ? Theme.of(context).primaryColor : Colors.transparent,
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
