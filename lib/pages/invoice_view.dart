import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class PmoViewInvoice extends StatefulWidget {
  final String username;
  final Map<String, dynamic> project;

  const PmoViewInvoice({
    super.key,
    required this.username,
    required this.project,
  });

  @override
  State<PmoViewInvoice> createState() => _PmoViewInvoiceState();
}

class _PmoViewInvoiceState extends State<PmoViewInvoice> {
  String selectedCategory = "All Categories";
  final TextEditingController searchController = TextEditingController();

  Future<void> _addNewSection() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddInvoicePage(username: widget.username, project: widget.project),
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  Future<void> openDocument(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> downloadFile(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();

      final path = "${dir.path}/$fileName";

      await Dio().download(url, path);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("$fileName downloaded")));

      OpenFilex.open(path);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Download gagal: $e")));
    }
  }

  Future<void> _showEditBillingDialog(
    Map<String, dynamic> billing,
    int index,
  ) async {
    final invoiceController = TextEditingController(
      text: billing["name"] ?? "",
    );

    final dueDateController = TextEditingController(
      text: billing["duedate"] ?? "",
    );

    final pendapatanController = TextEditingController(
      text: billing["pendapatan"] ?? "",
    );

    final bebanController = TextEditingController(text: billing["beban"] ?? "");

    final noteController = TextEditingController(text: billing["note"] ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Billing Invoice Project",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Edit Billing Invoice",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 12),

                  const Text("Invoice Name"),
                  const SizedBox(height: 6),

                  TextField(
                    controller: invoiceController,
                    decoration: InputDecoration(
                      hintText: "Masukkan disini...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text("Due Date"),
                  const SizedBox(height: 6),

                  TextField(
                    controller: dueDateController,
                    decoration: InputDecoration(
                      hintText: "mm/dd/yyyy",
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text("Nilai Pendapatan"),
                  const SizedBox(height: 6),

                  TextField(
                    controller: pendapatanController,
                    decoration: InputDecoration(
                      hintText: "Rp 0",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text("Nilai Beban"),
                  const SizedBox(height: 6),

                  TextField(
                    controller: bebanController,
                    decoration: InputDecoration(
                      hintText: "Rp 0",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text("Note"),
                  const SizedBox(height: 6),

                  TextField(
                    controller: noteController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text("Cancel"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffC8102E),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              billing["name"] = invoiceController.text;

                              billing["duedate"] = dueDateController.text;

                              billing["pendapatan"] = pendapatanController.text;

                              billing["beban"] = bebanController.text;

                              billing["note"] = noteController.text;
                            });

                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Billing berhasil diperbarui"),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text("Save"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget actionButton(
    IconData icon, {
    Color iconColor = const Color(0xff64748B),
    Color backgroundColor = const Color(0xffF8FAFC),
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE5E7EB)),
      ),
      child: Icon(icon, size: 18, color: iconColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final query = searchController.text.toLowerCase();
    final List billings = ((project["billing"] as List?) ?? []).where((b) {
      final name = (b["name"] ?? "").toString().toLowerCase();
      final status = (b["status"] ?? "").toString().toLowerCase();
      final duedate = (b["duedate"] ?? "").toString().toLowerCase();
      return name.contains(query) ||
          status.contains(query) ||
          duedate.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffC8102E),
        elevation: 4,
        onPressed: _addNewSection,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xffC1121F),
            pinned: true,
            expandedHeight: 90,
            collapsedHeight: 90,
            toolbarHeight: 0,
            automaticallyImplyLeading: false,

            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 20,
                  right: 20,
                  bottom: 25,
                ),

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
                    const Expanded(
                      child: Text(
                        "Invoice Billing",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// PROFILE
                    Container(
                      width: 34,
                      height: 34,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Color(0xffE5E7EB)),
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
            ),
          ),

          /// HEADER PROJECT
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: project["status"] == "ON WORKING"
                            ? const Color(0xffEFF6FF)
                            : const Color(0xffF0FDF4),
                        border: Border.all(
                          color: project["status"] == "ON WORKING"
                              ? const Color(0xffBFDBFE)
                              : const Color(0xffAAFDD1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: project["status"] == "ON WORKING"
                                  ? const Color(0xff2563EB)
                                  : const Color(0xff16A34A),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            project["status"],
                            style: TextStyle(
                              color: project["status"] == "ON WORKING"
                                  ? const Color(0xff2563EB)
                                  : const Color(0xff16A34A),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    project["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    project["client"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "Lead: ${project["lead"]}",
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),

                  const SizedBox(height: 18),

                  const Divider(height: 1),
                ],
              ),
            ),
          ),

          /// TITLE
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "INVOICE",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xffE5E7EB)),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Cari billing...",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.only(top: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final billing = billings[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffD9D9D9)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TERMIN
                      Text(
                        billing["name"] ?? "-",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// DUE DATE
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            "Due ${billing["duedate"]}",
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// PENDAPATAN
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Pendapatan",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            billing["pendapatan"] ?? "-",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// BEBAN
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Beban",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            billing["beban"] ?? "-",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      const Divider(),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          /// STATUS
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffEAF2FF),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xffB9D3FF),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: Color(0xff2563EB),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  billing["status"] ?? "-",
                                  style: const TextStyle(
                                    color: Color(0xff2563EB),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // ================= SHARE =================
                          // SHARE
                          GestureDetector(
                            onTap: () {
                              Share.share("""
                                Invoice : ${billing["name"]}
                                Due Date : ${billing["duedate"]}
                                Pendapatan : ${billing["pendapatan"]}
                                Beban : ${billing["beban"]}
                                Status : ${billing["status"]}
                              """);
                            },
                            child: actionButton(Icons.share_outlined),
                          ),

                          const SizedBox(width: 8),

                          // EDIT
                          GestureDetector(
                            onTap: () {
                              _showEditBillingDialog(billing, index);
                            },
                            child: actionButton(
                              Icons.edit_outlined,
                              iconColor: const Color(0xff64748B),
                            ),
                          ),

                          const SizedBox(width: 8),

                          // DELETE
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Hapus Invoice"),
                                    content: Text(
                                      'Yakin ingin menghapus "${billing["name"]}"?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Batal"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            billings.removeAt(index);
                                          });

                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Invoice berhasil dihapus",
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Hapus",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: actionButton(
                              Icons.delete_outline,
                              iconColor: Colors.red,
                              backgroundColor: const Color(0xffFFF1F2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }, childCount: billings.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class AddInvoicePage extends StatefulWidget {
  final String username;
  final Map<String, dynamic> project;

  const AddInvoicePage({
    super.key,
    required this.username,
    required this.project,
  });

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final invoiceController = TextEditingController();
  final dueDateController = TextEditingController();
  final pendapatanController = TextEditingController();
  final bebanController = TextEditingController();
  final noteController = TextEditingController();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dueDateController.text =
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }

  Widget inputField({
    required String title,
    required TextEditingController controller,
    String hint = "",
    int maxLines = 1,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  void _saveInvoice() {
    if (invoiceController.text.isEmpty) return;

    widget.project.putIfAbsent("billing", () => []);

    (widget.project["billing"] as List).add({
      "name": invoiceController.text,
      "duedate": dueDateController.text,
      "pendapatan": pendapatanController.text,
      "beban": bebanController.text,
      "note": noteController.text,
      "status": "Waiting",
    });

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xffC1121F),
            pinned: true,
            expandedHeight: 90,
            collapsedHeight: 90,
            toolbarHeight: 0,
            automaticallyImplyLeading: false,

            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 20,
                  right: 20,
                  bottom: 25,
                ),
                child: Row(
                  children: [
                    /// Back Button
                    Container(
                      width: 36,
                      height: 36,
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

                    /// Title
                    const Expanded(
                      child: Text(
                        "Billing Invoice Project",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// Avatar
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffE5E7EB)),
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
            ),
          ),

          /// Form
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add New Billing Invoice",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    inputField(
                      title: "Invoice Name",
                      controller: invoiceController,
                      hint: "Masukkan disini..",
                    ),

                    inputField(
                      title: "Due Date",
                      controller: dueDateController,
                      hint: "mm/dd/yyyy",
                      suffixIcon: IconButton(
                        onPressed: _pickDate,
                        icon: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),

                    inputField(
                      title: "Nilai Pendapatan",
                      controller: pendapatanController,
                      hint: "Rp 0",
                      keyboardType: TextInputType.number,
                    ),

                    inputField(
                      title: "Nilai Beban",
                      controller: bebanController,
                      hint: "Rp 0",
                      keyboardType: TextInputType.number,
                    ),

                    inputField(
                      title: "Note",
                      controller: noteController,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    side: const BorderSide(color: Color(0xffCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Cancel"),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC8102E),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveInvoice,
                  label: const Text("Add Billing"),
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
