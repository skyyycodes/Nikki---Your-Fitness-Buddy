import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:gemini_chat_app_tutorial/homepage/speech_screen.dart'; // Adjust import paths accordingly
import 'package:gemini_chat_app_tutorial/Doctor Chat/doctor_chat.dart';
import 'package:gemini_chat_app_tutorial/chatbot/home_page.dart';
import 'package:gemini_chat_app_tutorial/Profile page/Profile_page.dart';
import 'package:gemini_chat_app_tutorial/Diet Page/diet_page.dart';

class EpisodesPage extends StatefulWidget {
  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.list,
    Icons.chat,
    Icons.home,
    Icons.chat_bubble,
    Icons.person,
  ];

  late VideoPlayerController _controller;
  int _currentEpisodeIndex = 0;

  final List<Episode> episodes = [
    Episode(
      title: 'Episode 1',
      videoUrl: 'https://sample-videos.com/video123/mp4/480/asdasdas.mp4',
    ),
    Episode(
      title: 'Episode 2',
      videoUrl: 'https://sample-videos.com/video123/mp4/480/big_buck_bunny.mp4',
    ),
    Episode(
      title: 'Episode 3',
      videoUrl: 'https://sample-videos.com/video123/mp4/480/waterfall.mp4',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(_currentEpisodeIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer(int index) {
    _controller = VideoPlayerController.network(episodes[index].videoUrl)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(false)
      ..initialize().then((_) => _controller.play());
  }

  void _playEpisode(int index) {
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
    _controller.dispose();
    setState(() {
      _currentEpisodeIndex = index;
    });
    _initializeVideoPlayer(index);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic here based on the selected index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EpisodesPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SpeechScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatWithDoctorPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Episodes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.purple.shade600,
              Colors.pink.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: Colors.blue.shade800,
                backgroundColor: Colors.grey,
                bufferedColor: Colors.blue.shade200,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        episodes[index].title,
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => _playEpisode(index),
                      trailing: Icon(
                        Icons.play_circle_outline,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade800,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _icons,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.defaultEdge,
        backgroundColor: Colors.blue.shade800,
        activeColor: Colors.white,
        inactiveColor: Colors.grey[700],
        onTap: _onItemTapped,
        splashColor: Colors.blue.shade600,
      ),
    );
  }
}

class Episode {
  final String title;
  final String videoUrl;

  Episode({required this.title, required this.videoUrl});
}
