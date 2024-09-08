import 'package:flutter/material.dart';
import 'package:post_test/widgets/video_post_widget.dart';
import '../model/post_model.dart';
import '../post_enum.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Function(Post) onShare;
  final Function(String) onOpenInBrowser;

  const PostWidget({
    super.key,
    required this.post,
    required this.onShare,
    required this.onOpenInBrowser,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // Scrollable for all screen sizes
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (post.type == PostType.text)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: const EdgeInsets.all(10),
              color: Colors.grey[300],
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8, // Dynamic width
              child: const SingleChildScrollView(
                scrollDirection: Axis.vertical,  // Ensures vertical scrolling
                child:  Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Why do we use it? It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham............................',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          if (post.type == PostType.image)
            Image.network(
              post.content,  // Display the actual image URL
              height: 200,
              width: MediaQuery.of(context).size.width * 0.7, // Responsive width
              fit: BoxFit.cover,
            ),
          if (post.type == PostType.video)
            VideoPostWidget(
              videoUrl: post.content,
              thumbnailUrl: post.thumbnail ?? '',
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => onOpenInBrowser(post.content),
            child: const Text('Open in Browser'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => onShare(post),
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }
}




