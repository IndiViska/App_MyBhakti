import 'package:flutter/material.dart';
import 'addproject2.dart';
import 'projectdraft.dart';

class AddProjectPage extends StatefulWidget {
  final String username;
  final bool isEditMode;
  final Map<String, dynamic>? projectData;

  const AddProjectPage({
    super.key,
    required this.username,
    this.isEditMode = false,
    this.projectData,
  });

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final TextEditingController judulController = TextEditingController();

  final TextEditingController deskripsiController = TextEditingController();

  String? selectedKategoriProyek;
  String? selectedKategoriMarket;

  final List<String> kategoriProyek = [
    "------------",
    "Solusi Teknologi",
    "Konsultasi",
    "Perangkat dan Infrastruktur",
  ];

  final List<String> kategoriMarket = [
    "------------",
    "Telkom Group",
    "YPT Group",
    "Eksternal",
  ];

  /// ================= DRAFT =================
  late final ProjectDraft draft;

  @override
  void initState() {
    super.initState();

    if (widget.isEditMode && widget.projectData != null) {
      final p = widget.projectData!;

      /// Pre-fill dari data proyek yang sudah ada
      judulController.text = p["title"] ?? "";
      deskripsiController.text = p["deskripsi"] ?? "";
      selectedKategoriProyek = p["kategoriProyek"];
      selectedKategoriMarket = p["kategoriMarket"];

      /// Parse tanggal: data dummy menyimpan sebagai String "yyyy-MM-dd"
      DateTime? parsedStart;
      DateTime? parsedEnd;
      final rawStart = p["startDate"];
      final rawEnd = p["endDate"];
      if (rawStart is DateTime) {
        parsedStart = rawStart;
      } else if (rawStart is String && rawStart.isNotEmpty) {
        parsedStart = DateTime.tryParse(rawStart);
      }
      if (rawEnd is DateTime) {
        parsedEnd = rawEnd;
      } else if (rawEnd is String && rawEnd.isNotEmpty) {
        parsedEnd = DateTime.tryParse(rawEnd);
      }

      draft = ProjectDraft(
        kategoriProyek: p["kategoriProyek"],
        kategoriMarket: p["kategoriMarket"],
        judul: p["title"],
        deskripsi: p["deskripsi"],
        customerSelected: p["customerSelected"],
        endUserSelected: p["endUserSelected"],
        newCustomerName: p["newCustomerName"],
        newCustomerPic: p["newCustomerPic"],
        newEndUserName: p["newEndUserName"],
        newEndUserPic: p["newEndUserPic"],
        newCustomerPhone: p["newCustomerPhone"],
        newEndUserPhone: p["newEndUserPhone"],
        picLt: p["lead"],
        picMarketing: p["picMarketing"],
        nilaiPekerjaan: p["nilai"],
        startDate: parsedStart,
        endDate: parsedEnd,
      );
    } else {
      draft = ProjectDraft();
    }
  }

  /// ================= NEXT PAGE =================
  void nextPage() {
    /// VALIDASI
    if (selectedKategoriProyek == null ||
        selectedKategoriMarket == null ||
        judulController.text.isEmpty ||
        deskripsiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Semua field wajib diisi",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      return;
    }

    /// ================= SIMPAN KE DRAFT =================
    draft.kategoriProyek = selectedKategoriProyek;
    draft.kategoriMarket = selectedKategoriMarket;
    draft.judul = judulController.text;
    draft.deskripsi = deskripsiController.text;

    /// ================= PINDAH PAGE =================
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddProjectPage2(
          username: widget.username,
          draft: draft,
          isEditMode: widget.isEditMode,
          projectData: widget.projectData,
        ),
      ),
    );
  }

  @override
  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: Column(
        children: [
          /// HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 55,
              left: 20,
              right: 20,
              bottom: 25,
            ),

            decoration: const BoxDecoration(color: Color(0xffC1121F)),

            child: Row(
              children: [
                /// BACK BUTTON
                Container(
                  width: 36,
                  height: 36,

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),

                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                /// TITLE
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

                      const SizedBox(height: 2),

                      Text(
                        widget.isEditMode
                            ? "Edit data proyek yang dikerjakan"
                            : "Tambah data proyek yang dikerjakan",

                        style: const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                /// PROFILE
                Container(
                  width: 34,
                  height: 34,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,

                    border: Border.all(color: Colors.grey.shade300),
                  ),

                  child: Center(
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
                ),
              ],
            ),
          ),

          /// BODY
          Expanded(
            child: Container(
              width: double.infinity,

              decoration: const BoxDecoration(
                color: Color(0xffF5F5F5),

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    /// STEP CARD
                    Container(
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(14),

                        border: Border.all(color: const Color(0xffE5E7EB)),
                      ),

                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: const [
                              Text(
                                "Langkah 1 dari 4",

                                style: TextStyle(
                                  color: Color(0xff64748B),
                                  fontSize: 13,
                                ),
                              ),

                              Text(
                                "Info Proyek",

                                style: TextStyle(
                                  color: Color(0xffC1121F),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),

                            child: const LinearProgressIndicator(
                              value: 0.25,
                              minHeight: 6,

                              backgroundColor: Color(0xffE5E7EB),

                              valueColor: AlwaysStoppedAnimation(
                                Color(0xffC1121F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// FORM CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(14),

                        border: Border.all(color: const Color(0xffE5E7EB)),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          buildLabel("Kategori Proyek"),

                          const SizedBox(height: 8),

                          DropdownButtonFormField<String>(
                            initialValue: selectedKategoriProyek,

                            decoration: inputDecoration(),

                            hint: const Text("Pilih Kategori Proyek..."),

                            items: kategoriProyek
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) {
                              setState(() {
                                selectedKategoriProyek = value;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          buildLabel("Kategori Market"),

                          const SizedBox(height: 8),

                          DropdownButtonFormField<String>(
                            initialValue: selectedKategoriMarket,

                            decoration: inputDecoration(),

                            hint: const Text("Pilih Kategori Market..."),

                            items: kategoriMarket
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) {
                              setState(() {
                                selectedKategoriMarket = value;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          buildLabel("Judul Proyek"),

                          const SizedBox(height: 8),

                          TextField(
                            controller: judulController,

                            decoration: inputDecoration(hint: "Pekerjaan"),
                          ),

                          const SizedBox(height: 18),

                          buildLabel("Deskripsi Proyek"),

                          const SizedBox(height: 8),

                          TextField(
                            controller: deskripsiController,

                            maxLines: 5,

                            decoration: inputDecoration(
                              hint: "Masukkan deskripsi proyek",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 52,

                      child: ElevatedButton(
                        onPressed: nextPage,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffC1121F),

                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: const [
                            Text(
                              "Next",

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(width: 6),

                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel(String title) {
    return Text(
      title,

      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xff111827),
      ),
    );
  }

  InputDecoration inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,

      hintStyle: const TextStyle(color: Color(0xff9CA3AF), fontSize: 14),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(color: Color(0xffE5E7EB)),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(color: Color(0xffE5E7EB)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(color: Color(0xffC1121F), width: 1.2),
      ),
    );
  }
}
