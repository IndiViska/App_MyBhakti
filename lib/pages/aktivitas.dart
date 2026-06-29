import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/add_activity_page.dart';
import 'package:app_mybhakti/pages/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app_mybhakti/pages/notification.dart';
import 'package:app_mybhakti/pages/profile.dart';

class AktivitasPage extends StatefulWidget {
  final String username;

  const AktivitasPage({super.key, required this.username});

  @override
  State<AktivitasPage> createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage> {
  int selectedTab = 0;
  List<Map<String, dynamic>> items = [];

  @override
  Widget build(BuildContext context) {
    String currentCategory = selectedTab == 0 ? 'All' : (selectedTab == 1 ? 'Leads' : 'Project');
    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // Remove expired items
    items.removeWhere((i) {
      String deadline = i['deadline'] ?? '';
      if (deadline.isEmpty) return false;
      try {
        List<String> parts = deadline.split('/');
        DateTime dueDate = DateTime(int.parse(parts[2]), int.parse(parts[0]), int.parse(parts[1]));
        return dueDate.isBefore(today);
      } catch (_) {
        return false;
      }
    });

    List<Map<String, dynamic>> aktivitasItems = items.where((i) => i['type'] == 'Aktivitas' && (currentCategory == 'All' || i['category'] == currentCategory)).toList();
    List<Map<String, dynamic>> acaraItems = items.where((i) => i['type'] == 'Acara' && (currentCategory == 'All' || i['category'] == currentCategory)).toList();
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

              index: 1,

              items: [
                // HOME
                Transform.translate(
                  offset: const Offset(0, 10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
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
                Padding(
                  padding: EdgeInsets.only(top: 0),

                  child: Icon(Icons.dashboard, color: Colors.white, size: 28),
                ),

                // NOTIFICATION
                Transform.translate(
                  offset: const Offset(0, 10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.notifications, color: Colors.white, size: 25),

                      SizedBox(height: 3),

                      Text(
                        "Notification",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),

                // PROFILE
                Transform.translate(
                  offset: const Offset(0, 10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
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

            // LABEL ACTIVITIES DI LUAR BULATAN
            Positioned(
              bottom: 10,

              left: 175,

              child: const Text(
                "Activities",

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
        child: Column(
          children: [
            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Hello, Good Morning!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFF6B6B),
                        ),
                      ),

                      // PROFILE
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xffD9D9D9)),
                        ),
                        child: Center(
                          child: Text(
                            widget.username.isNotEmpty
                                ? widget.username[0].toUpperCase()
                                : "A",
                            style: const TextStyle(
                              color: Color(0xffC1121F),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ================= TAB =================
                  Row(
                    children: [
                      buildTab("All", 0),
                      buildTab("Leads", 1),
                      buildTab("Project", 2),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= AKTIVITAS =================
                    const Text(
                      "Aktivitas",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff5E0707),
                      ),
                    ),

                    const SizedBox(height: 14),

                    aktivitasItems.isEmpty
                        ? activityCard(
                            title: "Belum ada aktivitas!",
                            buttonText: "+ Tambahkan Aktivitas...",
                            imagePath: 'lib/assets/aktivitas.png',
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddActivityPage(
                                    isEventMode: false,
                                    username: widget.username,
                                  ),
                                ),
                              );
                              if (result != null && result is Map<String, dynamic>) {
                                setState(() {
                                  items.add(Map<String, dynamic>.from(result));
                                });
                              }
                            },
                          )
                        : Column(
                            children: [
                              ...aktivitasItems.map((item) => _buildItemCard(item)).toList(),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddActivityPage(
                                        isEventMode: false,
                                        username: widget.username,
                                      ),
                                    ),
                                  );
                                  if (result != null && result is Map<String, dynamic>) {
                                    setState(() {
                                      items.add(Map<String, dynamic>.from(result));
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffB1121B),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("+ Tambah Aktivitas"),
                              ),
                            ],
                          ),

                    const SizedBox(height: 40),

                    // ================= ACARA =================
                    const Text(
                      "Acara",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff5E0707),
                      ),
                    ),

                    const SizedBox(height: 14),

                    acaraItems.isEmpty
                        ? activityCard(
                            title: "Belum ada acara!",
                            buttonText: "+ Tambahkan Acara...",
                            imagePath: 'lib/assets/acara.png',
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddActivityPage(
                                    isEventMode: true,
                                    username: widget.username,
                                  ),
                                ),
                              );
                              if (result != null && result is Map<String, dynamic>) {
                                setState(() {
                                  items.add(Map<String, dynamic>.from(result));
                                });
                              }
                            },
                          )
                        : Column(
                            children: [
                              ...acaraItems.map((item) => _buildItemCard(item)).toList(),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddActivityPage(
                                        isEventMode: true,
                                        username: widget.username,
                                      ),
                                    ),
                                  );
                                  if (result != null && result is Map<String, dynamic>) {
                                    setState(() {
                                      items.add(Map<String, dynamic>.from(result));
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffB1121B),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("+ Tambah Acara"),
                              ),
                            ],
                          ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xffB1121B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item['category'],
                  style: const TextStyle(
                    color: Color(0xffB1121B),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                item['deadline'] ?? '-',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item['title'].toString().isEmpty ? '(No Title)' : item['title'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.business_center_outlined, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                item['project'] ?? '-',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= TAB =================
  Widget buildTab(String title, int index) {
    bool active = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: active
              ? const Border(
                  bottom: BorderSide(color: Color(0xffB1121B), width: 2),
                )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            color: active ? const Color(0xffB1121B) : const Color(0xff94A3B8),
          ),
        ),
      ),
    );
  }

  // ================= CARD =================
  Widget activityCard({
    required String title,
    required String buttonText,
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 55),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffFF8C8C)),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              // ================= TEXT DI ATAS IMAGE =================
              Stack(
                alignment: Alignment.center,
                children: [
                  // IMAGE BESAR
                  Image.asset(imagePath, height: 240, fit: BoxFit.contain),

                  // TEXT MENUMPUK DI ATAS IMAGE
                  Positioned(
                    top: 90,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff575757),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ================= BUTTON =================
        Positioned(
          bottom: -20,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xffF7B3B3)),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(color: Color(0xff94A3B8), fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
