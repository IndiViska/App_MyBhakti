import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:app_mybhakti/pages/project_dummy.dart';

class ProjectPage extends StatefulWidget {
  final String username;

  const ProjectPage({super.key, required this.username});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  int selectedTab = 0;

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // ================= FILTER DATA =================

    List<Map<String, dynamic>> pinnedProjects = [];
    List<Map<String, dynamic>> recentProjects = [];

    // FILTER STATUS
    List<Map<String, dynamic>> tempProjects = [];

    if (selectedTab == 0) {
      tempProjects = dummyProjects;
    } else if (selectedTab == 1) {
      tempProjects = dummyProjects
          .where((e) => e["status"] == "COMPLETED")
          .toList();
    } else {
      tempProjects = dummyProjects
          .where((e) => e["status"] == "ON WORKING")
          .toList();
    }

    // ================= SEARCH FILTER =================

    if (searchQuery.isNotEmpty) {
      tempProjects = tempProjects.where((project) {
        final title = project["title"].toString().toLowerCase();

        final client = project["client"].toString().toLowerCase();

        return title.contains(searchQuery.toLowerCase()) ||
            client.contains(searchQuery.toLowerCase());
      }).toList();
    }

    // ================= PINNED & RECENT =================

    pinnedProjects = tempProjects.where((e) => e["isPinned"] == true).toList();

    recentProjects = tempProjects.where((e) => e["isPinned"] == false).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffC1121F),

        onPressed: () {},

        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),

              color: Colors.white,

              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: const Icon(Icons.arrow_back),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Projects",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 2),

                        Text(
                          "Daftar data proyek",

                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 34,
                    height: 34,

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
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ================= SEARCH =================
            Padding(
              padding: const EdgeInsets.all(16),

              child: Container(
                height: 46,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },

                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: "Cari proyek..",

                    hintStyle: TextStyle(color: Colors.grey.shade400),

                    prefixIcon: const Icon(Icons.search),

                    contentPadding: const EdgeInsets.only(top: 12),
                  ),
                ),
              ),
            ),

            // ================= TAB =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),

              child: Row(
                children: [
                  buildTab("View All", 0),

                  const SizedBox(width: 24),

                  buildTab("Completed", 1),

                  const SizedBox(width: 24),

                  buildTab("On Working", 2),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ================= LIST =================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                children: [
                  // ================= PINNED =================
                  if (pinnedProjects.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),

                      child: Text(
                        "PINNED PROJECT",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    ...pinnedProjects.map(
                      (project) => buildProjectCard(project),
                    ),
                  ],

                  // ================= RECENT =================
                  if (recentProjects.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 12),

                      child: Text(
                        "RECENTLY VISITED",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    ...recentProjects.map(
                      (project) => buildProjectCard(project),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TAB =================

  Widget buildTab(String text, int index) {
    final isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            text,

            style: TextStyle(
              fontSize: 13,

              color: isSelected ? const Color(0xffC1121F) : Colors.grey,

              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),

          const SizedBox(height: 6),

          AnimatedContainer(
            duration: const Duration(milliseconds: 250),

            width: isSelected ? 55 : 0,
            height: 2,

            color: const Color(0xffC1121F),
          ),
        ],
      ),
    );
  }

  // ================= PROJECT CARD =================

  Widget buildProjectCard(Map<String, dynamic> project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),

            blurRadius: 8,

            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ================= TITLE =================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Text(
                  project["title"],

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    project["isPinned"] = !(project["isPinned"] ?? false);
                  });
                },

                child: Icon(
                  project["isPinned"] == true
                      ? Icons.push_pin
                      : Icons.push_pin_outlined,

                  size: 18,

                  color: project["isPinned"] == true ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // ================= CLIENT =================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Text(
                  project["client"],

                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),

              const SizedBox(width: 10),

              Container(
                width: 32,
                height: 32,

                decoration: BoxDecoration(
                  color: const Color(0xffC1121F),

                  borderRadius: BorderRadius.circular(8),
                ),

                child: const Icon(Icons.folder, color: Colors.white, size: 18),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ================= MEMBER =================
          Row(
            children: List.generate(
              5,
              (i) => Container(
                margin: const EdgeInsets.only(right: 4),

                width: 20,
                height: 20,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: Colors.primaries[i % Colors.primaries.length],
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ================= BOTTOM =================
          Row(
            children: [
              // STATUS
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: project["status"] == "ON WORKING"
                      ? const Color(0xffEFF6FF)
                      : const Color(0xffF0FDF4),

                  border: Border.all(
                    color: project["status"] == "ON WORKING"
                        ? const Color(0xffBFDBFE)
                        : const Color(0xffAAFDD1),
                  ),

                  borderRadius: BorderRadius.circular(10),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Container(
                      width: 10,
                      height: 10,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: project["status"] == "ON WORKING"
                            ? const Color(0xff2563EB)
                            : const Color(0xff16A34A),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      project["status"],

                      style: TextStyle(
                        color: project["status"] == "ON WORKING"
                            ? const Color(0xff2563EB)
                            : const Color(0xff16A34A),

                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ================= SHARE =================
              GestureDetector(
                onTap: () {
                  Share.share("""

Project : ${project["title"]}
Client  : ${project["client"]}
Status  : ${project["status"]}
""");
                },

                child: actionButton(Icons.share_outlined),
              ),

              const SizedBox(width: 8),

              // ================= EDIT =================
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Edit project clicked")),
                  );

                  // NANTI BISA NAVIGATE KE PAGE EDIT
                  // Navigator.push(...)
                },

                child: actionButton(Icons.edit_outlined),
              ),

              const SizedBox(width: 8),

              // ================= DELETE =================
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,

                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Hapus Project"),

                        content: Text(
                          'Yakin ingin menghapus "${project["title"]}"?',
                        ),

                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            child: const Text("Batal"),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),

                            onPressed: () {
                              setState(() {
                                dummyProjects.remove(project);
                              });

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Project berhasil dihapus"),
                                ),
                              );
                            },

                            child: const Text(
                              "Hapus",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },

                child: actionButton(
                  Icons.delete_outline,
                  iconColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= ACTION BUTTON =================

  Widget actionButton(IconData icon, {Color iconColor = Colors.grey}) {
    return Container(
      width: 32,
      height: 32,

      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),

        borderRadius: BorderRadius.circular(8),
      ),

      child: Icon(icon, size: 18, color: iconColor),
    );
  }
}
