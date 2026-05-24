// lib/pages/opportunities_page.dart
import 'package:flutter/material.dart';
import 'import_data_leads.dart'; // pastikan import ini sesuai struktur folder

class OpportunitiesScreen extends StatefulWidget {
  OpportunitiesScreen({super.key});

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  int selectedTopTab = 0;
  int selectedFilter = 0;

  final List<String> topTabs = ['Semua Leads', 'Leads Saya (Tim)'];
  final List<String> filters = ['Semua', 'Deal', 'In Progress', 'No Deal'];

  final List<Map<String, dynamic>> leads = [
    {
      'client': 'Universitas Bengkulu',
      'code': 'Init26-004',
      'title': 'Pendampingan Siakad Tahap III',
      'date': '06 Apr 2026',
      'sales': 'AM Telkom',
      'status': 'DEAL',
      'color': Colors.green,
    },
    {
      'client': 'Diskominfo Jabar',
      'code': 'Init26-002',
      'title': 'Pengadaan CCTV Kominfo Banjarmasin',
      'date': '24 Feb 2026',
      'sales': 'Direct Sales',
      'status': 'IN PROGRESS',
      'color': Colors.blue,
    },
    {
      'client': 'Politeknik Aceh',
      'code': 'Init26-001',
      'title': 'Penyediaan License Zoom',
      'date': '19 Feb 2026',
      'sales': 'AM Telkom',
      'status': 'DEAL',
      'color': Colors.green,
    },
  ];

  List<Map<String, dynamic>> get filteredLeads {
    if (selectedFilter == 0) return leads;
    final filter = filters[selectedFilter].toUpperCase();
    return leads.where((item) => item['status'] == filter).toList();
  }

  Widget buildTopTab(String text, int index) {
    bool active = selectedTopTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTopTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? Color(0xffB90F1A) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            color: active ? Color(0xffB90F1A) : Color(0xff9AA3B2),
          ),
        ),
      ),
    );
  }

  Widget buildFilterChip(String text, int index) {
    bool active = selectedFilter == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Color(0xffB90F1A) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : Color(0xff8F98A8),
          ),
        ),
      ),
    );
  }

  Widget buildStatusBadge(String status, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color.withOpacity(0.45)),
      ),
      child: Text(
        '• $status',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget buildActionButton({
    required IconData icon,
    required Color color,
    required Color bg,
  }) {
    return Container(
      width: 27,
      height: 27,
      margin: EdgeInsets.only(left: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 15, color: color),
    );
  }

  Widget buildLeadCard(Map<String, dynamic> lead) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Color(0xffE6EAF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_outlined,
                size: 12,
                color: Color(0xff8C96A8),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  lead['client'],
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xff748094),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Color(0xffEDF3F8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  lead['code'],
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xff66748A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          Text(
            lead['title'],
            style: TextStyle(
              fontSize: 12,
              height: 1.25,
              color: Color(0xff1F2937),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 9),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 12,
                color: Color(0xff66748A),
              ),
              SizedBox(width: 4),
              Text(
                lead['date'],
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff66748A),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Icon(
                Icons.account_balance_outlined,
                size: 12,
                color: Color(0xff66748A),
              ),
              SizedBox(width: 4),
              Text(
                lead['sales'],
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff66748A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 9),
          Divider(height: 1, color: Color(0xffE6EAF0)),
          SizedBox(height: 9),
          Row(
            children: [
              buildStatusBadge(lead['status'], lead['color']),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 11,
                backgroundColor: Colors.amber,
                child: Icon(Icons.person, size: 13, color: Colors.white),
              ),
              Spacer(),
              buildActionButton(
                icon: Icons.arrow_outward_rounded,
                color: Color(0xff00A7C8),
                bg: Color(0xffEAFBFF),
              ),
              buildActionButton(
                icon: Icons.edit_outlined,
                color: Color(0xff6B7280),
                bg: Color(0xffF1F5F9),
              ),
              buildActionButton(
                icon: Icons.delete_outline,
                color: Color(0xffEF4444),
                bg: Color(0xffFEECEC),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = filteredLeads;

    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman ImportDataLeadsScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImportDataLeadsScreen()),
          );
        },
        backgroundColor: Color(0xffB90F1A),
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(14, 8, 14, 13),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 22),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 4),
                      Expanded(
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
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffE4A3A7)),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Color(0xffB90F1A),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      buildTopTab(topTabs[0], 0),
                      SizedBox(width: 28),
                      buildTopTab(topTabs[1], 1),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(14, 10, 14, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          filters.length,
                          (index) => buildFilterChip(filters[index], index),
                        ),
                      ),
                    ),
                    SizedBox(height: 13),
                    TextField(
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        hintText: 'Cari lead...',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xffA5ADBA),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Color(0xff9AA3B2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(color: Color(0xffE7EAF0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(color: Color(0xffB90F1A)),
                        ),
                      ),
                    ),
                    SizedBox(height: 13),
                    ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
