import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/ajukan_cuti_page.dart';

class PengajuanCutiPage extends StatefulWidget {
  const PengajuanCutiPage({super.key});

  @override
  State<PengajuanCutiPage> createState() =>
      _PengajuanCutiPageState();
}

class _PengajuanCutiPageState
    extends State<PengajuanCutiPage> {
  // ================= DATA DUMMY =================

  final List<Map<String, dynamic>> dataCuti = [
    {
      "title": "Cuti Tahunan",
      "date": "15 - 16 Feb 2025 • 5 hari",
      "status": "Disetujui",
      "color": Colors.green,
    },
    {
      "title": "Cuti Sakit",
      "date": "25 Apr 2026 • 1 hari",
      "status": "Menunggu",
      "color": Colors.orange,
    },
    {
      "title": "Cuti Tahunan",
      "date": "10 - 12 Mar 2026 • 6 hari",
      "status": "Ditolak",
      "color": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ================= HEADER =================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 30,
                ),

                decoration: const BoxDecoration(
                  color: Color(0xffB80D17),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),

                child: Column(
                  children: [
                    // ================= APPBAR =================

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: Container(
                            height: 42,
                            width: 42,

                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.2),

                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),

                        const Text(
                          "Pengajuan Cuti",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,

                          child: Text(
                            "A",
                            style: TextStyle(
                              color: Color(0xffB80D17),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ================= CARD =================

                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(22),

                      decoration: BoxDecoration(
                        color: const Color(0xffC50F1A),

                        borderRadius:
                            BorderRadius.circular(22),

                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.15),

                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Sisa Hak Cuti 2026",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.end,

                            children: [
                              const Text(
                                "8",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  height: 1,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(width: 8),

                              Padding(
                                padding:
                                    const EdgeInsets.only(
                                  bottom: 8,
                                ),

                                child: const Text(
                                  "Hari",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Row(
                            children: const [
                              Text(
                                "Digunakan: ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),

                              Text(
                                "4",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              SizedBox(width: 25),

                              Text(
                                "Total: ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),

                              Text(
                                "12",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ================= BODY =================

              Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    // ================= BUTTON =================

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xffB80D17),

                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),

                       onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AjukanCutiPage(),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            dataCuti.insert(0, result);
                          });
                        }
                      },
                        child: const Text(
                          "+ Ajukan Cuti Baru",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    // ================= TITLE =================

                    const Text(
                      "RIWAYAT PENGAJUAN",
                      style: TextStyle(
                        color: Color(0xffB80D17),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= LIST DATA =================

                    Column(
                      children: dataCuti.map((cuti) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 16,
                          ),

                          child: cutiCard(
                            title: cuti["title"],
                            date: cuti["date"],
                            status: cuti["status"],
                            statusColor:
                                cuti["color"],
                          ),
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
    );
  }

  // ================= CARD =================

  Widget cutiCard({
    required String title,
    required String date,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                date,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),

            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}