import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'projectdraft.dart';
import 'project_dummy.dart';
import 'proyek.dart';

class AddProjectPage4 extends StatefulWidget {
  final String username;
  final ProjectDraft draft;

  const AddProjectPage4({
    super.key,
    required this.username,
    required this.draft,
  });

  @override
  State<AddProjectPage4> createState() => _AddProjectPage4State();
}

class _AddProjectPage4State extends State<AddProjectPage4> {
  String textField1 = "";

  DateTime? startDate;
  DateTime? endDate;

  Future<void> pickStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => startDate = date);
    }
  }

  Future<void> pickEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => endDate = date);
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return "mm/dd/yyyy";
    return "${date.month.toString().padLeft(2, '0')}/"
        "${date.day.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  void submitData() {
    widget.draft.nilaiPekerjaan = textField1;
    widget.draft.startDate = startDate;
    widget.draft.endDate = endDate;

    addDummyProject({
      "title": widget.draft.judul ?? "-",
      "client":
          widget.draft.customerSelected ?? widget.draft.newCustomerName ?? "-",
      "status": "ON WORKING",
      "statusColor": Colors.blue,
      "isPinned": false,

      "picLt": widget.draft.picLt,
      "picMarketing": widget.draft.picMarketing,

      "nilai": widget.draft.nilaiPekerjaan,

      "startDate": widget.draft.startDate,
      "endDate": widget.draft.endDate,
    });

    /// PINDAH KE HALAMAN PROYEK
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => ProjectPage(username: widget.username)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 55,
              left: 20,
              right: 20,
              bottom: 28,
            ),
            color: const Color(0xffC1121F),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Form Tambah Data Proyek",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Nilai & Waktu",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    widget.username.isNotEmpty
                        ? widget.username[0].toUpperCase()
                        : "A",
                    style: const TextStyle(color: Color(0xffC1121F)),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // FORM
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nilai Pekerjaan"),
                        const SizedBox(height: 8),

                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            RupiahInputFormatter(),
                          ],
                          onChanged: (v) => textField1 = v,
                          decoration: const InputDecoration(
                            hintText: "Rp 0",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text("Waktu Mulai"),
                        const SizedBox(height: 8),

                        GestureDetector(
                          onTap: pickStartDate,
                          child: buildDateBox(formatDate(startDate)),
                        ),

                        const SizedBox(height: 20),

                        const Text("Waktu Akhir"),
                        const SizedBox(height: 8),

                        GestureDetector(
                          onTap: pickEndDate,
                          child: buildDateBox(formatDate(endDate)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: submitData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffC1121F),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateBox(String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(text), const Icon(Icons.calendar_today, size: 16)],
      ),
    );
  }
}

class RupiahInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,###", "id_ID");

  @override
  TextEditingValue formatEditUpdate(oldValue, newValue) {
    if (newValue.text.isEmpty) return const TextEditingValue();

    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final number = int.tryParse(digits) ?? 0;

    final formatted = "Rp ${_formatter.format(number)}";

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
