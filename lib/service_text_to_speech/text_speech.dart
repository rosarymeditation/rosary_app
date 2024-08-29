import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechScreen extends StatelessWidget {
  TextToSpeechScreen({super.key});
  FlutterTts flutterTts = FlutterTts();

  play() async {
    flutterTts.speak(
        "Deep sleep music itself is not inherently religious. It is a genre of music specifically designed to promote relaxation and assist with falling asleep. This type of music typically incorporates calming melodies, soothing instrumental sounds, and gentle rhythms to induce a sense of calm and tranquility.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            InkWell(
                onTap: () {
                  play();
                },
                child: Icon(Icons.play_arrow))
          ],
        ),
      ),
    );
  }
}
