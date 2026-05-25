import 'package:flutter/material.dart';

class TambahLeadStep2Screen extends StatefulWidget {
  const TambahLeadStep2Screen({super.key});

  @override
  State<TambahLeadStep2Screen> createState() => _TambahLeadStep2ScreenState();
}

class _TambahLeadStep2ScreenState extends State<TambahLeadStep2Screen> {
  String? selectedInstansi;
  String? selectedPIC;

  String selectedPemberiKerja = 'Sama dg Customer';

  final List<String> instansiOptions = [
    'Instansi A',
    'Instansi B',
    'Instansi C',
  ];

  final List<String> picOptions = ['PIC 1', 'PIC 2', 'PIC 3'];

  @override
  Widget build(BuildContext context) {
    final primaryRed = const Color(0xFFB91C21);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          backgroundColor: primaryRed,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tambah Lead Baru',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Buat opportunity proyek baru',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: LinearProgressIndicator(
                            value: 2 / 4,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Data Customer',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer / Lokasi Proyek',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10),
            ToggleButtons(
              constraints: const BoxConstraints(minWidth: 70, minHeight: 32),
              isSelected: [
                selectedPemberiKerja != 'Baru',
                selectedPemberiKerja == 'Baru',
              ],
              borderRadius: BorderRadius.circular(20),
              selectedColor: Colors.white,
              fillColor: primaryRed,
              color: primaryRed,
              borderColor: primaryRed,
              selectedBorderColor: primaryRed,
              onPressed: (index) {
                setState(() {
                  selectedPemberiKerja = (index == 0) ? 'Database' : 'Baru';
                });
              },
              children: const [Text('Database'), Text('Baru')],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Pilih Instansi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
              initialValue: selectedInstansi,
              items: instansiOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => selectedInstansi = val),
              hint: const Text('Select an option'),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Pilih PIC',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
              initialValue: selectedPIC,
              items: picOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => selectedPIC = val),
              hint: const Text('Select an option'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToggleButtons(
                    constraints: const BoxConstraints(
                      minWidth: 90,
                      minHeight: 36,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    isSelected: [
                      selectedPemberiKerja == 'Sama dg Customer',
                      selectedPemberiKerja == 'Database',
                      selectedPemberiKerja == 'Baru',
                    ],
                    selectedColor: Colors.white,
                    fillColor: primaryRed,
                    color: primaryRed,
                    borderColor: primaryRed,
                    selectedBorderColor: primaryRed,
                    onPressed: (index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            selectedPemberiKerja = 'Sama dg Customer';
                            break;
                          case 1:
                            selectedPemberiKerja = 'Database';
                            break;
                          case 2:
                            selectedPemberiKerja = 'Baru';
                            break;
                        }
                      });
                    },
                    children: const [
                      Text('Sama dg Customer'),
                      Text('Database'),
                      Text('Baru'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Pemberi kerja adalah Customer/Instansi di atas (Direct Client).',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // Aksi tombol Next
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Next',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded),
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
