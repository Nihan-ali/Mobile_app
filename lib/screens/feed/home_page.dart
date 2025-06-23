import 'package:flutter/material.dart';
import '../../constants/mock_data.dart';
import '../../widgets/post_card.dart';
import '../../widgets/event_item.dart';
import 'create_post_page.dart';
import '../../services/auth_service.dart';
import '../../screens/auth/sign_in_screen.dart';
import '../../constants/route_names.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String profileImage = 'assets/images/Profile.png';
  final String iconPath = 'assets/icons/';
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (!AuthService().isLoggedIn) {
      Future.microtask(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SignInScreen()));
      });
      return const Scaffold();
    }

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

          // Input field only
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
                  height: 40,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What's happening?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Action row with Post button inline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              actionItem('Live'),
              actionItem('Photo'),
              actionItem('Feeling'),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreatePostPage()),
                  );
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF377DFF),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const Divider(height: 30),

          // Posts
          for (var post in posts)
            Column(
              children: [
                PostCard(
                  postId: post['postId'] ?? 'post_${posts.indexOf(post)}',
                  user: post['user'],
                  userImage: post['userImage'],
                  time: post['time'],
                  caption: post['caption'],
                  images: (post['images'] ?? []).cast<String>(),
                  comments: post['comments'],
                  shares: post['shares'],
                  likes: post['likes'],
                  extraImage: post['extraImage'],
                  commentList:
                      (post['commentList'] ?? []).cast<Map<String, dynamic>>(),
                ),
                const Divider(),
              ],
            ),

          // Recent Events
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
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 4) {
            // Open settings modal with logout
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Settings",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text("Log out",
                            style: TextStyle(color: Colors.red)),
                        onTap: () async {
                          Navigator.pop(context); // Close modal
                          await AuthService().logout();
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(
                                context, RouteNames.signIn);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
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
        iconFile = 'assets/icons/Logo.png';
    }

    return Row(
      children: [
        Image.asset(iconFile, height: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600), // bolder text
        ),
      ],
    );
  }
}
