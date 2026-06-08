import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/home.dart';

class AktivitasPage extends StatefulWidget {
  final String username;

  const AktivitasPage({super.key, required this.username});

  @override
  State<AktivitasPage> createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= NAVBAR =================
      bottomNavigationBar: CustomNavbar(username: widget.username),

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

                    activityCard(
                      title: "Belum ada aktivitas!",
                      buttonText: "+ Tambahkan Aktivitas...",
                      imagePath: 'lib/assets/aktivitas.png',
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

                    activityCard(
                      title: "Belum ada acara!",
                      buttonText: "+ Tambahkan Acara...",
                      imagePath: 'lib/assets/acara.png',
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
            onPressed: () {},
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

// ================= CUSTOM NAVBAR =================

class CustomNavbar extends StatefulWidget {
  final String username;

  const CustomNavbar({super.key, required this.username});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              decoration: const BoxDecoration(color: Color(0xffB1121B)),
            ),
          ),

          // ================= BULATAN ACTIVITIES =================
          Positioned(
            top: -5,
            left: MediaQuery.of(context).size.width * 0.32,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6),
                ),
                child: const Icon(
                  Icons.dashboard_customize_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),

          // ================= MENU =================
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // HOME
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: navItem(
                        context: context,
                        icon: Icons.home,
                        label: "Home",
                        page: HomeView(username: widget.username),
                        index: 0,
                      ),
                    ),
                  ),

                  // SPACE BULATAN
                  const SizedBox(width: 75),

                  // NOTIFICATION
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: navItem(
                        context: context,
                        icon: Icons.notifications,
                        label: "Notification",
                        page: const SizedBox(),
                        index: 2,
                      ),
                    ),
                  ),

                  // PROFILE
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: navItem(
                        context: context,
                        icon: Icons.person,
                        label: "Profile",
                        page: HomeView(username: widget.username),
                        index: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================= TEXT ACTIVITIES =================
          Positioned(
            left: MediaQuery.of(context).size.width * 0.34,
            bottom: 8,
            child: const Text(
              "Activities",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Widget page,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(icon, color: Colors.white, size: 32),

          const SizedBox(height: 3),

          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
