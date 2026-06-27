import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'tambah_lead_step4.dart';
import 'lead_data.dart';

class TambahLeadStep3Screen extends StatefulWidget {
  final LeadData leadData;

  const TambahLeadStep3Screen({super.key, required this.leadData});

  @override
  State<TambahLeadStep3Screen> createState() => _TambahLeadStep3ScreenState();
}

class _TambahLeadStep3ScreenState extends State<TambahLeadStep3Screen> {
  final Color primaryRed = const Color(0xFFB91C21);

  final TextEditingController estimasiNilaiController = TextEditingController();
  final TextEditingController lokasiDeliveryController =
      TextEditingController();
  final TextEditingController detailRequestController = TextEditingController();

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  String? selectedStatus;
  DateTime? tglPermintaan;
  DateTime? dueDate;

  final List<String> statusOptions = ['No Deal', 'Deal', 'In Progress'];
  @override
  void dispose() {
    estimasiNilaiController.dispose();
    lokasiDeliveryController.dispose();
    detailRequestController.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$month/$day/$year';
  }

  Future<void> pickDate({required bool isRequestDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isRequestDate
          ? (tglPermintaan ?? DateTime.now())
          : (dueDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isRequestDate) {
          tglPermintaan = picked;
        } else {
          dueDate = picked;
        }
      });
    }
  }

  InputDecoration customDecoration({required String hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryRed),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: Color(0xFF111827),
        ),
      ),
    );
  }

  void handleNext() {
    widget.leadData.proyek = detailRequestController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TambahLeadStep4Screen(leadData: widget.leadData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: primaryRed,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tambah Lead Baru',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Buat opportunity proyek baru',
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Text(
                'A',
                style: TextStyle(
                  color: primaryRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Langkah 3 dari 4',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFB91C21),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: 3 / 4,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFE5E7EB),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryRed),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel('Estimasi Nilai (Opsional)'),
                  TextField(
                    controller: estimasiNilaiController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RupiahInputFormatter(),
                    ],
                    decoration: customDecoration(hint: 'Rp 0'),
                  ),
                  const SizedBox(height: 16),
                  buildLabel('Status Awal'),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    isExpanded: true,
                    decoration: customDecoration(hint: 'Select an option'),
                    items: statusOptions.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: const TextStyle(fontSize: 13)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  buildLabel('Tgl Permintaan'),
                  GestureDetector(
                    onTap: () {
                      pickDate(isRequestDate: true);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: customDecoration(
                          hint: tglPermintaan == null
                              ? '04/22/2026'
                              : formatDate(tglPermintaan!),
                          suffixIcon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildLabel('Due Date'),
                  GestureDetector(
                    onTap: () {
                      pickDate(isRequestDate: false);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: customDecoration(
                          hint: dueDate == null
                              ? 'mm/dd/yyyy'
                              : formatDate(dueDate!),
                          suffixIcon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildLabel('Lokasi Delivery'),
                  TextField(
                    controller: lokasiDeliveryController,
                    decoration: customDecoration(hint: 'Alamat Pengiriman...'),
                  ),
                  const SizedBox(height: 16),
                  buildLabel('Detail Request'),
                  TextField(
                    controller: detailRequestController,
                    maxLines: 5,
                    decoration: customDecoration(
                      hint: 'Deskripsi lengkap permintaan...',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: handleNext,
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
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, color: Colors.white),
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

class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    final number = int.parse(digits);

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    final newText = formatter.format(number);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }
}
