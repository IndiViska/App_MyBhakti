import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/schedule_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app_mybhakti/pages/home.dart';
import 'package:app_mybhakti/pages/aktivitas.dart';
import 'package:app_mybhakti/pages/notification.dart';
import 'package:app_mybhakti/pages/my_profile_page.dart';
import 'package:app_mybhakti/pages/login.dart';

class Profile extends StatefulWidget {
  final String username;

  const Profile({super.key, required this.username});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget _buildProfileAvatar() {
    return Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        color: Color(0xffEAF5FF),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person_outline,
        color: Color(0xff4DA3FF),
        size: 42,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CurvedNavigationBar(
              backgroundColor: Colors.white,
              color: const Color(0xffB1121B),
              height: 75,
              index: 3,
              items: [
                // HOME
                Transform.translate(
                  offset: const Offset(0, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.home, color: Colors.white, size: 25),
                      SizedBox(height: 3),
                      Text(
                        "Home",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                // ACTIVITIES
                Transform.translate(
                  offset: const Offset(0, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.dashboard, color: Colors.white, size: 25),
                      SizedBox(height: 3),
                      Text(
                        "Activities",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                // NOTIFICATION
                Transform.translate(
                  offset: const Offset(0, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.notifications, color: Colors.white, size: 25),
                      SizedBox(height: 3),
                      Text(
                        "Notification",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                // PROFILE ACTIVE
                const Icon(Icons.person, color: Colors.white, size: 30),
              ],
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeView(username: widget.username),
                      ),
                    );
                    break;
                  case 1:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AktivitasPage(username: widget.username),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            NotificationPage(username: widget.username),
                      ),
                    );
                    break;
                  case 3:
                    break;
                }
              },
            ),
            const Positioned(
              bottom: 10,
              right: 45,
              child: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PROFILE HEADER
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileAvatar(),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "[EMAIL_ADDRESS]",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffB1121B),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MyProfilePage(
                                      isEditMode: true,
                                      username: widget.username,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 10),
                // MENU
                _menuTile(Icons.person_outline, "My Profile", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyProfilePage(
                        isEditMode: false,
                        username: widget.username,
                      ),
                    ),
                  );
                }),
                _menuTile(Icons.calendar_today_outlined, "My Calendar", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SchedulePage(username: widget.username),
                    ),
                  );
                }),
                _menuTile(
                  Icons.notifications_none_outlined,
                  "Notifications",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            NotificationPage(username: widget.username),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 10),
                _menuTile(Icons.logout, "Log Out", () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuTile(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xffB1121B), size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
