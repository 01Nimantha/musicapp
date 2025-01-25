import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/pages/add_music.dart';

class PlayerScreen extends StatefulWidget {
  final List<String> songList;
  final List<String> imageList;
  final List<String> artistList;

  const PlayerScreen({
    super.key,
    required this.songList,
    required this.imageList,
    required this.artistList,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool isPlaying = false;
  IconData playBtn = Icons
      .pause_circle_outline_rounded; // Default to pause icon since we start playing immediately
  late AudioPlayer _player;
  Duration position = const Duration();
  Duration musicLength = const Duration();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    // Set up listeners
    _player.onDurationChanged.listen((Duration d) {
      setState(() {
        musicLength = d;
      });
    });

    _player.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });

    _player.onPlayerComplete.listen((_) {
      playNext(); // Automatically play next song when the current one finishes
    });

    // Start playing the first song automatically
    playPauseAudio();
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.blue[800],
      inactiveColor: Colors.grey[350],
      value: position.inSeconds.toDouble(),
      max: musicLength.inSeconds.toDouble(),
      onChanged: (value) {
        seekToSec(value.toInt());
      },
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  void playPauseAudio() {
    if (!isPlaying) {
      _player.play(AssetSource(widget.songList[currentIndex]));
      setState(() {
        playBtn = Icons.pause_circle_outline_rounded;
        isPlaying = true;
      });
    } else {
      _player.pause();
      setState(() {
        playBtn = Icons.play_circle_outline_rounded;
        isPlaying = false;
      });
    }
  }

  void playNext() {
    if (currentIndex < widget.songList.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0; // Reset to the first song
    }
    _player.stop();
    playPauseAudio();
  }

  void playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
    } else {
      currentIndex = widget.songList.length - 1; // Set to the last song
    }
    _player.stop();
    playPauseAudio();
  }

  void showSongList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: widget.songList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(widget.imageList[index]),
              ),
              title: Text(widget.songList[index].substring(
                  widget.songList[index].indexOf("/") + 1,
                  widget.songList[index].indexOf("."))),
              subtitle: Text(widget.artistList[index]),
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
                _player.stop();
                playPauseAudio();
                Navigator.pop(context); // Close the bottom sheet
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 32,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MusicPage()),
                );
              },
              icon: const Icon(
                Icons.audio_file_outlined,
                size: 30,
              ))
        ],
        backgroundColor: const Color.fromRGBO(246, 237, 247, 1),
        title: const Text(
          "Now Playing",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFe6eefe),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [
              //     Colors.purple[800]!,
              //     Colors.purple[200]!,
              //   ],
              // ),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: isLandscape
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(widget.imageList[currentIndex]),
                            radius: 80,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        height: 150,

                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0), // Add padding around the content
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                              246, 237, 247, 1), // Highlight color
                          borderRadius:
                              BorderRadius.circular(16.0), // Rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align text to the start
                                children: [
                                  const Text(
                                    'Song Title :',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\t\t\t\t\t\t\t\t\t\t\t ${widget.songList[currentIndex].substring(widget.songList[currentIndex].indexOf("/") + 1, widget.songList[currentIndex].indexOf("."))}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  const Text(
                                    'Singer Name :',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\t\t\t\t\t\t\t\t\t\t\t ${widget.artistList[currentIndex]}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          slider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 40.0,
                                color: Colors.black,
                                onPressed: playPrevious,
                                icon: const Icon(
                                  Icons.skip_previous_rounded,
                                ),
                              ),
                              IconButton(
                                iconSize: 56.0,
                                color: Colors.black,
                                onPressed: playPauseAudio,
                                icon: Icon(playBtn),
                              ),
                              IconButton(
                                iconSize: 40.0,
                                color: Colors.black,
                                onPressed: playNext,
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage(widget.imageList[currentIndex]),
                        radius: 100,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        height: 150,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0), // Add padding around the content
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                              246, 237, 247, 1), // Highlight color
                          borderRadius:
                              BorderRadius.circular(16.0), // Rounded corners
                        ),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align text to the start
                            children: [
                              const Text(
                                'Song Title :',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\t\t\t\t\t\t\t\t\t\t\t ${widget.songList[currentIndex].substring(widget.songList[currentIndex].indexOf("/") + 1, widget.songList[currentIndex].indexOf("."))}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              const Text(
                                'Singer Name :',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\t\t\t\t\t\t\t\t\t\t\t ${widget.artistList[currentIndex]}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          slider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 40.0,
                                color: Colors.black,
                                onPressed: playPrevious,
                                icon: const Icon(
                                  Icons.skip_previous_rounded,
                                ),
                              ),
                              IconButton(
                                iconSize: 56.0,
                                color: Colors.black,
                                onPressed: playPauseAudio,
                                icon: Icon(playBtn),
                              ),
                              IconButton(
                                iconSize: 40.0,
                                color: Colors.black,
                                onPressed: playNext,
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: GestureDetector(
                        onTap: showSongList, // Show song list on tap
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  16.0), // Add padding around the content
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(
                                246, 237, 247, 1), // Highlight color
                            borderRadius:
                                BorderRadius.circular(16.0), // Rounded corners
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.queue_music_rounded,
                                color: Colors.black,
                                size: 32,
                              ),
                              Expanded(
                                child: Text(
                                  "\t\t ${widget.songList[currentIndex]} \t\t",
                                  overflow: TextOverflow
                                      .ellipsis, // Handle long text gracefully
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const Icon(Icons.keyboard_double_arrow_up_rounded,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
