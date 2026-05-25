import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/presensi_page.dart';
import 'package:app_mybhakti/pages/laporan_kehadiran_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app_mybhakti/pages/pengajuan_cuti_page.dart';
import 'package:app_mybhakti/pages/proyek.dart';
import 'package:app_mybhakti/pages/opportunities_page.dart';

class HomeView extends StatefulWidget {
  final String username;

  const HomeView({super.key, required this.username});

  @override
  State<HomeView> createState() => _HomeViewState();
}

// Alias tambahan supaya kalau ada file lain memanggil HomePage(), tetap aman.
class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, this.username = 'admin'});

  @override
  Widget build(BuildContext context) {
    return HomeView(username: username);
  }
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  late final PageController _pageController;

  final List<String> banners = [
    "lib/assets/Group 1824.png",
    "lib/assets/Group 1796.png",
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.95);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToLeads() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OpportunitiesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: CustomNavbar(username: widget.username),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            // ================= HEADER =================
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
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
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Morning!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.username,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),

                const Spacer(),

                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.qr_code_scanner),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ================= BANNER =================
            SizedBox(
              height: 185,
              child: PageView.builder(
                controller: _pageController,
                itemCount: banners.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset(banners[index], fit: BoxFit.fill),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // ================= PRESENSI =================
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PresensiPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.orange.shade700,
                                size: 22,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                "Presensi",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          const Text(
                            "08:16 WIB",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Lihat info presensi",
                            style: TextStyle(
                              color: Colors.cyan.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 25, top: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.login_rounded,
                            color: Colors.red,
                            size: 46,
                          ),

                          SizedBox(height: 8),

                          Text(
                            "Check-In",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ================= MENU =================
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 0,
              crossAxisSpacing: 10,
              childAspectRatio: 0.95,
              children: [
                // LAPORAN
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LaporanKehadiranPage()),
                    );
                  },
                  child: const MenuItem(
                    image: "lib/assets/Laporan.png",
                    title: "Laporan\nKehadiran",
                  ),
                ),

                // LEADS
                GestureDetector(
                  onTap: goToLeads,
                  child: const MenuItem(
                    image: "lib/assets/Leads.png",
                    title: "Leads",
                  ),
                ),

                // PROYEK
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProjectPage(username: widget.username),
                      ),
                    );
                  },
                  child: const MenuItem(
                    image: "lib/assets/Proyek.png",
                    title: "Proyek",
                  ),
                ),

                // CUTI

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PengajuanCutiPage(),
                      ),
                    );
                  },

                  child: const MenuItem(
                    image: "lib/assets/Cuti.png",
                    title: "Cuti",
                  ),
                ),
                const MenuItem(image: "lib/assets/Cuti.png", title: "Cuti"),

                // KNOWLEDGE
                const MenuItem(
                  image: "lib/assets/Knowlage.png",
                  title: "Knowledge",
                ),

                // SCHEDULE
                const MenuItem(
                  image: "lib/assets/Schedule.png",
                  title: "Schedule",
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
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
  int selectedIndex = 0;

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

          // HOME BUTTON
          Positioned(
            top: -5,
            left: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomeView(username: widget.username),
                  ),
                );
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6),
                ),
                child: const Icon(Icons.home, color: Colors.white, size: 35),
              ),
            ),
          ),

          // MENU ITEMS
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 60),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: navItem(
                    context: context,
                    icon: Icons.dashboard_customize_outlined,
                    label: "Activities",
                    page: const PresensiPage(),
                    index: 1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: navItem(
                    context: context,
                    icon: Icons.notifications,
                    label: "Notification",
                    page: LaporanKehadiranPage(),
                    index: 2,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: navItem(
                    context: context,
                    icon: Icons.person,
                    label: "Profile",
                    page: HomeView(username: widget.username),
                    index: 3,
                  ),
                ),
              ],
            ),
          ),

          const Positioned(
            left: 42,
            bottom: 8,
            child: Text(
              "Home",
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
        mainAxisAlignment: MainAxisAlignment.center,
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

// ================= MENU ITEM =================

class MenuItem extends StatelessWidget {
  final String image;
  final String title;

  const MenuItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, width: 65, height: 65, fit: BoxFit.contain),

        const SizedBox(height: 10),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff2D4A76),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
