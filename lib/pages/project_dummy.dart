import 'package:flutter/material.dart';

/// ================= DATA LIST PROJECT =================
/// Ini seperti "database dummy" kamu
final List<Map<String, dynamic>> dummyProjects = [
  {
    "title": "Pendampingan Siakad Tahap III",
    "client": "PT Telkom Indonesia - TREG I (Sumatera) - Universitas Bengkulu",
    "status": "ON WORKING",
    "statusColor": Colors.blue,
    "isPinned": true,
  },
  {
    "title": "Pengadaan CCTV Kominfo",
    "client": "Dinas Komunikasi dan Informatika (Diskominfo) Jabar",
    "status": "ON WORKING",
    "statusColor": Colors.blue,
    "isPinned": true,
  },
  {
    "title": "Penyediaan License Zoom",
    "client": "PT Telkom Indonesia - TREG I (Sumatera) - Poltekkes Aceh",
    "status": "ON WORKING",
    "statusColor": Colors.blue,
    "isPinned": false,
  },
  {
    "title": "Pendampingan Siakad Tahap II",
    "client": "PT Telkom Indonesia - TREG I (Sumatera) - Universitas Bengkulu",
    "status": "COMPLETED",
    "statusColor": Colors.green,
    "isPinned": false,
  },
  {
    "title": "Pengadaan CCTV Kominfo II",
    "client": "Dinas Komunikasi dan Informatika (Diskominfo) Jabar",
    "status": "COMPLETED",
    "statusColor": Colors.green,
    "isPinned": true,
  },
];

/// ================= ADD NEW PROJECT =================
/// Pakai ini dari Page 4 (submit)
void addDummyProject(Map<String, dynamic> project) {
  dummyProjects.add(project);
}

/// ================= OPTIONAL HELPER =================
/// Kalau mau reset semua data (misal testing)
void resetDummyProjects() {
  dummyProjects.clear();
}
