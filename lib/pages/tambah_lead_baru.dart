import 'package:flutter/material.dart';
import 'tambah_lead_step2.dart';

class TambahLeadBaruScreen extends StatefulWidget {
  const TambahLeadBaruScreen({super.key});

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
  void dispose() {
    judulController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFB91C21),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void goToStep2() {
    if (judulController.text.trim().isEmpty) {
      showMessage('Judul Proyek / Lead wajib diisi');
      return;
    }

    if (kategoriValue == null || sumberValue == null || marketValue == null) {
      showMessage('Lengkapi semua data terlebih dahulu');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TambahLeadStep2Screen()),
    );
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFB91C21)),
        ),
      ),
      hint: const Text('Select an option', style: TextStyle(fontSize: 13)),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(fontSize: 13)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFB91C21);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        titleSpacing: 0,
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
              'Tambah Lead Baru',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Buat opportunity proyek baru',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.white70,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: judulController,
                    decoration: InputDecoration(
                      labelText: 'Judul Proyek / Lead',
                      labelStyle: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryRed),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildDropdown(
                    label: 'Kategori',
                    value: kategoriValue,
                    items: kategoriOptions,
                    onChanged: (val) {
                      setState(() {
                        kategoriValue = val;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  buildDropdown(
                    label: 'Sumber Opportunity',
                    value: sumberValue,
                    items: sumberOptions,
                    onChanged: (val) {
                      setState(() {
                        sumberValue = val;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  buildDropdown(
                    label: 'Market Category',
                    value: marketValue,
                    items: marketOptions,
                    onChanged: (val) {
                      setState(() {
                        marketValue = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: goToStep2,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Row(
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
