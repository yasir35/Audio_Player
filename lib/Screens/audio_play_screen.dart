import 'package:audio_player_app/Models/audio_model.dart';
import 'package:audio_player_app/utils/constants.dart';
import 'package:audio_player_app/widgets/Audio_player_widget.dart';
import 'package:audio_player_app/widgets/seekbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class AudioPlayScreen extends StatefulWidget {
  late final int audioIndex;

  AudioPlayScreen({super.key, required this.audioIndex});

  @override
  State<AudioPlayScreen> createState() => _AudioPlayScreenState();
}

class _AudioPlayScreenState extends State<AudioPlayScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  late Audio audio;

  @override
  void initState() {
    super.initState();
    audio = Audio.audio[widget.audioIndex];
    audioPlayer.setUrl(audio.url);
    audioPlayer.load();
    audioPlayer.playerStateStream.listen((state) {
      if (state!.processingState == ProcessingState.completed) {
        audioPlayer.seek(Duration.zero);
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream,
        audioPlayer.durationStream,
        (
          Duration position,
          Duration? duration,
        ) {
          return SeekBarData(
            position,
            duration ?? Duration.zero,
          );
        },
      );

  Future<void> playAudio() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  Future<void> playNextAudio() async {
    if (widget.audioIndex < Audio.audio.length - 1) {
      widget.audioIndex++;
      audio = Audio.audio[widget.audioIndex];
      await audioPlayer.setUrl(audio.url);
      await audioPlayer.play();
    }
  }

  Future<void> playPreviousAudio() async {
    if (widget.audioIndex > 0) {
      widget.audioIndex--;
      audio = Audio.audio[widget.audioIndex];
      await audioPlayer.setUrl(audio.url);
      await audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            audio.coverUrl,
            fit: BoxFit.cover,
          ),
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kBackgroundColor,
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.0),
                ],
                stops: const [0.0, 0.4, 0.6],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kLightDeepColor, kDeepPurpleColor],
                ),
              ),
            ),
          ),
          AudioPlayerW(
            audio: audio,
            seekBarDataStream: _seekBarDataStream,
            audioPlayer: audioPlayer,
            playPauseCallback: playAudio, // Add this callback
          ),
        ],
      ),
    );
  }
}
