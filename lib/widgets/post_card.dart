import 'package:flutter/material.dart';
import 'dart:io';


class PostCard extends StatefulWidget {
  final String user;
  final String userImage;
  final String time;
  final String? caption; // <- nullable
  final List<String> images;
  final int comments;
  final int shares;
  final int likes;
  final String extraImage;
  final List<Map<String, dynamic>> commentList;

  const PostCard({
    super.key,
    required this.user,
    required this.userImage,
    required this.time,
    this.caption, // <- nullable caption
    required this.images,
    required this.comments,
    required this.shares,
    required this.likes,
    required this.extraImage,
    required this.commentList,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final comment =
        widget.commentList.isNotEmpty ? widget.commentList.first : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(widget.userImage)),
          title: Text(widget.user,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('${widget.time} · Public'),
          trailing: Image.asset('assets/icons/Other.png', height: 20),
        ),

        // Caption (optional)
        if (widget.caption != null && widget.caption!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(widget.caption!),
          ),

        const SizedBox(height: 8),

        if (widget.images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.images.length == 1 ? 1 : 2,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: widget.images.length == 1 ? 16 / 9 : 1,
              ),
              itemBuilder: (context, index) {
                final path = widget.images[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: path.startsWith('/data') || path.startsWith('/storage')
                      ? Image.file(File(path), fit: BoxFit.cover)
                      : Image.asset(path, fit: BoxFit.cover),
                );
              },
            ),
          ),

        const SizedBox(height: 8),

        // Like & stats row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Image.asset(widget.extraImage, height: 24),
              const SizedBox(width: 6),
              const Spacer(),
              Text('${widget.comments} Comments   ${widget.shares} Share'),
            ],
          ),
        ),

        const Divider(),

        // Buttons Row (bold)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              likeButton(),
              actionItem('assets/icons/comment.png', 'Comments'),
              actionItem('assets/icons/Share.png', 'Share'),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Comment Input Box
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/Profile.png'),
                radius: 16,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Write a comment...",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Image.asset('assets/icons/Gif.png', height: 20),
                      const SizedBox(width: 6),
                      Image.asset('assets/icons/Picture.png', height: 20),
                      const SizedBox(width: 6),
                      Image.asset('assets/icons/Smile.png', height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Image.asset('assets/icons/Send.png', height: 24),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Comment + Reply
        if (comment != null) ...[
          buildComment(comment),
          if (comment['replies'] != null && comment['replies'].isNotEmpty)
            buildReply(comment),
          if (comment['replies'].length > 1)
            Padding(
              padding: const EdgeInsets.only(left: 60, bottom: 12),
              child: Text(
                'See ${comment['replies'].length - 1} more replies',
                style: const TextStyle(color: Colors.blue),
              ),
            ),
        ],
      ],
    );
  }

  Widget buildComment(Map<String, dynamic> comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(comment['userImage']),
            radius: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x11000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment['user'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(comment['text']),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Text("Like", style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 12),
                    Text("Reply", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReply(Map<String, dynamic> comment) {
    final reply = comment['replies'][0];
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 12, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(reply['userImage']),
            radius: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reply['user'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Replying to ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                              TextSpan(
                                text: comment['user'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(reply['text']),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Text("Like", style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 12),
                    Text("Reply", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget likeButton() {
    return GestureDetector(
      onTap: () => setState(() => isLiked = !isLiked),
      child: Row(
        children: [
          Image.asset(
            isLiked ? 'assets/icons/Heart-Fill.png' : 'assets/icons/Heart.png',
            height: 18,
            color: isLiked ? Colors.blue : null,
          ),
          const SizedBox(width: 6),
          Text(
            'Like',
            style: TextStyle(
              color: isLiked ? Colors.blue : null,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget actionItem(String iconPath, String label) {
    return Row(
      children: [
        Image.asset(iconPath, height: 18),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
