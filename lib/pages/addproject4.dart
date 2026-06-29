import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'projectdraft.dart';
import 'project_dummy.dart';
import 'proyek.dart';

class AddProjectPage4 extends StatefulWidget {
  final String username;
  final ProjectDraft draft;
  final bool isEditMode;
  final Map<String, dynamic>? projectData;

  const AddProjectPage4({
    super.key,
    required this.username,
    required this.draft,
    this.isEditMode = false,
    this.projectData,
  });

  @override
  State<AddProjectPage4> createState() => _AddProjectPage4State();
}

class _AddProjectPage4State extends State<AddProjectPage4> {
  final TextEditingController nilaiController = TextEditingController();

  String textField1 = "";

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();

    if (widget.isEditMode && widget.projectData != null) {
      final p = widget.projectData!;
      textField1 = p["nilai"] ?? "";
      nilaiController.text = textField1;

      /// Tangani startDate: bisa berupa String atau DateTime
      final rawStart = p["startDate"];
      if (rawStart is DateTime) {
        startDate = rawStart;
      } else if (rawStart is String && rawStart.isNotEmpty) {
        startDate = DateTime.tryParse(rawStart);
      }

      /// Tangani endDate: bisa berupa String atau DateTime
      final rawEnd = p["endDate"];
      if (rawEnd is DateTime) {
        endDate = rawEnd;
      } else if (rawEnd is String && rawEnd.isNotEmpty) {
        endDate = DateTime.tryParse(rawEnd);
      }
    }
  }

  @override
  void dispose() {
    nilaiController.dispose();
    super.dispose();
  }

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

    if (widget.isEditMode && widget.projectData != null) {
      /// ================= UPDATE DATA YANG ADA =================
      final p = widget.projectData!;
      p["title"] = widget.draft.judul ?? p["title"];
      p["client"] = widget.draft.customerSelected ??
          widget.draft.newCustomerName ??
          p["client"];
      p["lead"] = widget.draft.picLt ?? p["lead"];
      p["nilai"] = widget.draft.nilaiPekerjaan;
      p["startDate"] = widget.draft.startDate;
      p["endDate"] = widget.draft.endDate;
      p["kategoriProyek"] = widget.draft.kategoriProyek;
      p["kategoriMarket"] = widget.draft.kategoriMarket;
      p["deskripsi"] = widget.draft.deskripsi;
      p["customerSelected"] = widget.draft.customerSelected;
      p["newCustomerName"] = widget.draft.newCustomerName;
      p["newCustomerPic"] = widget.draft.newCustomerPic;
      p["newCustomerPhone"] = widget.draft.newCustomerPhone;
      p["endUserSelected"] = widget.draft.endUserSelected;
      p["newEndUserName"] = widget.draft.newEndUserName;
      p["newEndUserPic"] = widget.draft.newEndUserPic;
      p["newEndUserPhone"] = widget.draft.newEndUserPhone;
      p["picMarketing"] = widget.draft.picMarketing;

      /// KEMBALI KE HALAMAN PROYEK
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => ProjectPage(username: widget.username),
        ),
        (route) => false,
      );
    } else {
      addDummyProject({
        "title": widget.draft.judul ?? "-",
        "client":
            widget.draft.customerSelected ?? widget.draft.newCustomerName ?? "-",

        "lead": widget.draft.picLt ?? "-",
        "anggota": [],

        "progress": 0,

        "status": "ON WORKING",
        "statusColor": Colors.blue,
        "isPinned": false,

        "nilai": widget.draft.nilaiPekerjaan,

        "startDate": widget.draft.startDate,
        "endDate": widget.draft.endDate,

        "todos": [],
        "documents": [],
      });

      /// PINDAH KE HALAMAN PROYEK
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => ProjectPage(username: widget.username),
        ),
        (route) => false,
      );
    }
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

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isEditMode
                            ? "Form Edit Data Proyek"
                            : "Form Tambah Data Proyek",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.isEditMode
                            ? "Edit data proyek yang dikerjakan"
                            : "Nilai & Waktu",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
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

                    style: const TextStyle(
                      color: Color(0xffC1121F),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
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
                          controller: nilaiController,
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
