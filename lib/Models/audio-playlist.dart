import 'package:audio_player_app/Models/audio_model.dart';

class Playlist {
  final String title;
  final List<Audio> audios;
  final String imageUrl;

  Playlist({
    required this.title,
    required this.audios,
    required this.imageUrl,
  });

  static List<Playlist> playlists = [
    Playlist(
      title: 'Hip-hop R&B Mix',
      audios: Audio.audio,
      imageUrl: 'assets/images/2.jpg',
    ),
    Playlist(
      title: 'Rock & Roll',
      audios: Audio.audio,
      imageUrl: 'assets/images/4.jpg',
    ),
    Playlist(
      title: 'Techno',
      audios: Audio.audio,
      imageUrl: 'assets/images/5.jpg',
    )
  ];
}
