import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning!",
                          style: TextStyle(
                            fontSize: 24,
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
                      icon: const Icon(Icons.qr_code_scanner),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= BANNER SLIDER =================
                SizedBox(
                  height: 190,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    children: [
                      bannerItem("assets/Group 1796.png"),
                      bannerItem("assets/Group 1824.png"),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= INDICATOR =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentPage == index ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.red
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ================= PRESENSI =================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
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
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "Presensi",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              "08:16 WIB",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

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

                      Column(
                        children: [
                          const Icon(
                            Icons.login_rounded,
                            color: Colors.red,
                            size: 50,
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Check-In",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ================= MENU GRID =================
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.8,
                  children: const [
                    MenuItem(
                      image: "assets/Laporan.png",
                      title: "Laporan\nKehadiran",
                    ),
                    MenuItem(
                      image: "assets/Leads.png",
                      title: "Leads",
                    ),
                    MenuItem(
                      image: "assets/Proyek.png",
                      title: "Proyek",
                    ),
                    MenuItem(
                      image: "assets/Cuti.png",
                      title: "Cuti",
                    ),
                    MenuItem(
                      image: "assets/Knowledge.png",
                      title: "Knowledge",
                    ),
                    MenuItem(
                      image: "assets/Schedule.png",
                      title: "Schedule",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // ================= BOTTOM NAVIGATION =================
      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(
          color: Color(0xffC40011),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(
              icon: Icons.home,
              title: "Home",
              isActive: true,
            ),

            navItem(
              icon: Icons.dashboard_outlined,
              title: "Activities",
            ),

            navItem(
              icon: Icons.notifications,
              title: "Notification",
            ),

            navItem(
              icon: Icons.person,
              title: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  // ================= BANNER ITEM =================
  Widget bannerItem(String image) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ================= NAVIGATION ITEM =================
  Widget navItem({
    required IconData icon,
    required String title,
    bool isActive = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: isActive ? 60 : 50,
          height: isActive ? 60 : 50,
          decoration: BoxDecoration(
            color: isActive
                ? Colors.grey
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
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
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
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