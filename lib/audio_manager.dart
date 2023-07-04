import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static AudioPlayer audioPlayer = AudioPlayer();
  static String? currentAudioPath;
  static AudioCache cache = AudioCache();

  static Future<void> playAudio(String audioPath) async {
    if (currentAudioPath != audioPath) {
      await stopAudio();
      currentAudioPath = audioPath;
      await audioPlayer.play(AssetSource(audioPath));
    }
  }

  static Future<void> stopAudio() async {
    await audioPlayer.stop();
    // currentAudioPath = null;
  }
}
