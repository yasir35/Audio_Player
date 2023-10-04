import 'package:audio_player_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: audioPlayer.hasPrevious
              ? () => audioPlayer.seekToPrevious()
              : null,
          iconSize: 45,
          icon: const Icon(
            Icons.skip_previous,
            color: kBackgroundColor,
          ),
        ),
        IconButton(
          onPressed: () async {
            final newPosition =
                audioPlayer.position - const Duration(seconds: 10);
            await audioPlayer.seek(newPosition);
          },
          iconSize: 45,
          icon: const Icon(
            Icons.replay_10,
            color: kBackgroundColor,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data!;
              final processingState = playerState.processingState;

              return processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering
                  ? Container(
                      width: 64.0,
                      height: 64.0,
                      margin: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator(),
                    )
                  : audioPlayer.playing
                      ? IconButton(
                          icon: const Icon(
                            Icons.pause_circle,
                            color: kBackgroundColor,
                          ),
                          iconSize: 75.0,
                          onPressed: () async {
                            await audioPlayer.pause();
                          },
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.play_circle,
                            color: kBackgroundColor,
                          ),
                          iconSize: 75,
                          onPressed: () async {
                            if (audioPlayer.position == audioPlayer.duration) {
                              await audioPlayer.seek(Duration.zero);
                            }
                            await audioPlayer.play();
                          },
                        );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        IconButton(
          onPressed: () async {
            final newPosition =
                audioPlayer.position + const Duration(seconds: 10);
            await audioPlayer.seek(newPosition);
          },
          iconSize: 45,
          icon: const Icon(
            Icons.forward_10,
            color: kBackgroundColor,
          ),
        ),
        IconButton(
          onPressed:
              audioPlayer.hasNext ? () => audioPlayer.seekToNext() : null,
          iconSize: 45,
          icon: const Icon(
            Icons.skip_next,
            color: kBackgroundColor,
          ),
        ),
      ],
    );
  }
}
