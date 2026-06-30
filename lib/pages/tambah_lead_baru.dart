import 'package:flutter/material.dart';
import 'tambah_lead_step2.dart';
import 'lead_data.dart';
import 'lead_repository.dart';

class TambahLeadBaruScreen extends StatefulWidget {
  final Map<String, dynamic>? lead;
  final int? index;

  const TambahLeadBaruScreen({super.key, this.lead, this.index});

  @override
  State<TambahLeadBaruScreen> createState() => _TambahLeadBaruScreenState();
}

class _TambahLeadBaruScreenState extends State<TambahLeadBaruScreen> {
  final TextEditingController judulController = TextEditingController();

  String? kategoriValue;
  String? sumberValue;
  String? marketValue;

  final List<String> kategoriOptions = [
    'Solusi Teknologi',
    'Konsultasi',
    'Perangkat dan Infrastruktur',
  ];

  final List<String> sumberOptions = [
    'AM Telkom',
    'Digital Marketing',
    'Direct Sales (Canvassing)',
    'Existing Customer (Repeat)',
    'Partner Referral / Recommendation',
  ];

  final List<String> marketOptions = ['Telkom Group', 'YPT Group', 'Eksternal'];

  @override
  void dispose() {
    judulController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.lead != null) {
      judulController.text = widget.lead!['title'] ?? '';

      final kategori = widget.lead!['kategori']?.toString().trim();

      final sumber = widget.lead!['sales']?.toString().trim();

      final market = widget.lead!['market']?.toString().trim();

      kategoriValue = kategoriOptions.firstWhere(
        (e) => e.trim() == kategori,
        orElse: () => '',
      );

      if (kategoriValue == '') kategoriValue = null;

      sumberValue = sumberOptions.firstWhere(
        (e) => e.trim() == sumber,
        orElse: () => '',
      );

      if (sumberValue == '') sumberValue = null;

      marketValue = marketOptions.firstWhere(
        (e) => e.trim() == market,
        orElse: () => '',
      );

      if (marketValue == '') marketValue = null;
    }
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

    LeadData lead = LeadData(
      judul: judulController.text,
      kategori: kategoriValue!,
      sumberOpportunity: sumberValue!,
      marketCategory: marketValue!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TambahLeadStep2Screen(leadData: lead)),
    );
  }

  void saveEdit() {
    if (judulController.text.trim().isEmpty) {
      showMessage('Judul Proyek / Lead wajib diisi');
      return;
    }

    if (kategoriValue == null || sumberValue == null || marketValue == null) {
      showMessage('Lengkapi semua data terlebih dahulu');
      return;
    }

    LeadRepository.leads[widget.index!] = {
      ...LeadRepository.leads[widget.index!],

      'title': judulController.text,
      'kategori': kategoriValue,
      'sales': sumberValue,
      'market': marketValue,
    };

    Navigator.pop(context);
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.lead == null ? 'Tambah Lead Baru' : 'Edit Lead',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2),
            Text(
              widget.lead == null
                  ? 'Buat opportunity proyek baru'
                  : 'Ubah data opportunity',
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
                      hintText: 'Misal: Pengadaan CCTV Gudang',
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
                onPressed: () {
                  if (widget.lead == null) {
                    goToStep2();
                  } else {
                    saveEdit();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.lead == null ? 'Next' : 'Simpan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      widget.lead == null ? Icons.arrow_forward : Icons.save,
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
}
