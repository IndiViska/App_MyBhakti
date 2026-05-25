import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/presensi_page.dart';
import 'package:app_mybhakti/pages/laporan_kehadiran_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app_mybhakti/pages/pengajuan_cuti_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
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

    _pageController = PageController(
      viewportFraction: 0.95,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),

          children: [
            // ================= HEADER =================

            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                  ),

                  child: const Center(
                    child: Text(
                      "A",

                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Good Morning!",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Admin",

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),

                IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.qr_code_scanner),
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
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),

          child: Image.asset(
            banners[index],
            fit: BoxFit.fill,
          ),
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
      MaterialPageRoute(
        builder: (_) => const PresensiPage(),
      ),
    );
  },

  child: Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 18,
    ),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(20),

      border: Border.all(
        color: Colors.grey.shade300,
      ),
    ),

    child: Row(
      crossAxisAlignment:
          CrossAxisAlignment.center,

      children: [
        // LEFT
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color:
                        Colors.orange.shade700,
                    size: 22,
                  ),

                  const SizedBox(width: 6),

                  const Text(
                    "Presensi",

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Text(
                "08:16 WIB",

                style: TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Lihat info presensi",

                style: TextStyle(
                  color:
                      Colors.cyan.shade700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),

        // RIGHT
        Padding(
          padding: const EdgeInsets.only(
            right: 25,
            top: 4,
          ),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              const Icon(
                Icons.login_rounded,
                color: Colors.red,
                size: 46,
              ),

              const SizedBox(height: 8),

              const Text(
                "Check-In",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w500,
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

              physics:
                  const NeverScrollableScrollPhysics(),

              mainAxisSpacing: 0,
              crossAxisSpacing: 10,
              childAspectRatio: 0.95,

              children: [
                // LAPORAN
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LaporanKehadiranPage(),
                      ),
                    );
                  },

                  child: const MenuItem(
                    image: "lib/assets/Laporan.png",
                    title: "Laporan\nKehadiran",
                  ),
                ),

                // LEADS
                const MenuItem(
                  image: "lib/assets/Leads.png",
                  title: "Leads",
                ),

                // PROYEK
                const MenuItem(
                  image: "lib/assets/Proyek.png",
                  title: "Proyek",
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

                // KNOWLEDGE
                const MenuItem(
                  image:
                      "lib/assets/Knowlage.png",

                  title: "Knowledge",
                ),

                // SCHEDULE
                const MenuItem(
                  image:
                      "lib/assets/Schedule.png",

                  title: "Schedule",
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // ================= BOTTOM NAVBAR =================

      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,

        backgroundColor: Colors.white,

        color: const Color(0xffB1121B),

        buttonBackgroundColor:
            const Color(0xffB1121B),

        height: 65,

        animationDuration:
            const Duration(milliseconds: 300),

        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),

          Icon(
            Icons.dashboard_customize_outlined,
            color: Colors.white,
          ),

          Icon(
            Icons.notifications_outlined,
            color: Colors.white,
          ),

          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
        ],

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

// ================= MENU ITEM =================

class MenuItem extends StatelessWidget {
  final String image;
  final String title;

  const MenuItem({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 65,
          height: 65,
          fit: BoxFit.contain,
        ),

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
