import 'package:flutter/material.dart';
import 'import_data_leads.dart';
import 'tambah_lead_baru.dart';
import 'lead_repository.dart';

class OpportunitiesScreen extends StatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

// Alias agar kalau di file lain memanggil OpportunitiesPage tetap aman.
class OpportunitiesPage extends StatelessWidget {
  const OpportunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OpportunitiesScreen();
  }
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  int selectedTopTab = 0;
  int selectedFilter = 0;

  String searchKeyword = '';

  final List<String> topTabs = ['Semua Leads', 'Leads Saya (Tim)'];

  final List<String> filters = ['Semua', 'Deal', 'In Progress', 'No Deal'];

  // ================= SEMUA LEADS =================
  List<Map<String, dynamic>> get allLeads => LeadRepository.leads;

  // ================= LEADS SAYA / TIM =================
  List<Map<String, dynamic>> get myLeads => LeadRepository.leads;

  List<Map<String, dynamic>> get activeLeads {
    if (selectedTopTab == 0) {
      return allLeads;
    } else {
      return myLeads;
    }
  }

  List<Map<String, dynamic>> get filteredLeads {
    List<Map<String, dynamic>> sourceData = activeLeads;

    // Filter Status
    if (selectedFilter != 0) {
      final filter = filters[selectedFilter].toUpperCase();

      sourceData = sourceData.where((item) {
        return item['status'] == filter;
      }).toList();
    }

    // Filter Search
    if (searchKeyword.isNotEmpty) {
      sourceData = sourceData.where((item) {
        return item['client'].toString().toLowerCase().contains(
              searchKeyword,
            ) ||
            item['title'].toString().toLowerCase().contains(searchKeyword);
      }).toList();
    }

    return sourceData;
  }

  void goToTambahLeadBaru() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ImportDataLeadsScreen()),
    );
  }

  void goToImportData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ImportDataLeadsScreen()),
    );
  }

  void deleteLead(Map<String, dynamic> lead) {
    setState(() {
      LeadRepository.leads.remove(lead);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Lead berhasil dihapus')));
  }

  Widget buildTopTab(String text, int index) {
    final bool active = selectedTopTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTopTab = index;
          selectedFilter = 0;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? const Color(0xffB90F1A) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? const Color(0xffB90F1A) : const Color(0xff9AA3B2),
          ),
        ),
      ),
    );
  }

  Widget buildFilterChip(String text, int index) {
    final bool active = selectedFilter == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xffB90F1A) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : const Color(0xff8F98A8),
          ),
        ),
      ),
    );
  }

  Widget buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color.withOpacity(0.45)),
      ),
      child: Text(
        '• $status',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }

  Widget buildInputBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: Color(0xFFD97706),
        ),
      ),
    );
  }

  Widget buildActionButton({
    required IconData icon,
    required Color color,
    required Color bg,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 27,
        height: 27,
        margin: const EdgeInsets.only(left: 7),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 15, color: color),
      ),
    );
  }

  Widget buildLeadCard(Map<String, dynamic> lead) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xffE6EAF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_balance_outlined,
                size: 12,
                color: Color(0xff8C96A8),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  lead['client'],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xff748094),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xffEDF3F8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  lead['code'],
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xff66748A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          Text(
            lead['title'],
            style: const TextStyle(
              fontSize: 12,
              height: 1.25,
              color: Color(0xff1F2937),
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 9),

          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 12,
                color: Color(0xff66748A),
              ),
              const SizedBox(width: 4),
              Text(
                lead['date'],
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xff66748A),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.account_balance_outlined,
                size: 12,
                color: Color(0xff66748A),
              ),
              const SizedBox(width: 4),
              Text(
                lead['sales'],
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xff66748A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          const Divider(height: 1, color: Color(0xffE6EAF0)),

          const SizedBox(height: 9),

          Row(
            children: [
              buildStatusBadge(lead['status'], lead['color']),

              const SizedBox(width: 8),

              buildInputBadge(lead['inputType'] ?? 'Manual Input'),

              const SizedBox(width: 8),

              const CircleAvatar(
                radius: 11,
                backgroundColor: Colors.lightBlueAccent,
                child: Icon(Icons.person, size: 13, color: Colors.white),
              ),

              const Spacer(),

              buildActionButton(
                icon: Icons.share_outlined,
                color: const Color(0xff00A7C8),
                bg: const Color(0xffEAFBFF),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Share WA: ${lead['title']}')),
                  );
                },
              ),

              buildActionButton(
                icon: Icons.edit_outlined,
                color: const Color(0xff6B7280),
                bg: const Color(0xffF1F5F9),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TambahLeadBaruScreen(),
                    ),
                  );
                },
              ),

              buildActionButton(
                icon: Icons.delete_outline,
                color: const Color(0xffEF4444),
                bg: const Color(0xffFEECEC),
                onTap: () {
                  deleteLead(lead);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined, size: 54, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            selectedTopTab == 0
                ? 'Belum ada data leads'
                : 'Belum ada data Leads Saya',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xff8F98A8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = filteredLeads;

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      floatingActionButton: FloatingActionButton(
        onPressed: goToTambahLeadBaru,
        backgroundColor: const Color(0xffB90F1A),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 13),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 22),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      const SizedBox(width: 4),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Leads / Opportunities',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff111827),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Kelola prospek dan peluang proyek',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff8C96A8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: goToImportData,
                        icon: const Icon(
                          Icons.upload_file_outlined,
                          color: Color(0xffB90F1A),
                        ),
                      ),

                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffE4A3A7)),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Color(0xffB90F1A),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      buildTopTab(topTabs[0], 0),

                      const SizedBox(width: 28),

                      buildTopTab(topTabs[1], 1),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(filters.length, (index) {
                          return buildFilterChip(filters[index], index);
                        }),
                      ),
                    ),

                    const SizedBox(height: 13),

                    TextField(
                      style: const TextStyle(fontSize: 12),

                      onChanged: (value) {
                        setState(() {
                          searchKeyword = value.toLowerCase();
                        });
                      },

                      decoration: InputDecoration(
                        hintText: selectedTopTab == 0
                            ? 'Cari lead...'
                            : 'Cari lead saya...',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xffA5ADBA),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                          color: Color(0xff9AA3B2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(
                            color: Color(0xffE7EAF0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(
                            color: Color(0xffB90F1A),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 13),

                    if (data.isEmpty)
                      buildEmptyState()
                    else
                      ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildLeadCard(data[index]);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
