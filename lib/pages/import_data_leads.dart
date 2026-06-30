import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as ex;
import 'lead_repository.dart';
import 'opportunities_page.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class ImportDataLeadsScreen extends StatefulWidget {
  const ImportDataLeadsScreen({super.key});

  @override
  State<ImportDataLeadsScreen> createState() => _ImportDataLeadsScreenState();
}

class _ImportDataLeadsScreenState extends State<ImportDataLeadsScreen> {
  String? selectedFileName;
  Uint8List? selectedBytes;

  Future<void> chooseFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      if (!mounted) return;

      setState(() {
        selectedFileName = result.files.first.name;
        selectedBytes = result.files.first.bytes;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memilih file: $e')));
    }
  }

  Future<void> downloadTemplate() async {
    try {
      var excel = ex.Excel.createExcel();
      var sheet = excel['Sheet1'];

      // Header kolom sesuai urutan index yang digunakan di processImport
      List<String> headers = [
        'Kode Lead', // col 0
        'Judul', // col 1
        'Kategori', // col 2
        'Status', // col 3  (DEAL / NO DEAL / IN PROGRESS)
        'Sales', // col 4
        'Market', // col 5
        'Client', // col 6
        'PIC', // col 7
        'No HP', // col 8
        'Kolom 9', // col 9
        'Kolom 10', // col 10
        'Kolom 11', // col 11
        'Kolom 12', // col 12
        'Tanggal', // col 13
        'Kolom 14', // col 14
        'Kolom 15', // col 15
        'Kolom 16', // col 16
        'Marketing PIC', // col 17
        'Technical PIC', // col 18
      ];

      // Baris pertama = judul template (baris index 0)
      // excel 2.1.0 menerima List<dynamic> terus
      sheet.appendRow(['TEMPLATE IMPORT DATA LEADS - MyBhakti']);

      // Baris kedua = header kolom (baris index 1)
      sheet.appendRow(headers);

      // Baris contoh (baris index 2 — sesuai loop processImport mulai dari i=2)
      sheet.appendRow([
        'INIT26-001',
        'Pengadaan Server',
        'Solusi Teknologi',
        'IN PROGRESS',
        'AM Telkom',
        'Telkom Group',
        'PT Contoh',
        'Andi',
        '08123456789',
        '',
        '',
        '',
        '',
        '01/01/2026',
        '',
        '',
        '',
        'Dewi',
        'Rudi',
      ]);

      final List<int>? fileBytes = excel.save();
      if (fileBytes == null) throw Exception('Gagal membuat file');

      final blob = html.Blob([fileBytes]);

      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "template_import_leads.xlsx")
        ..click();

      html.Url.revokeObjectUrl(url);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Template berhasil diunduh")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal download template: $e')));
    }
  }

  void processImport() async {
    // Cek apakah user sudah memilih file
    if (selectedBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih file terlebih dahulu")),
      );
      return;
    }

    // Baca file Excel
    var excel = ex.Excel.decodeBytes(selectedBytes!);

    // Untuk mengecek nama sheet
    print(excel.tables.keys);

    // Ambil sheet
    var sheet = excel.tables['Data Leads'];

    // Cek apakah sheet ditemukan
    if (sheet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sheet Data Leads tidak ditemukan")),
      );
      return;
    }

    // Baru mulai membaca data
    print("Jumlah baris excel: ${sheet.rows.length}");
    for (int i = 2; i < sheet.rows.length; i++) {
      var row = sheet.rows[i];
      print(row.map((e) => e?.value).toList());

      if (row.length < 19) continue;
      if (row[1]?.value == null) continue;

      String status = row[3]?.value?.toString().toUpperCase() ?? "IN PROGRESS";

      Color statusColor = Colors.blue;

      if (status == "DEAL") {
        statusColor = Colors.green;
      } else if (status == "NO DEAL") {
        statusColor = Colors.red;
      }

      LeadRepository.leads.add({
        'client': row[6]?.value?.toString() ?? '',
        'code':
            row[0]?.value?.toString() ??
            'INIT26-${LeadRepository.leads.length + 1}',
        'title': row[1]?.value?.toString() ?? '',
        'kategori': row[2]?.value?.toString() ?? '',
        'status': status,
        'sales': row[4]?.value?.toString() ?? '',
        'market': row[5]?.value?.toString() ?? '',
        'date': row[13]?.value?.toString() ?? '',
        'color': statusColor,
        'inputType': 'Import Data',
      });
    }

    // PINDAHKAN KE LUAR FOR
    print("Jumlah Lead: ${LeadRepository.leads.length}");
    print(LeadRepository.leads.last);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OpportunitiesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFB91C21);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryRed,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Column(
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
              'Import data proyek sebelum membuat lead',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Text(
                'A',
                style: TextStyle(
                  color: primaryRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload File',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFD6D6D6)),
              ),
              child: const Column(
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
                    '''
                    1. Pilih file data proyek.
                    2. Pastikan format sesuai template.
                    3. Klik Upload & Proses Import.
                    4. Lengkapi data lead pada langkah berikutnya.
                   ''',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6F6F6F),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Template Import',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton.icon(
                onPressed: downloadTemplate,
                icon: const Icon(Icons.download),
                label: const Text('Download Template'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFB91C21),
                  side: const BorderSide(color: Color(0xFFB91C21)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: chooseFile,
              child: Container(
                width: double.infinity,
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD6D6D6), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.insert_drive_file_outlined,
                            color: Color(0xFF828282),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              selectedFileName ?? 'Belum ada file dipilih',
                              style: const TextStyle(
                                color: Color(0xFF828282),
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: chooseFile,
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'Choose File',
                        style: TextStyle(
                          color: primaryRed,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Format didukung: .xlsx, .xls',
              style: TextStyle(fontSize: 12, color: Color(0xFF828282)),
            ),
            if (selectedFileName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'File terpilih: $selectedFileName',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.upload_file_outlined, size: 20),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: processImport,
                label: const Text(
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
