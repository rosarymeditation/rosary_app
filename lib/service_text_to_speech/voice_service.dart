// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class GoogleTTSService {
//   final String apiKey =
//       'AIzaSyAw6l4HVAJBP58FJmAPFwSbtcyEZaUoWVQ'; // Replace with your API key

//   Future<String> textToSpeech(String text) async {
//     //https://texttospeech.googleapis.com/v1beta1/text:synthesize
//     final url =
//         'https://texttospeech.googleapis.com/v1/text:synthesize?key=$apiKey';

//     final headers = {
//       HttpHeaders.contentTypeHeader: 'application/json',
//     };

//     final body = jsonEncode({
//       'input': {'text': text},
//       'voice': {
//         'languageCode': 'en-US',
//         'name': 'en-US-Wavenet-F'
//       }, // Female voice
//       'audioConfig': {'audioEncoding': 'MP3'},
//     });

//     final response =
//         await http.post(Uri.parse(url), headers: headers, body: body);

//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body);
//       final audioContent = responseBody['audioContent'];
//       return audioContent; // Base64 encoded audio content
//     } else {
//       throw Exception('Failed to synthesize speech: ${response.reasonPhrase}');
//     }
//   }
// }
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class GoogleTTSService {
//   final String apiKey =
//       'AIzaSyAw6l4HVAJBP58FJmAPFwSbtcyEZaUoWVQ'; // Replace with your API key

//   Future<String?> textToSpeech(String text) async {
//     final url =
//         'https://texttospeech.googleapis.com/v1/text:synthesize?key=$apiKey';

//     final headers = {
//       'Content-Type': 'application/json',
//     };

//     final body = jsonEncode({
//       'input': {'text': text},
//       'voice': {
//         'languageCode': 'en-US',
//         'name': 'en-US-Wavenet-F'
//       }, // Female voice
//       'audioConfig': {'audioEncoding': 'MP3'},
//     });

//     final response =
//         await http.post(Uri.parse(url), headers: headers, body: body);

//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body);
//       print("okay it has returned voice");
//       return responseBody['audioContent']; // Base64 encoded audio content
//     } else {
//       print(
//           'Failed to synthesize speech: ${response.statusCode} ${response.reasonPhrase}');
//       return null;
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class GoogleTextToSpeech {
  final String _apiEndpoint =
      "https://texttospeech.googleapis.com/v1/text:synthesize";
  String apiKey = "AIzaSyAw6l4HVAJBP58FJmAPFwSbtcyEZaUoWVQ";

  //GoogleTextToSpeech(apiKey);

  Future<File> textToSpeech(String text, String lang, String voiceName) async {
    final requestBody = jsonEncode({
      "input": {"text": text},
      "voice": {
        "languageCode": lang,
        "name": voiceName,
        "ssmlGender": "NEUTRAL",
      },
      "audioConfig": {"audioEncoding": "MP3"},
    });

    final response = await http.post(
      Uri.parse("$_apiEndpoint?key=$apiKey"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      print("Was very very successful");
      final responseJson = jsonDecode(response.body);
      final audioContent = responseJson['audioContent'];

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/output.mp3';

      final file = File(filePath);
      await file.writeAsBytes(base64Decode(audioContent));

      return file;
    } else {
      throw Exception(
          'Failed to generate speech: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
