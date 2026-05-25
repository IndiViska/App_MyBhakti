import 'package:flutter/material.dart';
import 'tambah_lead_step2.dart';

class TambahLeadBaruScreen extends StatefulWidget {
  TambahLeadBaruScreen({super.key});

  @override
  State<TambahLeadBaruScreen> createState() => _TambahLeadBaruScreenState();
}

class _TambahLeadBaruScreenState extends State<TambahLeadBaruScreen> {
  final TextEditingController judulController = TextEditingController();
  String? kategoriValue;
  String? sumberValue;
  String? marketValue;

  final List<String> kategoriOptions = [
    'Kategori A',
    'Kategori B',
    'Kategori C',
  ];
  final List<String> sumberOptions = ['Sumber 1', 'Sumber 2', 'Sumber 3'];
  final List<String> marketOptions = ['Market 1', 'Market 2', 'Market 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Color(0xFFB91C21),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tambah Lead Baru",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Buat opportunity proyek baru",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: judulController,
              decoration: InputDecoration(labelText: 'Judul Proyek / Lead'),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: kategoriValue,
              decoration: InputDecoration(labelText: 'Kategori'),
              items: kategoriOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => kategoriValue = val),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: sumberValue,
              decoration: InputDecoration(labelText: 'Sumber Opportunity'),
              items: sumberOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => sumberValue = val),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: marketValue,
              decoration: InputDecoration(labelText: 'Market Category'),
              items: marketOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => marketValue = val),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahLeadStep2Screen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB91C21),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
