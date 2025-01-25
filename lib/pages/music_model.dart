class MusicModel {
  final String name;
  final String imageUrl;
  final String artist;
  final double length;
  late final bool isFav;

  MusicModel({
    required this.name,
    required this.imageUrl,
    required this.artist,
    required this.length,
    required this.isFav,
  });
}

List<MusicModel> musicList = [
  MusicModel(
    name: "Lose it",
    imageUrl: "assets/Houdini.jpeg",
    artist: "Eminem",
    length: 4.40,
    isFav: false,
  ),
];
