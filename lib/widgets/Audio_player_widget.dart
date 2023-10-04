import 'package:audio_player_app/Models/audio_model.dart';
import 'package:audio_player_app/utils/constants.dart';
import 'package:audio_player_app/widgets/player_button.dart';
import 'package:audio_player_app/widgets/seekbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerW extends StatelessWidget {
  const AudioPlayerW({
    Key? key,
    required this.audio,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
    required Future<void> Function() playPauseCallback,
  })  : _seekBarDataStream = seekBarDataStream,
        super(key: key);

  final Audio audio;
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 50.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            audio.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: kBackgroundColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            audio.description,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: kBackgroundColor),
          ),
          const SizedBox(height: 30),
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero,
                duration: positionData?.duration ?? Duration.zero,
                onChangeEnd: audioPlayer.seek,
              );
            },
          ),
          PlayerButtons(audioPlayer: audioPlayer),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: kBackgroundColor,
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.cloud_download,
                  color: kBackgroundColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
