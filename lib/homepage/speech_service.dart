import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  // Custom responses mapping
  final Map<String, String> _responses = {
    "girlfriend of akash": "Pratyusha",
    "hello": "Hi there! I'm Nikki. How can I help you today?",
    "exercise": "Let's do some fun exercises!",
    "food":
        "Eating healthy food is important for staying fit. Let's choose some healthy snacks!",
    "homework": "Remember, a good balance of study and play is important!",
    "play": "Playtime is great! What game would you like to play today?",
    "goodbye": "Goodbye! See you next time. Keep moving and stay fit!",
  };

  String _lastResponse = "";

  Future<void> initialize() async {
    await _speech.initialize();
    _flutterTts.setLanguage("en-US");
    _flutterTts.setSpeechRate(0.5);
  }

  Future<void> startListening(Function(String) onResult) async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(onResult: (result) {
        if (result.hasConfidenceRating && result.confidence > 0.5) {
          onResult(result.recognizedWords);
        }
      });
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  Future<void> speak(String text) async {
    if (text != _lastResponse) {
      _lastResponse = text;
      await _flutterTts.speak(text);
    }
  }

  // Get a custom response based on the input text
  String getCustomResponse(String input) {
    for (var key in _responses.keys) {
      if (input.contains(key)) {
        return _responses[key]!;
      }
    }
    return "Sorry, I didn't understand that.";
  }
}
