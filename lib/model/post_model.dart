import '../post_enum.dart';

class Post {
  final String id;
  final String content;
  final PostType type;
  final String title;
  final String? thumbnail; // Add thumbnail field for video posts

  Post({required this.id, required this.content, required this.type, required this.title, this.thumbnail});
}