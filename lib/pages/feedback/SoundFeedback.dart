import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nifas_silk/constants/BaseApi.dart';
import 'package:nifas_silk/pages/LanguageSelector.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  bool isRecording = false;
  late final record;
  String? _filePath;
  bool buttonIsDisabled = true;

  String? name;
  String? phoneNumber;

  TextEditingController nameController =
      TextEditingController(); // Controller for name field
  TextEditingController phoneController =
      TextEditingController(); // Controller for phone field

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    updateButtonDisabled();
  }

  Future<void> _initializeRecorder() async {
    // await Permission.microphone.request();
    try {
      record = AudioRecorder();
      debugPrint('Recorder initialized / opened');
    } catch (e) {
      debugPrint(" ERROR $e");
    }
  }

  @override
  void dispose() {
    record.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String getPlatformSpecificPath(String fileName) {
    if (Platform.isWindows) {
      return 'C:/Users/Public/$fileName';
    } else if (Platform.isLinux || Platform.isMacOS) {
      return '/home/user/$fileName';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  String generateSecureRandomString(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(Uint8List.fromList(values)).substring(0, length);
  }

  Future<void> _startRecording() async {
    try {
      print("=========== START RECORDING ============");

      final tempDir = Directory.systemTemp;

      // Create a subdirectory inside the temporary directory
      final subDir = Directory('${tempDir.path}/kality_audio');

      // Ensure the directory exists (creates it if it doesn't)
      if (!await subDir.exists()) {
        await subDir.create(recursive: true);
        print('Subdirectory created: ${subDir.path}');
      } else {
        print('Subdirectory already exists: ${subDir.path}');
      }

      // Generate a unique file name
      final fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.aac';

      // Full path to the new file
      final path = '${subDir.path}/$fileName';
      print('File path: $path');

      // Start recording
      await record.start(const RecordConfig(), path: path);
      setState(() {
        isRecording = true;
        _filePath = path;
      });
    } catch (e) {
      debugPrint('ERROR WHILE RECORDING: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to start recording.',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  Future<void> _stopRecording() async {
    try {
      _filePath = await record.stop();
      debugPrint('Recording stopped. File saved at: $_filePath');
      setState(() {
        isRecording = false;
      });
      _showConfirmationDialog();
    } catch (e) {
      debugPrint('ERROR WHILE STOP RECORDING: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something Went Wrong !',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  void _record() async {
    await _stopRecording();
    setState(() {
      isRecording = false;
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Submit Recording'),
          content: Text(AppLocalizations.of(context)!.are_you_sure),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(AppLocalizations.of(context)!.no),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _submitAudio();
              },
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitAudio() async {
    try {
      final uri = Uri.parse(Api.baseUrl + '/feedback/file');
      debugPrint('Submitting audio file: $_filePath');
      if (_filePath == null) return;

      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('audio', _filePath!));
      request.fields['name'] = nameController.text; // Replace with actual name
      request.fields['phone'] =
          phoneController.text; // Replace with actual phone number
      final response = await request.send();
      if (response.statusCode == 200) {
        debugPrint('Audio submitted successfully');
        // Optionally show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Audio Submitted!',
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Error While Submitting',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('ERROR WHILE SUBMITTING AUDIO: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            'Error While Submitting ',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  void updateButtonDisabled() {
    nameController.addListener(() {
      if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
        setState(() {
          buttonIsDisabled = false;
        });
      } else {
        setState(() {
          buttonIsDisabled = true;
        });
      }
    });
    phoneController.addListener(() {
      if (nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          phoneController.text.length == 10) {
        setState(() {
          buttonIsDisabled = false;
        });
      } else {
        setState(() {
          buttonIsDisabled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Set the desired height here
          child: customAppBar(context, false)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
        child: Column(
          children: [
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                AppLocalizations.of(context)!.audio_description,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )),
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.name,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: 300,
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.phone_number,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
                SizedBox(width: 216.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isRecording) const CustomRecordingWaveWidget(),
                    const SizedBox(height: 16),
                    CustomRecordingButton(
                      isRecording: isRecording,
                      onPressed: isRecording ? _stopRecording : _startRecording,
                      isDisabled: buttonIsDisabled,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRecordingWaveWidget extends StatefulWidget {
  const CustomRecordingWaveWidget({super.key});

  @override
  State<CustomRecordingWaveWidget> createState() => _RecordingWaveWidgetState();
}

class _RecordingWaveWidgetState extends State<CustomRecordingWaveWidget> {
  final List<double> _heights = [0.05, 0.07, 0.1, 0.07, 0.05];
  Timer? _timer;

  @override
  void initState() {
    _startAnimating();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimating() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        // This is a simple way to rotate the list, creating a wave effect.
        _heights.add(_heights.removeAt(0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _heights.map((height) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 20,
            height: MediaQuery.sizeOf(context).height * height,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomRecordingButton extends StatelessWidget {
  const CustomRecordingButton(
      {super.key,
      required this.isRecording,
      required this.onPressed,
      required this.isDisabled});

  final bool isRecording;
  final bool isDisabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        height: 100,
        width: 100,
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(
          isRecording ? 25 : 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blue,
            width: isRecording ? 8 : 3,
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: isRecording ? BoxShape.rectangle : BoxShape.circle,
          ),
          child: MaterialButton(
            onPressed: isDisabled ? null : onPressed,
            disabledColor: Colors.grey,
            shape: const CircleBorder(),
            child: const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
