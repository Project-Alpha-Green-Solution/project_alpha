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
  }

  static Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  static Future<void> resumeAudio(String audioPath) async {
    if (audioPlayer.state == PlayerState.completed) {
      // If audio playback is complete, start playing again
      await audioPlayer.play(AssetSource(audioPath));
    } else {
      // If audio is still playing, resume playback
      await audioPlayer.resume();
    }
  }

}
