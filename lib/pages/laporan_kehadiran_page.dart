import 'package:flutter/material.dart';

class LaporanKehadiranPage extends StatefulWidget {
  const LaporanKehadiranPage({super.key});

  @override
  State<LaporanKehadiranPage> createState() => _LaporanKehadiranPageState();
}

class _LaporanKehadiranPageState extends State<LaporanKehadiranPage> {
  String selectedMonth = "April";

  final List<String> listBulan = [
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

  Map<String, dynamic> getDataForMonth(String monthName) {
    if (monthName == "April") {
      return {
        "hadirCount": 21,
        "absenCount": 2,
        "izinCount": 1,
        "totalHariKerja": 24,
        "attendanceData": [
          {
            "date": DateTime(2026, 4, 12),
            "masuk": "07:44",
            "keluar": "16:30",
            "status": "Hadir",
          },
          {
            "date": DateTime(2026, 4, 13),
            "masuk": "07:58",
            "keluar": "17:00",
            "status": "Hadir",
          },
          {
            "date": DateTime(2026, 4, 14),
            "masuk": "-",
            "keluar": "-",
            "status": "Izin",
          },
          {
            "date": DateTime(2026, 4, 15),
            "masuk": "09:58",
            "keluar": "17:00",
            "status": "Terlambat",
          },
          {
            "date": DateTime(2026, 4, 16),
            "masuk": "07:50",
            "keluar": "17:00",
            "status": "Hadir",
          },
        ],
      };
    } else if (monthName == "Januari" || monthName == "Februari" || monthName == "Maret") {
      int monthIndex = listBulan.indexOf(monthName) + 1;
      return {
        "hadirCount": 20,
        "absenCount": 2,
        "izinCount": 2,
        "totalHariKerja": 24,
        "attendanceData": [
          {
            "date": DateTime(2026, monthIndex, 10),
            "masuk": "07:45",
            "keluar": "16:30",
            "status": "Hadir",
          },
          {
            "date": DateTime(2026, monthIndex, 11),
            "masuk": "07:50",
            "keluar": "17:00",
            "status": "Hadir",
          },
          {
            "date": DateTime(2026, monthIndex, 12),
            "masuk": "-",
            "keluar": "-",
            "status": "Izin",
          },
          {
            "date": DateTime(2026, monthIndex, 13),
            "masuk": "09:15",
            "keluar": "17:00",
            "status": "Terlambat",
          },
          {
            "date": DateTime(2026, monthIndex, 14),
            "masuk": "-",
            "keluar": "-",
            "status": "Absen",
          },
        ],
      };
    } else {
      return {
        "hadirCount": 0,
        "absenCount": 0,
        "izinCount": 0,
        "totalHariKerja": 24,
        "attendanceData": <Map<String, dynamic>>[],
      };
    }
  }

  String formatTanggal(DateTime date) {
    List<String> hari = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jum’at",
      "Sabtu",
      "Minggu",
    ];

    List<String> bulan = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Jun",
      "Jul",
      "Ags",
      "Sep",
      "Okt",
      "Nov",
      "Des",
    ];

    return "${hari[date.weekday - 1]}, ${date.day} ${bulan[date.month - 1]}";
  }

  @override
  Widget build(BuildContext context) {
    final currentData = getDataForMonth(selectedMonth);

    final hadirCount = currentData["hadirCount"] as int;
    final absenCount = currentData["absenCount"] as int;
    final izinCount = currentData["izinCount"] as int;
    final totalHariKerja = currentData["totalHariKerja"] as int;
    final attendanceData = currentData["attendanceData"] as List<Map<String, dynamic>>;

    final persenKehadiran = totalHariKerja > 0
        ? (hadirCount / totalHariKerja) * 100
        : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            width: double.infinity,
            height: 115,
            decoration: const BoxDecoration(
              color: Color(0xffB90D1C),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // BACK BUTTON
                  Positioned(
                    left: 18,
                    top: 22,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                  // TITLE
                  const Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "Laporan Kehadiran",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  // PROFILE
                  Positioned(
                    right: 18,
                    top: 8,
                    child: Container(
                      height: 54,
                      width: 54,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "A",
                        style: TextStyle(
                          color: Color(0xffB90D1C),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================= BODY =================
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(38),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ================= BULAN =================
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: listBulan.map((month) {
                            final isLast = month == listBulan.last;
                            return Padding(
                              padding: EdgeInsets.only(right: isLast ? 0 : 8),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedMonth = month;
                                  });
                                },
                                child: bulanItem(
                                  month,
                                  selectedMonth == month,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ================= TOTAL =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          totalCard(
                            "$hadirCount",
                            "Hadir",
                          ),
                          totalCard(
                            "$absenCount",
                            "Absen",
                          ),
                          totalCard(
                            "$izinCount",
                            "Izin",
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ================= PERSENTASE =================
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kehadiran $selectedMonth 2026",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "$hadirCount dari $totalHariKerja hari kerja",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${persenKehadiran.toStringAsFixed(1)}%",
                                  style: const TextStyle(
                                    color: Color(0xffB90D1C),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: LinearProgressIndicator(
                                value: persenKehadiran / 100,
                                minHeight: 7,
                                backgroundColor: const Color(0xffEFEFEF),
                                valueColor: const AlwaysStoppedAnimation(
                                  Color(0xff8D0012),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ================= RIWAYAT =================
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "RIWAYAT",
                              style: TextStyle(
                                color: Color(0xffB90D1C),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (attendanceData.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 30),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 48,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Belum ada riwayat kehadiran",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              Column(
                                children: attendanceData.map((item) {
                                  Color statusColor;
                                  switch (item["status"]) {
                                    case "Hadir":
                                      statusColor = Colors.green;
                                      break;
                                    case "Izin":
                                      statusColor = Colors.orange;
                                      break;
                                    case "Terlambat":
                                      statusColor = Colors.red;
                                      break;
                                    default:
                                      statusColor = Colors.grey;
                                  }

                                  return riwayatItem(
                                    formatTanggal(item["date"]),
                                    item["masuk"] == "-"
                                        ? "-"
                                        : "Masuk: ${item["masuk"]} · Keluar: ${item["keluar"]}",
                                    item["status"],
                                    statusColor,
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= BULAN =================
  Widget bulanItem(
    String title,
    bool active,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: active ? const Color(0xffB90D1C) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: active ? Colors.white : Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  // ================= TOTAL CARD =================
  Widget totalCard(
    String total,
    String label,
  ) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            total,
            style: const TextStyle(
              color: Color(0xffB90D1C),
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ================= RIWAYAT =================
  Widget riwayatItem(
    String hari,
    String waktu,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hari,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      waktu,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}