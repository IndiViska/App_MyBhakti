import 'package:flutter/material.dart';

class LaporanKehadiranPage extends StatelessWidget {
  const LaporanKehadiranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Kehadiran"),
      ),

      body: const Center(
        child: Text(
          "Ini halaman Laporan Kehadiran",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}