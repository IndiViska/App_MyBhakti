import 'package:flutter/material.dart';
//import 'package:app_mybhakti/pages/pmo_tambah3.dart';

class AddProjectPage2 extends StatefulWidget {
  final String username;

  const AddProjectPage2({super.key, required this.username});

  @override
  State<AddProjectPage2> createState() => _AddProjectPage2State();
}

class _AddProjectPage2State extends State<AddProjectPage2> {
  String customerMode = "tersimpan";
  String endUserMode = "tersimpan";

  String? selectedCustomer;
  String? selectedPicCustomer;

  String? selectedEndUser;
  String? selectedPicEndUser;

  final List<String> customerList = [
    "PT Telekomunikasi Indonesia",
    "PT Len Industri",
    "PT PLN",
  ];

  final List<String> picCustomerList = [
    "Budi Santoso",
    "Andi Wijaya",
    "Rizky Pratama",
  ];

  final List<String> endUserList = [
    "Telkom Regional",
    "Divisi IT Support",
    "Network Operation",
  ];

  final List<String> picEndUserList = ["Dian Permata", "Kevin", "Aulia"];

  final TextEditingController customerBaruController = TextEditingController();

  final TextEditingController picCustomerBaruController =
      TextEditingController();

  final TextEditingController endUserBaruController = TextEditingController();

  final TextEditingController picEndUserBaruController =
      TextEditingController();

  void validateAndNext() {
    bool isCustomerValid = customerMode == "tersimpan"
        ? selectedCustomer != null && selectedPicCustomer != null
        : customerBaruController.text.isNotEmpty &&
              picCustomerBaruController.text.isNotEmpty;

    bool isEndUserValid = endUserMode == "tersimpan"
        ? selectedEndUser != null && selectedPicEndUser != null
        : endUserBaruController.text.isNotEmpty &&
              picEndUserBaruController.text.isNotEmpty;

    if (!isCustomerValid || !isEndUserValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Semua data stakeholder wajib diisi"),
        ),
      );

      return;
    }

    //Navigator.push(
    //  context,
    //  MaterialPageRoute(
    //    builder: (_) => AddProjectPage3(
    //      username: widget.username,
    //    ),
    //  ),
    //);
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

                      SizedBox(height: 2),

                      Text(
                        "Tambah data proyek yang dikerjakan",

                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),

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
                    /// STEP
                    buildStepCard(),

                    const SizedBox(height: 18),

                    /// CUSTOMER
                    buildStakeholderCard(
                      title: "Customer",
                      mode: customerMode,

                      onModeChanged: (v) {
                        setState(() {
                          customerMode = v;
                        });
                      },

                      selectedName: selectedCustomer,

                      onNameChanged: (v) {
                        setState(() {
                          selectedCustomer = v;
                        });
                      },

                      selectedPic: selectedPicCustomer,

                      onPicChanged: (v) {
                        setState(() {
                          selectedPicCustomer = v;
                        });
                      },

                      nameList: customerList,
                      picList: picCustomerList,

                      baruNameController: customerBaruController,

                      baruPicController: picCustomerBaruController,

                      hintName: "Pilih pemberi kerja...",

                      hintPic: "Pilih PIC pemberi kerja...",
                    ),

                    const SizedBox(height: 18),

                    /// END USER
                    buildStakeholderCard(
                      title: "End User",
                      mode: endUserMode,

                      onModeChanged: (v) {
                        setState(() {
                          endUserMode = v;
                        });
                      },

                      selectedName: selectedEndUser,

                      onNameChanged: (v) {
                        setState(() {
                          selectedEndUser = v;
                        });
                      },

                      selectedPic: selectedPicEndUser,

                      onPicChanged: (v) {
                        setState(() {
                          selectedPicEndUser = v;
                        });
                      },

                      nameList: endUserList,
                      picList: picEndUserList,

                      baruNameController: endUserBaruController,

                      baruPicController: picEndUserBaruController,

                      hintName: "Pilih pengguna terakhir...",

                      hintPic: "Pilih PIC pengguna...",
                    ),

                    const SizedBox(height: 30),

                    /// BUTTON
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

  Widget buildStepCard() {
    return Container(
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
                "Langkah 2 dari 4",

                style: TextStyle(color: Color(0xff64748B), fontSize: 13),
              ),

              Text(
                "Stakeholder",

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
              value: 0.50,
              minHeight: 6,

              backgroundColor: const Color(0xffE5E7EB),

              valueColor: const AlwaysStoppedAnimation(Color(0xffC1121F)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStakeholderCard({
    required String title,
    required String mode,
    required Function(String) onModeChanged,
    required String? selectedName,
    required Function(String?) onNameChanged,
    required String? selectedPic,
    required Function(String?) onPicChanged,
    required List<String> nameList,
    required List<String> picList,
    required TextEditingController baruNameController,
    required TextEditingController baruPicController,
    required String hintName,
    required String hintPic,
  }) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                title,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffE5E7EB)),

                  borderRadius: BorderRadius.circular(8),
                ),

                child: Row(
                  children: [
                    buildModeButton(
                      "Tersimpan",
                      mode == "tersimpan",
                      () => onModeChanged("tersimpan"),
                    ),

                    buildModeButton(
                      "Baru",
                      mode == "baru",
                      () => onModeChanged("baru"),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (mode == "tersimpan") ...[
            buildLabel("Nama"),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedName,

              decoration: inputDecoration(),

              hint: Text(hintName),

              items: nameList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),

              onChanged: onNameChanged,
            ),

            const SizedBox(height: 18),

            buildLabel("PIC"),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedPic,

              decoration: inputDecoration(),

              hint: Text(hintPic),

              items: picList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),

              onChanged: onPicChanged,
            ),
          ] else ...[
            buildLabel("Nama Baru"),

            const SizedBox(height: 8),

            TextField(
              controller: baruNameController,

              decoration: inputDecoration(hint: "Masukkan nama..."),
            ),

            const SizedBox(height: 18),

            buildLabel("PIC Baru"),

            const SizedBox(height: 8),

            TextField(
              controller: baruPicController,

              decoration: inputDecoration(hint: "Masukkan PIC..."),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildModeButton(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        decoration: BoxDecoration(
          color: active ? const Color(0xffF3F4F6) : Colors.white,
        ),

        child: Text(
          title,

          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: active ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String title) {
    return Text(
      title,

      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  InputDecoration inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,

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
