import 'package:flutter/material.dart';

class LeadRepository {
  static List<Map<String, dynamic>> leads = [
    {
      'client': 'Universitas Bengkulu',
      'code': 'INIT26-004',
      'title': 'Pendampingan Siakad Tahap III',
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
      'date': '24 Feb 2026',
      'sales': 'Direct Sales',
      'status': 'IN PROGRESS',
      'color': Colors.blue,
      'inputType': 'Import Data',
    },
    {
      'client': 'Poltekkes Aceh',
      'code': 'INIT26-001',
      'title': 'Penyediaan License Zoom',
      'date': '19 Feb 2026',
      'sales': 'AM Telkom',
      'status': 'DEAL',
      'color': Colors.green,
      'inputType': 'Manual Input',
    },
  ];
}
