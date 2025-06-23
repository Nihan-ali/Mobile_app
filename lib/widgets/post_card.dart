import 'package:flutter/material.dart';
import 'dart:io';

class PostCard extends StatefulWidget {
  final String user;
  final String userImage;
  final String time;
  final String? caption;
  final List<String> images;
  final int comments;
  final int shares;
  final int likes;
  final String extraImage;
  final List<Map<String, dynamic>> commentList;
  final String postId; // Added to uniquely identify posts

  const PostCard({
    super.key,
    required this.user,
    required this.userImage,
    required this.time,
    this.caption,
    required this.images,
    required this.comments,
    required this.shares,
    required this.likes,
    required this.extraImage,
    required this.commentList,
    required this.postId,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;
  late int likeCount;
  late int commentCount;
  final _commentController = TextEditingController();
  late List<Map<String, dynamic>> comments;
  bool isCommentSectionExpanded = false;
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initialize state with widget values
    isLiked = false; // You can check from a global state/database if user already liked
    likeCount = widget.likes;
    commentCount = widget.comments;
    comments = List.from(widget.commentList);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        isLiked = false;
        likeCount = likeCount > 0 ? likeCount - 1 : 0;
      } else {
        isLiked = true;
        likeCount++;
      }
    });
    
    // Here you would typically call an API to update the like status
    // _updateLikeStatus(widget.postId, isLiked);
  }

  void addComment(String text) {
    if (text.trim().isEmpty) return;
    
    final newComment = {
      'user': 'You', // Replace with actual logged-in user name
      'userImage': 'assets/images/Profile.png', // Replace with actual user image
      'text': text.trim(),
      'replies': [],
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    setState(() {
      comments.insert(0, newComment);
      commentCount++;
      _commentController.clear();
    });

    // Unfocus the text field after adding comment
    _commentFocusNode.unfocus();

    // Here you would typically call an API to save the comment
    // _saveComment(widget.postId, newComment);
  }

  void addReply(int commentIndex, String replyText) {
    if (replyText.trim().isEmpty) return;

    final newReply = {
      'user': 'You', // Replace with actual logged-in user name
      'userImage': 'assets/images/Profile.png', // Replace with actual user image
      'text': replyText.trim(),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    setState(() {
      if (comments[commentIndex]['replies'] == null) {
        comments[commentIndex]['replies'] = [];
      }
      comments[commentIndex]['replies'].add(newReply);
    });

    // Here you would typically call an API to save the reply
    // _saveReply(widget.postId, comments[commentIndex]['id'], newReply);
  }

  void toggleCommentSection() {
    setState(() {
      isCommentSectionExpanded = !isCommentSectionExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE4E6EA), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.userImage),
              radius: 20,
            ),
            title: Text(
              widget.user,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              '${widget.time} · Public',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                // Handle more options
                _showMoreOptions(context);
              },
              icon: Image.asset('assets/icons/Other.png', height: 20),
            ),
          ),

          // Caption
          if (widget.caption != null && widget.caption!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.caption!,
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
            ),

          const SizedBox(height: 12),

          // Images
          if (widget.images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.images.length == 1 ? 1 : 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: widget.images.length == 1 ? 16 / 9 : 1,
                  ),
                  itemBuilder: (context, index) {
                    final path = widget.images[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle image tap (fullscreen view)
                      },
                      child: path.startsWith('/data') || path.startsWith('/storage')
                          ? Image.file(File(path), fit: BoxFit.cover)
                          : Image.asset(path, fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ),

          const SizedBox(height: 12),

          // Like and Comment count
          if (likeCount > 0 || commentCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  if (likeCount > 0) ...[
                    Image.asset(widget.extraImage, height: 20),
                    const SizedBox(width: 6),
                    Text(
                      likeCount.toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                  const Spacer(),
                  if (commentCount > 0)
                    GestureDetector(
                      onTap: toggleCommentSection,
                      child: Text(
                        '$commentCount Comment${commentCount > 1 ? 's' : ''}',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  if (widget.shares > 0) ...[
                    const SizedBox(width: 12),
                    Text(
                      '${widget.shares} Share${widget.shares > 1 ? 's' : ''}',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),

          if (likeCount > 0 || commentCount > 0) const SizedBox(height: 8),

          const Divider(height: 1, color: Color(0xFFE4E6EA)),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLikeButton(),
                _buildActionButton(
                  'assets/icons/comment.png',
                  'Comment',
                  toggleCommentSection,
                  isActive: isCommentSectionExpanded,
                ),
                _buildActionButton(
                  'assets/icons/Share.png',
                  'Share',
                  () {
                    // Handle share
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Comment input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Profile.png'),
                  radius: 16,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _commentController,
                      focusNode: _commentFocusNode,
                      onSubmitted: addComment,
                      onTap: () {
                        if (!isCommentSectionExpanded) {
                          setState(() {
                            isCommentSectionExpanded = true;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Write a comment...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: _commentController.text.trim().isNotEmpty
                        ? Colors.blue
                        : Colors.grey,
                    size: 20,
                  ),
                  onPressed: () => addComment(_commentController.text),
                ),
              ],
            ),
          ),

          // Comments section
          if (isCommentSectionExpanded && comments.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...comments.take(3).map((comment) => _buildCommentItem(comment)),
            if (comments.length > 3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to full comments screen
                  },
                  child: Text(
                    'View ${comments.length - 3} more comments',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildLikeButton() {
    return GestureDetector(
      onTap: toggleLike,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isLiked ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Image.asset(
                isLiked
                    ? 'assets/icons/Heart-Fill.png'
                    : 'assets/icons/Heart.png',
                height: 20,
                color: isLiked ? Colors.blue : Colors.grey,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Like',
              style: TextStyle(
                color: isLiked ? Colors.blue : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String iconPath, String label, VoidCallback onTap,
      {bool isActive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              height: 20,
              color: isActive ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.blue : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(comment['userImage']),
            radius: 16,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment['user'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment['text'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildCommentAction('Like', () {
                      // Handle comment like
                    }),
                    const SizedBox(width: 16),
                    _buildCommentAction('Reply', () {
                      // Handle reply
                      _showReplyDialog(comment);
                    }),
                    const SizedBox(width: 16),
                    const Text(
                      'Just now', // You can format the timestamp
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                // Show replies
                if (comment['replies'] != null && comment['replies'].isNotEmpty)
                  ...comment['replies'].take(2).map((reply) => _buildReplyItem(reply)),
                if (comment['replies'] != null && comment['replies'].length > 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GestureDetector(
                      onTap: () {
                        // Show all replies
                      },
                      child: Text(
                        'View ${comment['replies'].length - 2} more replies',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyItem(Map<String, dynamic> reply) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(reply['userImage']),
            radius: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reply['user'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    reply['text'],
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentAction(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: const Text('Save post'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text('Report post'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showReplyDialog(Map<String, dynamic> comment) {
    final replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reply to ${comment['user']}'),
        content: TextField(
          controller: replyController,
          decoration: const InputDecoration(
            hintText: 'Write a reply...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (replyController.text.trim().isNotEmpty) {
                final commentIndex = comments.indexOf(comment);
                addReply(commentIndex, replyController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Reply'),
          ),
        ],
      ),
    );
  }
}