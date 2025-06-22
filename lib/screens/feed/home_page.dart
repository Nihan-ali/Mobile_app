import 'package:flutter/material.dart';
import '../../constants/mock_data.dart';
import '../../widgets/post_card.dart';
import '../../widgets/event_item.dart';
import '../../widgets/comment_thread.dart';
import 'create_post_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String profileImage = 'assets/images/Profile.png';
  final String iconPath = 'assets/icons/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/Profile.png'),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 167, 162, 162)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search for something here...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon:
                        Image.asset('assets/icons/Search.png', width: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Image.asset('${iconPath}Message.png', height: 24),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          const SizedBox(height: 10),

          // Stories
          // Stories
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: storyUsers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final user = storyUsers[i];
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(user['image']!),
                      radius: 28,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user['name']!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Input Box
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/Profile.png'),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "What's happening?",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              actionItem('Live'),
              actionItem('Photo'),
              actionItem('Feeling'),
              // button will be the rightmost item
              const SizedBox(width: 10), // spacing before button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreatePostPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF377dff),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Post',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),

          const Divider(height: 30),

          // Posts
          for (var post in posts)
            Column(
              children: [
                PostCard(
                  user: post['user'],
                  userImage: post['userImage'],
                  time: post['time'],
                  caption: post['caption'],
                  image: post['image'],
                  comments: post['comments'],
                  shares: post['shares'],
                  likes: post['likes'],
                  extraImage: post['extraImage'],
                  commentList: (post['commentList'] as List).cast<Map<String, dynamic>>(),
                ),
                const Divider(),
              ],
            ),

          // Events
          Row(
            children: const [
              Text("Recent Event",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(Icons.more_horiz),
            ],
          ),
          const SizedBox(height: 10),
          for (var e in events)
            EventItem(
              title: e['title'],
              subtitle: e['subtitle'],
              seen: e['seen'],
              icon: e['icon'],
              groupImage: e['groupImage'],
            ),

          const Divider(),

          // Birthdays
          Row(
            children: const [
              Text("Birthdays",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Spacer(),
              Text("See All", style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 10),
          for (var b in birthdays)
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/Edison.png'),
              ),
              title: Text(b['name']!),
              subtitle: Text(b['note']!),
              trailing: IconButton(
                icon: Image.asset('${iconPath}Send.png', height: 24),
                onPressed: () {},
              ),
            ),
          ListTile(
            leading: Image.asset('${iconPath}Birthday.png', height: 24),
            title: const Text("Upcoming birthdays"),
            subtitle: const Text("See 12 others have upcoming birthdays"),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group), label: 'My community'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                    child: Text('2',
                        style: TextStyle(fontSize: 8, color: Colors.white)),
                  ),
                )
              ],
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget actionItem(String label) {
    String iconFile;
    switch (label) {
      case 'Live':
        iconFile = 'assets/icons/Video-camera.png';
        break;
      case 'Photo':
        iconFile = 'assets/icons/Picture.png';
        break;
      case 'Feeling':
        iconFile = 'assets/icons/Smile.png';
        break;
      default:
        iconFile = 'assets/icons/Logo.png'; // fallback
    }

    return Row(
      children: [
        Image.asset(iconFile, height: 18),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
