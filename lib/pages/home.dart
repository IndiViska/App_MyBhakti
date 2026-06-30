import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app_mybhakti/pages/presensi_page.dart';
import 'package:app_mybhakti/pages/presensi_data.dart';
import 'package:app_mybhakti/pages/laporan_kehadiran_page.dart';
import 'package:app_mybhakti/pages/pengajuan_cuti_page.dart';
import 'package:app_mybhakti/pages/proyek.dart';
import 'package:app_mybhakti/pages/opportunities_page.dart';
import 'package:app_mybhakti/pages/aktivitas.dart';
import 'package:app_mybhakti/pages/schedule_page.dart';
import 'package:app_mybhakti/pages/knowledge_page.dart';
import 'package:app_mybhakti/pages/notification.dart';
import 'package:app_mybhakti/pages/profile.dart';

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

  // ================= JAM REALTIME =================
  DateTime now = DateTime.now();
  Timer? timer;

  final List<String> banners = [
    "lib/assets/Group 1824.png",
    "lib/assets/Group 1796.png",
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.95);

    // ================= UPDATE JAM =================
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ================= FORMAT JAM =================

  String formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');

    String minute = time.minute.toString().padLeft(2, '0');

    return "$hour:$minute WIB";
  }

  // ================= FORMAT TANGGAL =================

  String formatDate(DateTime date) {
    List<String> hari = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Minggu",
    ];

    List<String> bulan = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    String namaHari = hari[date.weekday - 1];

    String namaBulan = bulan[date.month - 1];

    return "$namaHari, ${date.day} $namaBulan ${date.year}";
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

      bottomNavigationBar: SizedBox(
        height: 70,

        child: Stack(
          clipBehavior: Clip.none,

          children: [
            CurvedNavigationBar(
              backgroundColor: Colors.white,

              color: const Color(0xffB1121B),

              height: 75,

              index: 0,

              items: [
                // HOME
                Padding(
                  padding: EdgeInsets.only(top: 0),

                  child: Icon(Icons.home, color: Colors.white, size: 28),
                ),

                // ACTIVITIES
                Transform.translate(
                  offset: const Offset(0, 10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
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

            // LABEL HOME DI LUAR BULATAN
            Positioned(
              bottom: 10,

              left: 47,

              child: const Text(
                "Home",

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
                    padding: const EdgeInsets.symmetric(horizontal: 6),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),

                      child: Image.asset(
                        banners[index],
                        fit: BoxFit.cover, // jangan fill
                        filterQuality: FilterQuality.high, // biar lebih halus
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // ================= PRESENSI =================
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PresensiPage()),
                );
                setState(() {});
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

                          // ================= JAM REALTIME =================
                          Text(
                            formatTime(now),

                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // ================= TANGGAL REALTIME =================
                          Text(
                            formatDate(now),

                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
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

                        children: [
                          Icon(
                            PresensiData.hasCheckedIn
                                ? Icons.logout_rounded
                                : Icons.login_rounded,

                            color: PresensiData.hasCheckedIn
                                ? const Color(0xff2D4A76)
                                : Colors.red,

                            size: 46,
                          ),

                          const SizedBox(height: 8),

                          Text(
                            PresensiData.hasCheckedIn
                                ? "Check-Out"
                                : "Check-In",

                            style: const TextStyle(
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
                      MaterialPageRoute(builder: (_) => PengajuanCutiPage()),
                    );
                  },

                  child: const MenuItem(
                    image: "lib/assets/Cuti.png",
                    title: "Cuti",
                  ),
                ),

                // KNOWLEDGE
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const KnowledgePage()),
                    );
                  },

                  child: const MenuItem(
                    image: "lib/assets/Knowlage.png",
                    title: "Knowledge",
                  ),
                ),

                // SCHEDULE
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SchedulePage(username: widget.username)),
                    );
                  },

                  child: const MenuItem(
                    image: "lib/assets/Schedule.png",
                    title: "Schedule",
                  ),
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
