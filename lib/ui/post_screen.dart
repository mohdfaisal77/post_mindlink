import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/post_model.dart';
import '../post_enum.dart';
import '../widgets/post_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  int _selectedIndex = 0;

  final List<Post> _posts = [
    Post(id: '1', content: 'https://www.lipsum.com/', type: PostType.text, title: 'Text Post'),
    Post(id: '2', content: 'https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      type: PostType.image,
      title: 'Image Post',),
    Post(id: '3', content: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', type: PostType.video, title: 'Video Post'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _sharePost(Post post) {
    Share.share('Check out this post: ${post.content}');
  }

  Future<void> _openInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              elevation: 5,
              backgroundColor: Colors.transparent,
              title: Text(
                _posts[_selectedIndex].title,
                style:const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Lato',
                ),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blueAccent, Colors.deepPurpleAccent]),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: PostWidget(
                      post: _posts[_selectedIndex],
                      onShare: _sharePost,
                      onOpenInBrowser: _openInBrowser,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Text'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Image'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Video'),
        ],
      ),
    );
  }
}
