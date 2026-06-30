import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/addproject3.dart';
import 'package:app_mybhakti/pages/projectdraft.dart';

class AddProjectPage2 extends StatefulWidget {
  final String username;
  final ProjectDraft draft;
  final bool isEditMode;
  final Map<String, dynamic>? projectData;

  const AddProjectPage2({
    super.key,
    required this.username,
    required this.draft,
    this.isEditMode = false,
    this.projectData,
  });

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
    "------------",
    "PT Telkom Indonesia -TREG I (Sumatera)",
    "PT Telkom Indonesia -TREG II (Jabodetabek)",
    "PT Telkom Indonesia -TREG III (Jawa Barat)",
    "PT Telkom Indonesia -TREG VI (Jawa Tengah & DIY)",
  ];

  final List<String> endUserList = [
    "------------",
    "PT Bank Central Asia Tbk (BCA)",
    "PT Bio Farma (Persero)",
    "Dinas Komunikasi dan Informatika (Diskominfo) Jabar",
    "Poltekkes Aceh",
  ];

  final TextEditingController customerBaruController = TextEditingController();

  final TextEditingController picCustomerBaruController =
      TextEditingController();

  final TextEditingController customerPhoneController = TextEditingController();

  final TextEditingController endUserBaruController = TextEditingController();

  final TextEditingController picEndUserBaruController =
      TextEditingController();

  final TextEditingController endUserPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEditMode && widget.projectData != null) {
      final p = widget.projectData!;

      /// Pre-fill customer
      if (p["customerSelected"] != null) {
        customerMode = "tersimpan";
        selectedCustomer = p["customerSelected"];
      } else if (p["newCustomerName"] != null) {
        customerMode = "baru";
        customerBaruController.text = p["newCustomerName"] ?? "";
        picCustomerBaruController.text = p["newCustomerPic"] ?? "";
        customerPhoneController.text = p["newCustomerPhone"] ?? "";
      } else {
        // fallback dari field "client"
        final client = p["client"] as String?;
        if (client != null && customerList.contains(client)) {
          customerMode = "tersimpan";
          selectedCustomer = client;
        } else if (client != null) {
          customerMode = "baru";
          customerBaruController.text = client;
        }
      }

      /// Pre-fill end user
      if (p["endUserSelected"] != null) {
        endUserMode = "tersimpan";
        selectedEndUser = p["endUserSelected"];
      } else if (p["newEndUserName"] != null) {
        endUserMode = "baru";
        endUserBaruController.text = p["newEndUserName"] ?? "";
        picEndUserBaruController.text = p["newEndUserPic"] ?? "";
        endUserPhoneController.text = p["newEndUserPhone"] ?? "";
      }
    }
  }

  void validateAndNext() {
    bool isCustomerValid = customerMode == "tersimpan"
        ? selectedCustomer != null
        : customerBaruController.text.isNotEmpty &&
              picCustomerBaruController.text.isNotEmpty;

    bool isEndUserValid = endUserMode == "tersimpan"
        ? selectedEndUser != null
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

    /// ================= SIMPAN CUSTOMER =================
    widget.draft.customerSelected = customerMode == "tersimpan"
        ? selectedCustomer
        : null;

    widget.draft.newCustomerName = customerMode == "baru"
        ? customerBaruController.text
        : null;

    widget.draft.newCustomerPic = customerMode == "baru"
        ? picCustomerBaruController.text
        : null;

    widget.draft.newCustomerPhone = customerMode == "baru"
        ? customerPhoneController.text
        : null;

    /// ================= SIMPAN END USER =================
    widget.draft.endUserSelected = endUserMode == "tersimpan"
        ? selectedEndUser
        : null;

    widget.draft.newEndUserName = endUserMode == "baru"
        ? endUserBaruController.text
        : null;

    widget.draft.newEndUserPic = endUserMode == "baru"
        ? picEndUserBaruController.text
        : null;

    widget.draft.newEndUserPhone = endUserMode == "baru"
        ? endUserPhoneController.text
        : null;

    print("Lolos validasi");

    print(widget.draft.customerSelected);
    print(widget.draft.newCustomerName);
    print(widget.draft.endUserSelected);
    print(widget.draft.newEndUserName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddProjectPage3(
          username: widget.username,
          draft: widget.draft,
          isEditMode: widget.isEditMode,
          projectData: widget.projectData,
        ),
      ),
    );
  }

  @override
  void dispose() {
    customerBaruController.dispose();
    picCustomerBaruController.dispose();
    customerPhoneController.dispose();
    endUserBaruController.dispose();
    picEndUserBaruController.dispose();
    endUserPhoneController.dispose();
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
                    buildStepCard(),

                    const SizedBox(height: 18),

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

                      baruNameController: customerBaruController,

                      baruPicController: picCustomerBaruController,

                      phoneController: customerPhoneController,

                      hintName: "Pilih pemberi kerja...",

                      hintPic: "Pilih PIC pemberi kerja...",
                    ),

                    const SizedBox(height: 18),

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

                      baruNameController: endUserBaruController,

                      baruPicController: picEndUserBaruController,

                      phoneController: endUserPhoneController,

                      hintName: "Pilih pengguna terakhir...",

                      hintPic: "Pilih PIC pengguna...",
                    ),

                    const SizedBox(height: 30),

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

            child: const LinearProgressIndicator(
              value: 0.50,
              minHeight: 6,

              backgroundColor: Color(0xffE5E7EB),

              valueColor: AlwaysStoppedAnimation(Color(0xffC1121F)),
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
    required TextEditingController baruNameController,
    required TextEditingController baruPicController,
    required TextEditingController phoneController,
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
              isExpanded: true,
              initialValue: selectedName,

              decoration: inputDecoration(),

              hint: Text(hintName),

              items: nameList.map((e) {
                return DropdownMenuItem<String>(
                  value: e,

                  child: Text(e, overflow: TextOverflow.ellipsis),
                );
              }).toList(),

              onChanged: (value) {
                onNameChanged(value);
              },
            ),

            const SizedBox(height: 18),

            buildLabel("PIC"),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(12),

                border: Border.all(color: const Color(0xffE5E7EB)),
              ),

              child: Text(
                selectedPic ?? "Pilih PIC Pemberi Kerja...",

                style: TextStyle(
                  fontSize: 14,
                  color: selectedPic == null ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ] else ...[
            buildLabel("Instansi $title"),

            const SizedBox(height: 8),

            TextField(
              controller: baruNameController,

              decoration: inputDecoration(hint: "Nama PT / Instansi..."),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      buildLabel("Nama PIC"),

                      const SizedBox(height: 8),

                      TextField(
                        controller: baruPicController,

                        decoration: inputDecoration(hint: "Nama PIC..."),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      buildLabel("No HP PIC"),

                      const SizedBox(height: 8),

                      TextField(
                        controller: phoneController,

                        keyboardType: TextInputType.phone,

                        decoration: inputDecoration(hint: "08xxx..."),
                      ),
                    ],
                  ),
                ),
              ],
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
