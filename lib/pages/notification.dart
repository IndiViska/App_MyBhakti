import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app_mybhakti/pages/home.dart';
import 'package:app_mybhakti/pages/aktivitas.dart';
import 'package:app_mybhakti/pages/profile.dart';

final List<Map<String, String>> notifications = [
  {
    "name": "Nur Hidayat",
    "message": "Nur Hidayat invited you to their project...",
    "date": "14 Mar",
  },
  {
    "name": "My Bhakti",
    "message": "Welcome to the App My Bhakti!",
    "date": "16 Mar",
  },
];

class NotificationPage extends StatefulWidget {
  final String username;

  const NotificationPage({super.key, required this.username});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              color: Colors.white,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Your notification here",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Center(
                      child: Text(
                        widget.username.isNotEmpty
                            ? widget.username[0].toUpperCase()
                            : "A",
                        style: const TextStyle(
                          color: Color(0xffC1121F),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: Colors.grey.shade300),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Image.asset(
                        "lib/assets/Group1856.png",
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "No notifications yet",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Your notification will appear here once you've received them.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CurvedNavigationBar(
              backgroundColor: Colors.white,
              color: const Color(0xffB1121B),
              height: 75,
              index: 2,

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

                // NOTIFICATION (ACTIVE)
                const Icon(Icons.notifications, color: Colors.white, size: 28),

                // PROFILE
                Transform.translate(
                  offset: const Offset(0, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.person, color: Colors.white, size: 25),
                      SizedBox(height: 3),
                      Text(
                        "Profile",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
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
                    break;

                  case 3:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Profile(username: widget.username),
                      ),
                    );

                    break;
                }
              },
            ),

            // LABEL NOTIFICATION DI LUAR BULATAN
            const Positioned(
              bottom: 10,
              left: 285, // sesuaikan sedikit jika belum pas
              child: Text(
                "Notification",
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
    );
  }
}
