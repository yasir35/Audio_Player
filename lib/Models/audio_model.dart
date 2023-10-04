class Audio {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Audio({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

  static List<Audio> audio = [
    Audio(
      title: '1 Tera 1 Mera',
      description: 'Glass',
      url: 'assets/audios/1.mp3',
      coverUrl: 'assets/images/1.jpg',
    ),
    Audio(
      title: 'Rajpal',
      description: 'Illusions',
      url: 'assets/audios/2.mp3',
      coverUrl: 'assets/images/3.jpg',
    ),
    Audio(
      title: 'Kya Soch ai ry teri',
      description: 'Pray',
      url: 'assets/audios/3.mp3',
      coverUrl: 'assets/images/6.jpg',
    )
  ];
}
