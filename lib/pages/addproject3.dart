import 'package:flutter/material.dart';
import 'addproject4.dart';
import 'projectdraft.dart';

class AddProjectPage3 extends StatefulWidget {
  final String username;
  final ProjectDraft draft;

  const AddProjectPage3({
    super.key,
    required this.username,
    required this.draft,
  });

  @override
  State<AddProjectPage3> createState() => _AddProjectPage3State();
}

class _AddProjectPage3State extends State<AddProjectPage3> {
  String? selectedPicLt;
  String? selectedPicMarketing;

  final List<String> picLtList = [
    "------------",
    "Nisa Siregar - Staff Sub Unit Am YPT Group - Sub Unit AM YPT Group",
    "Ayu Setiawan - Komisaris Utama",
    "Staf SOLTEK - Staff Sub Unit Teknologi - Suub Unit Solusi Teknologi",
    "Wahyu Pratama - Direktur Utama",
  ];

  final List<String> picMarketingList = [
    "------------",
    "Nisa Siregar - Staff Sub Unit Am YPT Group - Sub Unit AM YPT Group",
    "Ayu Setiawan - Komisaris Utama",
    "Staf SOLTEK - Staff Sub Unit Teknologi - Suub Unit Solusi Teknologi",
    "Wahyu Pratama - Direktur Utama",
  ];

  void validateAndNext() {
    if (selectedPicLt == null || selectedPicMarketing == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "PIC LT dan PIC Marketing wajib dipilih",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    /// ================= SIMPAN KE DRAFT =================
    widget.draft.picLt = selectedPicLt;
    widget.draft.picMarketing = selectedPicMarketing;

    /// ================= NEXT PAGE =================
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddProjectPage4(username: widget.username, draft: widget.draft),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: Column(
        children: [
          /// ================= HEADER =================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 55,
              left: 20,
              right: 20,
              bottom: 28,
            ),
            decoration: const BoxDecoration(color: Color(0xffC1121F)),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
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
                        "Form Tambah Data Proyek",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Pilih PIC Internal",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                /// PROFILE
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      widget.username.isNotEmpty
                          ? widget.username[0].toUpperCase()
                          : "A",
                      style: const TextStyle(
                        color: Color(0xffC1121F),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// ================= BODY =================
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
                    /// ================= STEP CARD =================
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xffE5E7EB)),
                      ),
                      child: Column(
                        children: const [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Langkah 3 dari 4",
                                style: TextStyle(
                                  color: Color(0xff64748B),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "PIC Internal",
                                style: TextStyle(
                                  color: Color(0xffC1121F),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: 0.75,
                            minHeight: 6,
                            backgroundColor: Color(0xffE5E7EB),
                            valueColor: AlwaysStoppedAnimation(
                              Color(0xffC1121F),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// ================= FORM =================
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
                          buildLabel("PIC LT"),
                          const SizedBox(height: 8),

                          DropdownButtonFormField<String>(
                            value: selectedPicLt,
                            isExpanded: true,
                            decoration: inputDecoration(),
                            hint: const Text("Pilih PIC LT"),
                            items: picLtList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() => selectedPicLt = value);
                            },
                          ),

                          const SizedBox(height: 20),

                          buildLabel("PIC Marketing"),
                          const SizedBox(height: 8),

                          DropdownButtonFormField<String>(
                            value: selectedPicMarketing,
                            isExpanded: true,
                            decoration: inputDecoration(),
                            hint: const Text("Pilih PIC Marketing"),
                            items: picMarketingList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() => selectedPicMarketing = value);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// ================= BUTTON =================
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: validateAndNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffC1121F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Next",
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
          ),
        ],
      ),
    );
  }

  /// ================= LABEL =================
  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xff111827),
      ),
    );
  }

  /// ================= INPUT STYLE =================
  InputDecoration inputDecoration() {
    return InputDecoration(
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
        borderSide: const BorderSide(color: Color(0xffC1121F)),
      ),
    );
  }
}
