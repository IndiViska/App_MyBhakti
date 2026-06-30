import 'package:flutter/material.dart';

class LeadRepository {
  static List<Map<String, dynamic>> leads = [
    {
      'client': 'Universitas Bengkulu',
      'code': 'INIT26-004',
      'title': 'Pendampingan Siakad Tahap III',

      'kategori': 'Solusi Teknologi',
      'market': 'Telkom Group',

      'date': '06 Apr 2026',
      'sales': 'AM Telkom',
      'status': 'DEAL',

      'color': Colors.green,
      'inputType': 'Manual Input',
    },
    {
      'client': 'Diskominfo Jawa Barat',
      'code': 'INIT26-002',
      'title': 'Pengadaan CCTV Kominfo Banjarmasin',

      'kategori': 'Perangkat dan Infrastruktur',
      'market': 'Eksternal',

      'date': '24 Feb 2026',
      'sales': 'Direct Sales (Canvassing)',
      'status': 'IN PROGRESS',

      'color': Colors.blue,
      'inputType': 'Import Data',
    },
    {
      'client': 'Poltekkes Aceh',
      'code': 'INIT26-001',
      'title': 'Penyediaan License Zoom',

      'kategori': 'Konsultasi',
      'market': 'YPT Group',

      'date': '19 Feb 2026',
      'sales': 'AM Telkom',
      'status': 'DEAL',

      'color': Colors.green,
      'inputType': 'Manual Input',
    },
  ];
}
