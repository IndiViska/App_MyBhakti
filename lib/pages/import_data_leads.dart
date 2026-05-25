import 'package:flutter/material.dart';
import 'tambah_lead_baru.dart';

class ImportDataLeadsScreen extends StatefulWidget {
  ImportDataLeadsScreen({super.key});

  @override
  State<ImportDataLeadsScreen> createState() => _ImportDataLeadsScreenState();
}

class _ImportDataLeadsScreenState extends State<ImportDataLeadsScreen> {
  String? selectedFileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFB91C21),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Import Data Leads',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Upload file Excel',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Text(
                'A',
                style: TextStyle(
                  color: Color(0xFFB91C21),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload File Excel',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFD6D6D6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xFF888888),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Panduan Import Leads',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 9),
                  Text(
                    "Download template mulai dari baris ke-3. Kolom bertanda * wajib diisi. Lead nomor otomatis digenerate oleh sistem.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6F6F6F),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            GestureDetector(
              onTap: () =>
                  setState(() => selectedFileName = 'sample_template.xlsx'),
              child: Container(
                width: double.infinity,
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFD6D6D6), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.insert_drive_file_outlined,
                          color: Color(0xFF828282),
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          selectedFileName ?? 'No file choose',
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => setState(
                        () => selectedFileName = 'sample_template.xlsx',
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Choose File',
                        style: TextStyle(
                          color: Color(0xFFB91C21),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                icon: Icon(Icons.upload_file_outlined, size: 20),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB91C21),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahLeadBaruScreen(),
                    ),
                  );
                },
                label: Text(
                  'Upload & Proses Import',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
