import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AjukanCutiPage extends StatefulWidget {
  const AjukanCutiPage({super.key});

  @override
  State<AjukanCutiPage> createState() => _AjukanCutiPageState();
}

class _AjukanCutiPageState extends State<AjukanCutiPage> {
  // ================= FILE =================
  String? fileName;

  // ================= CONTROLLER =================
  String? selectedCuti;

  final TextEditingController mulaiController = TextEditingController();

  final TextEditingController selesaiController = TextEditingController();

  final TextEditingController keteranganController = TextEditingController();

  // ================= DATE =================
  DateTime? startDate;
  DateTime? endDate;

  int durasiHari = 0;

  // ================= STEP =================
  bool get step1Done => selectedCuti != null;

  bool get step2Done => startDate != null && endDate != null;

  bool get step3Done =>
      step1Done && step2Done && keteranganController.text.isNotEmpty;

  // ================= HITUNG DURASI =================
  void hitungDurasi() {
    if (startDate != null && endDate != null) {
      durasiHari = endDate!.difference(startDate!).inDays + 1;
    }
  }

  // ================= PICK FILE =================
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ================= HEADER =================
              Container(
                width: double.infinity,

                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 28,
                ),

                decoration: const BoxDecoration(
                  color: Color(0xffB80D17),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),

                child: Column(
                  children: [
                    // ================= APPBAR =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: Container(
                            height: 42,
                            width: 42,

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),

                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const Text(
                          "Ajukan Cuti Baru",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const CircleAvatar(
                          backgroundColor: Colors.white,

                          child: Text(
                            "A",

                            style: TextStyle(
                              color: Color(0xffB80D17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ================= CARD =================
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: const Color(0xffD20F1E),

                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: const [
                              Text(
                                "Sisa Hak Cuti 2026",

                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),

                              Text(
                                "Digunakan 4\nTotal 12",

                                textAlign: TextAlign.end,

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: const [
                              Text(
                                "8",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(width: 6),

                              Text(
                                "Hari",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ================= STEP =================
                    Row(
                      children: [
                        buildStep(number: "1", isActive: step1Done),

                        Expanded(
                          child: Divider(
                            color: step1Done
                                ? Colors.green
                                : Colors.grey.shade400,
                            thickness: 2,
                          ),
                        ),

                        buildStep(
                          number: "2",
                          isActive: step2Done,
                          isRed: !step2Done,
                        ),

                        Expanded(
                          child: Divider(
                            color: step2Done
                                ? Colors.green
                                : Colors.grey.shade400,
                            thickness: 2,
                          ),
                        ),

                        buildStep(
                          number: "3",
                          isActive: step3Done,
                          isRed: !step3Done,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: const [
                        Text(
                          "Jenis",

                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),

                        Text(
                          "Tanggal",

                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),

                        Text(
                          "Kirim",

                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================= FORM =================
              Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // ================= JENIS CUTI =================
                    const Text(
                      "Jenis Cuti *",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField(
                      initialValue: selectedCuti,

                      decoration: InputDecoration(
                        hintText: "Pilih",

                        filled: true,
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      items: const [
                        DropdownMenuItem(
                          value: "Cuti Tahunan",
                          child: Text("Cuti Tahunan"),
                        ),

                        DropdownMenuItem(
                          value: "Cuti Sakit",
                          child: Text("Cuti Sakit"),
                        ),

                        DropdownMenuItem(
                          value: "Cuti Melahirkan",
                          child: Text("Cuti Melahirkan"),
                        ),

                        DropdownMenuItem(
                          value: "Cuti Penting",
                          child: Text("Cuti Penting"),
                        ),

                        DropdownMenuItem(
                          value: "Cuti Besar",
                          child: Text("Cuti Besar"),
                        ),
                      ],

                      onChanged: (value) {
                        setState(() {
                          selectedCuti = value;
                        });
                      },
                    ),

                    const SizedBox(height: 28),

                    // ================= TANGGAL =================
                    const Text(
                      "Tanggal Cuti *",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2030),
                              );

                              if (picked != null) {
                                setState(() {
                                  startDate = picked;

                                  mulaiController.text =
                                      "${picked.day}/${picked.month}/${picked.year}";

                                  hitungDurasi();
                                });
                              }
                            },

                            child: AbsorbPointer(
                              child: TextField(
                                controller: mulaiController,

                                decoration: InputDecoration(
                                  hintText: "Mulai",

                                  filled: true,
                                  fillColor: Colors.white,

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2030),
                              );

                              if (picked != null) {
                                setState(() {
                                  endDate = picked;

                                  selesaiController.text =
                                      "${picked.day}/${picked.month}/${picked.year}";

                                  hitungDurasi();
                                });
                              }
                            },

                            child: AbsorbPointer(
                              child: TextField(
                                controller: selesaiController,

                                decoration: InputDecoration(
                                  hintText: "Selesai",

                                  filled: true,
                                  fillColor: Colors.white,

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ================= DURASI =================
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xffFDE4E4),

                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            "Durasi pengajuan",

                            style: TextStyle(color: Colors.red),
                          ),

                          Text(
                            "$durasiHari hari",

                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ================= KETERANGAN =================
                    const Text(
                      "Keterangan *",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: keteranganController,

                      maxLines: 4,

                      onChanged: (value) {
                        setState(() {});
                      },

                      decoration: InputDecoration(
                        hintText: "Tuliskan alasan pengajuan cuti",

                        filled: true,
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ================= LAMPIRAN =================
                    const Text(
                      "Lampiran (opsional)",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: pickFile,

                      child: Container(
                        width: double.infinity,
                        height: 120,

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(16),

                          border: Border.all(color: Colors.grey.shade300),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.file_copy_outlined,
                              size: 40,
                              color: Colors.grey.shade600,
                            ),

                            const SizedBox(height: 10),

                            Text(
                              fileName ?? "Unggah dokumen pendukung",

                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "PDF, JPG, PNG - maks 5 MB",

                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ================= BUTTON =================
                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffB80D17),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        onPressed: step3Done
                            ? () {
                                final dataBaru = {
                                  "title": selectedCuti,
                                  "date":
                                      "${mulaiController.text} - ${selesaiController.text} • $durasiHari hari",
                                  "status": "Menunggu",
                                  "color": Colors.orange,
                                };

                                Navigator.pop(context, dataBaru);
                              }
                            : null,

                        child: const Text(
                          "Kirim Pengajuan",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= STEP =================
  Widget buildStep({
    required String number,
    bool isActive = false,
    bool isRed = false,
  }) {
    return CircleAvatar(
      radius: 17,

      backgroundColor: isActive
          ? Colors.green
          : isRed
          ? const Color(0xffB80D17)
          : Colors.grey.shade300,

      child: isActive
          ? const Icon(Icons.check, color: Colors.white, size: 20)
          : Text(
              number,

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
