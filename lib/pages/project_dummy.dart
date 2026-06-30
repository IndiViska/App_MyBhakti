import 'package:flutter/material.dart';

/// ================= DATA LIST PROJECT =================
/// Ini seperti "database dummy" kamu
final List<Map<String, dynamic>> dummyProjects = [
  {
    "title": "Pendampingan Siakad Tahap III",
    "client": "PT Telkom Indonesia - TREG I (Sumatera) - Universitas Bengkulu",
    "anggota": [
      "Ayu Setiawan",
      "Budi Santoso",
      "Citra Lestari",
      "Dimas Pratama",
      "Nisa Siregar",
      "Dimas Pratama",
      "Intan",
      "Alika",
      "Amanda",
    ],
    "lead": "Ayu Setiawan",
    "progress": 75,
    "startDate": "2026-04-01",
    "endDate": "2026-06-15",
    "totalProjectCost": "Rp 1.500.000.000",
    "totalBilled": "Rp 500.000.000",
    "remainingBudget": "Rp 1.000.000.000",
    "tax": "11.00 %",
    "status": "ON WORKING",
    "statusColor": Colors.blue,
    "isPinned": true,

    "todos": [
      {
        "title": "Preparation",
        "deadline": "2026-04-15",
        "isExpanded": true,

        "items": [
          {"task": "Scope dan tujuan", "completed": true},
          {"task": "Jadwal kegiatan dan PIC", "completed": true},
          {"task": "Materi pendampingan & modul Siakad", "completed": true},
        ],
      },

      {
        "title": "Analysis",
        "deadline": "2026-05-09",
        "isExpanded": true,

        "items": [
          {"task": "Review sistem SIAKAD yang berjalan", "completed": true},
          {"task": "Analisis gap & kebutuhan pengembangan", "completed": true},
          {"task": "Finalisasi dokumen requirement", "completed": true},
        ],
      },

      {
        "title": "Development",
        "deadline": "2026-06-15",
        "isExpanded": true,

        "items": [
          {"task": "Setup environment pengembangan", "completed": true},
          {"task": "Integrasi dengan sistem existing", "completed": false},
          {"task": "Internal testing", "completed": false},
        ],
      },

      {
        "title": "Implementation",
        "deadline": "2026-06-24",
        "isExpanded": true,

        "items": [
          {"task": "Deploy ke server staging", "completed": false},
          {"task": "UAT (User Acceptance Test)", "completed": false},
          {"task": "Deploy ke production", "completed": false},
        ],
      },
    ],

    "documents": [
      {
        "name": "Scope dan Tujuan",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPK",
        "icon": Icons.picture_as_pdf,
        "url":
            "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
      },

      {
        "name": "Jadwal Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "PIC Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "RFD Siakad Tahap III",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPPH",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "BA Klarifikasi Negosiasi",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "BANEGO",
        "icon": Icons.picture_as_pdf,
      },
    ],

    "billing": [
      {
        "name": "Termin 1",
        "duedate": "2026-05-06",
        "pendapatan": "Rp 250.000.000",
        "beban": "Rp 1",
        "status": "Billed",
      },

      {
        "name": "Termin 2",
        "duedate": "2026-05-31",
        "pendapatan": "Rp 250.000.000",
        "beban": "Rp 1",
        "status": "Billed",
      },
    ],
  },
  {
    "title": "Pengadaan CCTV Kominfo",
    "client": "Dinas Komunikasi dan Informatika (Diskominfo) Jabar",
    "anggota": [
      "Ayu Setiawan",
      "Budi Santoso",
      "Citra Lestari",
      "Dimas Pratama",
      "Nisa Siregar",
    ],
    "lead": "Nisa Siregar",
    "progress": 75,
    "startDate": "2026-03-01",
    "endDate": "2026-06-10",
    "totalProjectCost": "Rp 1.500.000.000",
    "totalBilled": "Rp 500.000.000",
    "remainingBudget": "Rp 1.000.000.000",
    "tax": "11.00 %",
    "status": "ON WORKING",
    "statusColor": Colors.blue,
    "isPinned": true,

    "todos": [
      {
        "title": "Preparation",
        "deadline": "2026-04-15",
        "isExpanded": true,

        "items": [
          {"task": "Scope dan tujuan", "completed": true},
          {"task": "Jadwal kegiatan dan PIC", "completed": true},
          {"task": "Materi pendampingan & modul Siakad", "completed": true},
        ],
      },

      {
        "title": "Analysis",
        "deadline": "2026-05-09",
        "isExpanded": true,

        "items": [
          {"task": "Review sistem SIAKAD yang berjalan", "completed": true},
          {"task": "Analisis gap & kebutuhan pengembangan", "completed": true},
          {"task": "Finalisasi dokumen requirement", "completed": true},
        ],
      },

      {
        "title": "Development",
        "deadline": "2026-06-15",
        "isExpanded": true,

        "items": [
          {"task": "Setup environment pengembangan", "completed": true},
          {"task": "Integrasi dengan sistem existing", "completed": false},
          {"task": "Internal testing", "completed": false},
        ],
      },

      {
        "title": "Implementation",
        "deadline": "2026-06-24",
        "isExpanded": true,

        "items": [
          {"task": "Deploy ke server staging", "completed": false},
          {"task": "UAT (User Acceptance Test)", "completed": false},
          {"task": "Deploy ke production", "completed": false},
        ],
      },
    ],

    "documents": [
      {
        "name": "Scope dan Tujuan",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPK",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "Jadwal Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "PIC Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "RFD Siakad Tahap III",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPPH",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "BA Klarifikasi Negosiasi",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "BANEGO",
        "icon": Icons.picture_as_pdf,
      },
    ],
  },
  {
    "title": "Penyediaan License Zoom",
    "client": "PT Telkom Indonesia - TREG I (Sumatera) - Poltekkes Aceh",
    "anggota": [
      "Ayu Setiawan",
      "Budi Santoso",
      "Citra Lestari",
      "Dimas Pratama",
      "Nisa Siregar",
    ],
    "lead": "Dimas Pratama",
    "progress": 45,
    "startDate": "2026-06-01",
    "endDate": "2026-07-20",
    "totalProjectCost": "Rp 1.800.000.000",
    "totalBilled": "Rp 900.000.000",
    "remainingBudget": "Rp 900.000.000",
    "status": "ON WORKING",
    "statusColor": Colors.blue,
    "isPinned": false,

    "todos": [
      {
        "title": "Preparation",
        "deadline": "2026-06-15",
        "isExpanded": true,

        "items": [
          {"task": "Scope dan tujuan", "completed": true},
          {"task": "Jadwal kegiatan dan PIC", "completed": true},
          {"task": "Materi pendampingan & modul Siakad", "completed": true},
        ],
      },

      {
        "title": "Analysis",
        "deadline": "2026-07-09",
        "isExpanded": true,

        "items": [
          {"task": "Review sistem SIAKAD yang berjalan", "completed": true},
          {"task": "Analisis gap & kebutuhan pengembangan", "completed": true},
          {"task": "Finalisasi dokumen requirement", "completed": false},
        ],
      },

      {
        "title": "Development",
        "deadline": "2026-07-29",
        "isExpanded": true,

        "items": [
          {"task": "Setup environment pengembangan", "completed": false},
          {"task": "Integrasi dengan sistem existing", "completed": false},
          {"task": "Internal testing", "completed": false},
        ],
      },

      {
        "title": "Implementation",
        "deadline": "2026-08-15",
        "isExpanded": true,

        "items": [
          {"task": "Deploy ke server staging", "completed": false},
          {"task": "UAT (User Acceptance Test)", "completed": false},
          {"task": "Deploy ke production", "completed": false},
        ],
      },
    ],

    "documents": [
      {
        "name": "Scope dan Tujuan",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPK",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "Jadwal Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "PIC Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "RFD Siakad Tahap III",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPPH",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "BA Klarifikasi Negosiasi",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "BANEGO",
        "icon": Icons.picture_as_pdf,
      },
    ],
  },
  {
    "title": "Pendampingan Siakad Tahap II",
    "client": "PT Telkom Indonesia - TREG I (Sumatera) - Universitas Bengkulu",
    "anggota": [
      "Ayu Setiawan",
      "Budi Santoso",
      "Citra Lestari",
      "Dimas Pratama",
      "Nisa Siregar",
    ],
    "lead": "Citra Lestari",
    "progress": 100,
    "startDate": "2026-01-01",
    "endDate": "2026-03-31",
    "totalProjectCost": "Rp 1.500.000.000",
    "totalBilled": "Rp 500.000.000",
    "remainingBudget": "Rp 1.000.000.000",
    "tax": "11.00 %",
    "status": "COMPLETED",
    "statusColor": Colors.green,
    "isPinned": false,

    "todos": [
      {
        "title": "Preparation",
        "deadline": "2026-04-15",
        "isExpanded": true,

        "items": [
          {"task": "Scope dan tujuan", "completed": true},
          {"task": "Jadwal kegiatan dan PIC", "completed": true},
          {"task": "Materi pendampingan & modul Siakad", "completed": true},
        ],
      },

      {
        "title": "Analysis",
        "deadline": "2026-05-09",
        "isExpanded": true,

        "items": [
          {"task": "Review sistem SIAKAD yang berjalan", "completed": true},
          {"task": "Analisis gap & kebutuhan pengembangan", "completed": true},
          {"task": "Finalisasi dokumen requirement", "completed": true},
        ],
      },

      {
        "title": "Development",
        "deadline": "2026-05-15",
        "isExpanded": true,

        "items": [
          {"task": "Setup environment pengembangan", "completed": true},
          {"task": "Integrasi dengan sistem existing", "completed": true},
          {"task": "Internal testing", "completed": true},
        ],
      },

      {
        "title": "Implementation",
        "deadline": "2026-05-15",
        "isExpanded": true,

        "items": [
          {"task": "Deploy ke server staging", "completed": true},
          {"task": "UAT (User Acceptance Test)", "completed": true},
          {"task": "Deploy ke production", "completed": true},
        ],
      },
    ],

    "documents": [
      {
        "name": "Scope dan Tujuan",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPK",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "Jadwal Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "PIC Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "RFD Siakad Tahap III",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPPH",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "BA Klarifikasi Negosiasi",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "BANEGO",
        "icon": Icons.picture_as_pdf,
      },
    ],
  },
  {
    "title": "Pengadaan CCTV Kominfo II",
    "client": "Dinas Komunikasi dan Informatika (Diskominfo) Jabar",
    "anggota": [
      "Ayu Setiawan",
      "Budi Santoso",
      "Citra Lestari",
      "Dimas Pratama",
      "Nisa Siregar",
    ],
    "lead": "Budi Santoso",
    "progress": 100,
    "startDate": "2026-02-01",
    "endDate": "2026-03-31",
    "totalProjectCost": "Rp 2.000.000.000",
    "totalBilled": "Rp 1.500.000.000",
    "remainingBudget": "Rp 500.000.000",
    "tax": "11.00 %",
    "status": "COMPLETED",
    "statusColor": Colors.green,
    "isPinned": true,

    "todos": [
      {
        "title": "Preparation",
        "deadline": "2026-04-15",
        "isExpanded": true,

        "items": [
          {"task": "Scope dan tujuan", "completed": true},
          {"task": "Jadwal kegiatan dan PIC", "completed": true},
          {"task": "Materi pendampingan & modul Siakad", "completed": true},
        ],
      },

      {
        "title": "Analysis",
        "deadline": "2026-05-09",
        "isExpanded": true,

        "items": [
          {"task": "Review sistem SIAKAD yang berjalan", "completed": true},
          {"task": "Analisis gap & kebutuhan pengembangan", "completed": true},
          {"task": "Finalisasi dokumen requirement", "completed": true},
        ],
      },

      {
        "title": "Development",
        "deadline": "2026-05-15",
        "isExpanded": true,

        "items": [
          {"task": "Setup environment pengembangan", "completed": true},
          {"task": "Integrasi dengan sistem existing", "completed": true},
          {"task": "Internal testing", "completed": true},
        ],
      },

      {
        "title": "Implementation",
        "deadline": "2026-05-15",
        "isExpanded": true,

        "items": [
          {"task": "Deploy ke server staging", "completed": true},
          {"task": "UAT (User Acceptance Test)", "completed": true},
          {"task": "Deploy ke production", "completed": true},
        ],
      },
    ],

    "documents": [
      {
        "name": "Scope dan Tujuan",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPK",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "Jadwal Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "PIC Kegiatan",
        "type": "XLSX",
        "size": "1.5 MB",
        "uploader": "TK",
        "icon": Icons.bar_chart,
      },

      {
        "name": "RFD Siakad Tahap III",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "SPPH",
        "icon": Icons.picture_as_pdf,
      },

      {
        "name": "BA Klarifikasi Negosiasi",
        "type": "PDF",
        "size": "2.5 MB",
        "uploader": "BANEGO",
        "icon": Icons.picture_as_pdf,
      },
    ],
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
