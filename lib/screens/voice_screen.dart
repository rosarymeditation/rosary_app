import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rosary/widgets/main_text.dart';

import '../service_text_to_speech/voice_service.dart';
// Replace with the path to your GoogleTextToSpeech class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextToSpeechDemo(),
    );
  }
}

class TextToSpeechDemo extends StatefulWidget {
  @override
  _TextToSpeechDemoState createState() => _TextToSpeechDemoState();
}

class _TextToSpeechDemoState extends State<TextToSpeechDemo> {
  final String _apiKey = 'YOUR_API_KEY';
  final GoogleTextToSpeech _tts = GoogleTextToSpeech();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isLoading = false;

  void _speakText(String text) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final audioFile =
          await _tts.textToSpeech(text, "en-GB", "en-GB-Wavenet-A");

      // Updated to use DeviceFileSource
      await _audioPlayer.play(DeviceFileSource(audioFile.path));
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speech'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  _speakText(
                      "This verse is a reminder of the strength and support we can find through faith. If you need another verse, feel free to ask!");
                },
                child: MainText(
                  text: "Speak",
                  color: Colors.black,
                ))
            // TextField(
            //   onSubmitted: (text) {
            //     _speakText(text);
            //   },
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: 'Enter text',
            //   ),
            // ),
            // if (_isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
