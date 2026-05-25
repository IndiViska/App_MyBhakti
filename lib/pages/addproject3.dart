import 'package:flutter/material.dart';

class AddProjectPage3 extends StatefulWidget {
  final String username;

  const AddProjectPage3({super.key, required this.username});

  @override
  State<AddProjectPage3> createState() => _AddProjectPage3State();
}

class _AddProjectPage3State extends State<AddProjectPage3> {
  String? selectedPicLt;
  String? selectedPicMarketing;

  final List<String> picLtList = [
    "Rizky Pratama",
    "Ahmad Fauzi",
    "Dimas Saputra",
  ];

  final List<String> picMarketingList = [
    "Salsa Putri",
    "Nadia Aulia",
    "Kevin Wijaya",
  ];

  void validateAndNext() {
    if (selectedPicLt == null || selectedPicMarketing == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Semua data wajib diisi terlebih dahulu",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      return;
    }

    // NEXT PAGE
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => const AddProjectPage4(),
    //   ),
    // );
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
                /// BACK BUTTON
                Container(
                  width: 38,
                  height: 38,

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

                    children: const [
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
                        "Tambah data proyek yang dikerjakan",
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: const [
                              Text(
                                "Langkah 3 dari 4",

                                style: TextStyle(
                                  color: Color(0xff64748B),
                                  fontSize: 13,
                                ),
                              ),

                              Text(
                                "Team Internal",

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

                            child: LinearProgressIndicator(
                              value: 0.75,
                              minHeight: 6,

                              backgroundColor: const Color(0xffE5E7EB),

                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xffC1121F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// ================= FORM CARD =================
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

                            decoration: inputDecoration(),

                            hint: const Text("Pilih PIC LT..."),

                            items: picLtList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) {
                              setState(() {
                                selectedPicLt = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          buildLabel("PIC Marketing"),

                          const SizedBox(height: 8),

                          DropdownButtonFormField<String>(
                            value: selectedPicMarketing,

                            decoration: inputDecoration(),

                            hint: const Text("Pilih PIC Marketing..."),

                            items: picMarketingList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) {
                              setState(() {
                                selectedPicMarketing = value;
                              });
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

  /// ================= LABEL =================

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

  /// ================= INPUT =================

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
