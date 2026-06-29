import 'package:flutter/material.dart';
import 'tambah_lead_step3.dart';
import 'lead_data.dart';

class TambahLeadStep2Screen extends StatefulWidget {
  final LeadData leadData;

  const TambahLeadStep2Screen({super.key, required this.leadData});

  @override
  State<TambahLeadStep2Screen> createState() => _TambahLeadStep2ScreenState();
}

class _TambahLeadStep2ScreenState extends State<TambahLeadStep2Screen> {
  final Color primaryRed = const Color(0xFFB91C21);
  final Color bgColor = const Color(0xFFF7F8FA);
  final Color borderColor = const Color(0xFFE5E7EB);

  String selectedCustomerType = 'Database';
  String? selectedInstansi;
  String? selectedCustomerPIC;

  String selectedEmployerType = 'Sama dg Customer';
  String? selectedEmployer;
  String? selectedEmployerPIC;

  final TextEditingController customerBaruController = TextEditingController();
  final TextEditingController customerPicBaruController =
      TextEditingController();
  final TextEditingController employerBaruController = TextEditingController();
  final TextEditingController employerPicBaruController =
      TextEditingController();

  final List<String> instansiOptions = [
    'Universitas Bengkulu',
    'Diskominfo Jawa Barat',
    'PT Bio Farma',
    'Politeknik Aceh',
  ];

  final List<String> picOptions = [
    'Budi Santoso',
    'Andi Pratama',
    'Rina Wijaya',
    'Dewi Lestari',
  ];

  @override
  void dispose() {
    customerBaruController.dispose();
    customerPicBaruController.dispose();
    employerBaruController.dispose();
    employerPicBaruController.dispose();
    super.dispose();
  }

  Widget buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 36),
      decoration: const BoxDecoration(
        color: Color(0xFFB91C21),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tambah Lead Baru',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Buat opportunity proyek baru',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: primaryRed,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Langkah 2 dari 4',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 2 / 4,
                minHeight: 5,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: AlwaysStoppedAnimation<Color>(primaryRed),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Data Customer',
            style: TextStyle(
              fontSize: 11,
              color: primaryRed,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }

  Widget buildSegmentButton({
    required List<String> items,
    required String selectedValue,
    required Function(String value) onChanged,
  }) {
    return Container(
      height: 34,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: items.map((item) {
          final bool active = selectedValue == item;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(item),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: active
                        ? const Color(0xFF111827)
                        : const Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF111827),
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(label),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 22,
            color: Color(0xFF9CA3AF),
          ),
          decoration: InputDecoration(
            hintText: 'Select an option',
            hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: primaryRed),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 12)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(label),
        TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: primaryRed),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCustomerSection() {
    return buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer / Lokasi Proyek',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          buildSegmentButton(
            items: const ['Database', 'Baru'],
            selectedValue: selectedCustomerType,
            onChanged: (value) {
              setState(() {
                selectedCustomerType = value;
                selectedInstansi = null;
                selectedCustomerPIC = null;
              });
            },
          ),
          const SizedBox(height: 14),

          if (selectedCustomerType == 'Database') ...[
            buildDropdown(
              label: 'Pilih Instansi',
              value: selectedInstansi,
              items: instansiOptions,
              onChanged: (value) {
                setState(() {
                  selectedInstansi = value;
                });
              },
            ),
            const SizedBox(height: 13),
            buildDropdown(
              label: 'Pilih PIC',
              value: selectedCustomerPIC,
              items: picOptions,
              onChanged: (value) {
                setState(() {
                  selectedCustomerPIC = value;
                });
              },
            ),
          ] else ...[
            buildTextField(
              label: 'Nama Instansi Baru',
              hint: 'Masukkan nama instansi',
              controller: customerBaruController,
            ),
            const SizedBox(height: 13),
            buildTextField(
              label: 'Nama PIC',
              hint: 'Masukkan nama PIC',
              controller: customerPicBaruController,
            ),
          ],
        ],
      ),
    );
  }

  Widget buildEmployerSection() {
    return buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.business_center_outlined,
                size: 15,
                color: Color(0xFF111827),
              ),
              SizedBox(width: 5),
              Text(
                'Pemberi Kerja (Employer)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          buildSegmentButton(
            items: const ['Sama dg Customer', 'Database', 'Baru'],
            selectedValue: selectedEmployerType,
            onChanged: (value) {
              setState(() {
                selectedEmployerType = value;
                selectedEmployer = null;
                selectedEmployerPIC = null;
              });
            },
          ),
          const SizedBox(height: 14),

          if (selectedEmployerType == 'Sama dg Customer') ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
              ),
              child: const Text(
                'Pemberi kerja adalah Customer/Instansi di atas (Direct Client).',
                style: TextStyle(
                  fontSize: 11,
                  height: 1.4,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          ] else if (selectedEmployerType == 'Database') ...[
            buildDropdown(
              label: 'Pilih Employer',
              value: selectedEmployer,
              items: instansiOptions,
              onChanged: (value) {
                setState(() {
                  selectedEmployer = value;
                });
              },
            ),
            const SizedBox(height: 13),
            buildDropdown(
              label: 'Pilih PIC',
              value: selectedEmployerPIC,
              items: picOptions,
              onChanged: (value) {
                setState(() {
                  selectedEmployerPIC = value;
                });
              },
            ),
          ] else ...[
            buildTextField(
              label: 'Nama Employer Baru',
              hint: 'Masukkan nama employer',
              controller: employerBaruController,
            ),
            const SizedBox(height: 13),
            buildTextField(
              label: 'Nama PIC',
              hint: 'Masukkan nama PIC',
              controller: employerPicBaruController,
            ),
          ],
        ],
      ),
    );
  }

  void handleNext() {
    if (selectedCustomerType == 'Database' && selectedInstansi == null) {
      showMessage('Pilih instansi terlebih dahulu');
      return;
    }

    if (selectedCustomerType == 'Database' && selectedCustomerPIC == null) {
      showMessage('Pilih PIC customer terlebih dahulu');
      return;
    }

    if (selectedEmployerType == 'Database' && selectedEmployer == null) {
      showMessage('Pilih employer terlebih dahulu');
      return;
    }

    if (selectedEmployerType == 'Database' && selectedEmployerPIC == null) {
      showMessage('Pilih PIC employer terlebih dahulu');
      return;
    }

    widget.leadData.customer = selectedInstansi ?? customerBaruController.text;

    widget.leadData.pic = selectedCustomerPIC ?? customerPicBaruController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TambahLeadStep3Screen(leadData: widget.leadData),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: primaryRed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: handleNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 5),
            Icon(Icons.arrow_forward_rounded, size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 22),
              child: Transform.translate(
                offset: const Offset(0, -18),
                child: Column(
                  children: [
                    buildProgressCard(),
                    const SizedBox(height: 14),
                    buildCustomerSection(),
                    const SizedBox(height: 14),
                    buildEmployerSection(),
                    const SizedBox(height: 26),
                    buildNextButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
