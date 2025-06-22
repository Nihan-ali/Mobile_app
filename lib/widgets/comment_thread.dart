// lib/widgets/comment_thread.dart
import 'package:flutter/material.dart';

class CommentThread extends StatelessWidget {
  const CommentThread({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Comment Thread",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/Profile.png'),
          ),
          title: Text("User Name"),
          subtitle: Text("This is a comment from a user."),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/Profile.png'),
          ),
          title: Text("Another User"),
          subtitle: Text("Another comment goes here."),
        ),
      ],
    );
  }
}
