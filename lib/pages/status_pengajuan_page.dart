import 'package:flutter/material.dart';

class StatusPengajuanPage extends StatelessWidget {
  const StatusPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 35,
              ),

              decoration: const BoxDecoration(
                color: Color(0xffB80D17),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),

              child: Row(
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
                        color:
                            Colors.white.withOpacity(0.2),

                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Text(
                    "Status Pengajuan",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const CircleAvatar(
                    backgroundColor: Colors.white,

                    child: Text(
                      "A",
                      style: TextStyle(
                        color: Color(0xffB80D17),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Container(
                      height: 110,
                      width: 110,

                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Pengajuan Terkirim!",

                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Pengajuan cuti kamu berhasil dikirim\n dan sedang menunggu persetujuan.",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(18),

                        border: Border.all(
                          color:
                              Colors.grey.shade300,
                        ),
                      ),

                      child: Column(
                        children: [
                          detailRow(
                            "Nama",
                            "Admin",
                          ),

                          detailRow(
                            "Jenis Cuti",
                            "Cuti Tahunan",
                          ),

                          detailRow(
                            "Tanggal",
                            "28 - 30 Apr 2025",
                          ),

                          detailRow(
                            "Durasi",
                            "3 hari kerja",
                          ),

                          detailRow(
                            "Sisa cuti",
                            "8-5 hari",
                          ),

                          detailRow(
                            "Status",
                            "Menunggu Approval",
                          ),

                          detailRow(
                            "Dikirim",
                            "27 Apr 2025, 09:41",
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xffB80D17),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),

                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text(
                          "Selesai",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
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

  Widget detailRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,

            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          Text(
            value,

            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}