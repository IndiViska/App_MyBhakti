import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

class PmoViewDocs extends StatefulWidget {
  final String username;
  final Map<String, dynamic> project;

  const PmoViewDocs({super.key, required this.username, required this.project});

  @override
  State<PmoViewDocs> createState() => _PmoViewDocsState();
}

class _PmoViewDocsState extends State<PmoViewDocs> {
  String selectedCategory = "All Categories";
  final TextEditingController searchController = TextEditingController();

  Future<void> _addNewSection() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddDocumentPage(username: widget.username, project: widget.project),
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

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final List documents = (project["documents"] as List?) ?? [];

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
                        "Documents & Files",
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
                          "DOCS & FILES",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xffE5E7EB)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: const [
                              DropdownMenuItem(
                                value: "All Categories",
                                child: Text("All Categories"),
                              ),
                              DropdownMenuItem(
                                value: "PDF",
                                child: Text("PDF"),
                              ),
                              DropdownMenuItem(
                                value: "XLSX",
                                child: Text("XLSX"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value!;
                              });
                            },
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
                        hintText: "Cari docs...",
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
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final doc = documents.where((d) {
                    final matchSearch = d["name"]
                        .toString()
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase());

                    final matchCategory = selectedCategory == "All Categories"
                        ? true
                        : d["type"] == selectedCategory;

                    return matchSearch && matchCategory;
                  }).toList()[index];

                  final bool isPdf = doc["type"] == "PDF";

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xffE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: isPdf
                                ? const Color(0xffEEF2FF)
                                : const Color(0xffECFDF5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            doc["icon"],
                            color: isPdf ? Colors.red : Colors.green,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc["name"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "${doc["type"]} · ${doc["size"]} · ${doc["uploader"]}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.share_outlined,
                            size: 18,
                            color: Color(0xff38BDF8),
                          ),
                          onPressed: () {
                            Share.share('''
                              📄 Document Information

                              Name      : ${doc["name"]}
                              Type      : ${doc["type"]}
                              Size      : ${doc["size"]}
                              Uploader  : ${doc["uploader"]}

                              Project   : ${project["title"]}
                              Client    : ${project["client"]}
                              Status    : ${project["status"]}
                            ''', subject: doc["name"]);
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.visibility_outlined,
                            size: 18,
                            color: Color(0xff3B82F6),
                          ),
                          onPressed: () {
                            openDocument(doc["url"]);
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.download_outlined,
                            size: 18,
                            color: Color(0xff22C55E),
                          ),
                          onPressed: () {
                            downloadFile(
                              doc["url"],
                              "${doc["name"]}.${doc["type"].toLowerCase()}",
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Delete Document"),
                                content: Text(
                                  "Yakin ingin menghapus '${doc["name"]}' ?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        project["documents"].remove(doc);
                                      });

                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "${doc["name"]} berhasil dihapus",
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                childCount: documents.where((d) {
                  final matchSearch = d["name"]
                      .toString()
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase());

                  final matchCategory = selectedCategory == "All Categories"
                      ? true
                      : d["type"] == selectedCategory;

                  return matchSearch && matchCategory;
                }).length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class AddDocumentPage extends StatefulWidget {
  final String username;
  final Map<String, dynamic> project;

  const AddDocumentPage({
    super.key,
    required this.username,
    required this.project,
  });

  @override
  State<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController vendorController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String documentType = "PDF";
  String sourceType = "Upload";
  String category = "All Categories";
  String vendor = "-Tidak Ada-";

  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  void _saveDocument() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Nama dokumen wajib diisi")));
      return;
    }

    IconData icon;

    switch (documentType) {
      case "PDF":
        icon = Icons.picture_as_pdf;
        break;
      case "DOCX":
        icon = Icons.description;
        break;
      case "XLSX":
        icon = Icons.bar_chart;
        break;
      case "PPT":
        icon = Icons.slideshow;
        break;
      default:
        icon = Icons.insert_drive_file;
    }

    widget.project["documents"].add({
      "name": nameController.text.trim(),
      "type": documentType,
      "size": "0 MB",
      "uploader": category,
      "url": linkController.text.trim(),
      "icon": icon,
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

                    const Expanded(
                      child: Text(
                        "Manage Document",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Container(
                      width: 34,
                      height: 34,
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

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Manage Document",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xffE5E7EB)),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add New Document",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          "Document Name",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),

                        const SizedBox(height: 12),

                        _field(
                          controller: nameController,
                          hint: "Masukkan disini..",
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          "Document Type",
                          style: TextStyle(fontSize: 12),
                        ),

                        const SizedBox(height: 6),

                        DropdownButtonFormField<String>(
                          initialValue: documentType,
                          decoration: _inputDecoration(),
                          items: const [
                            DropdownMenuItem(value: "PDF", child: Text("PDF")),
                            DropdownMenuItem(
                              value: "DOCX",
                              child: Text("DOCX"),
                            ),
                            DropdownMenuItem(
                              value: "XLSX",
                              child: Text("XLSX"),
                            ),
                            DropdownMenuItem(value: "PPT", child: Text("PPT")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              documentType = value!;
                            });
                          },
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "Sumber Dokumen",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: sourceType == "Upload"
                                      ? const Color(0xffC8102E)
                                      : Colors.white,
                                  foregroundColor: sourceType == "Upload"
                                      ? Colors.white
                                      : Colors.black87,
                                  side: BorderSide(
                                    color: sourceType == "Upload"
                                        ? const Color(0xffC8102E)
                                        : const Color(0xffE5E7EB),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    sourceType = "Upload";
                                  });
                                },
                                child: const Text("Upload Dokumen"),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: sourceType == "Link"
                                      ? const Color(0xffC8102E)
                                      : Colors.white,
                                  foregroundColor: sourceType == "Link"
                                      ? Colors.white
                                      : Colors.black87,
                                  side: BorderSide(
                                    color: sourceType == "Link"
                                        ? const Color(0xffC8102E)
                                        : const Color(0xffE5E7EB),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    sourceType = "Link";
                                  });
                                },
                                child: const Text("Link Dokumen"),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        if (sourceType == "Upload")
                          InkWell(
                            onTap: pickFile,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 52,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffE5E7EB),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.attach_file,
                                    color: Colors.grey,
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Text(
                                      selectedFile == null
                                          ? "Choose File"
                                          : selectedFile!.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: selectedFile == null
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        if (sourceType == "Link")
                          _field(
                            controller: linkController,
                            hint: "https://...",
                          ),

                        const SizedBox(height: 16),

                        const Text("Category"),

                        const SizedBox(height: 6),

                        DropdownButtonFormField<String>(
                          initialValue: category,
                          decoration: _inputDecoration(),
                          items: const [
                            DropdownMenuItem(
                              value: "All Categories",
                              child: Text("All Categories"),
                            ),
                            DropdownMenuItem(
                              value: "SPPH",
                              child: Text("SPPH"),
                            ),
                            DropdownMenuItem(value: "SPH", child: Text("SPH")),
                            DropdownMenuItem(
                              value: "BANEGG",
                              child: Text("BANEGG"),
                            ),
                            DropdownMenuItem(
                              value: "BAKN",
                              child: Text("BAKN"),
                            ),
                            DropdownMenuItem(value: "PO", child: Text("PO")),
                            DropdownMenuItem(value: "SPK", child: Text("SPK")),
                            DropdownMenuItem(value: "KL", child: Text("KL")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              category = value!;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        const Text("Vendor Terkait (Optional)"),

                        const SizedBox(height: 6),

                        _field(controller: vendorController, hint: "Rp 0"),

                        const SizedBox(height: 16),

                        const Text("Vendor Terkait (Optional)"),

                        const SizedBox(height: 6),

                        DropdownButtonFormField<String>(
                          initialValue: vendor,
                          decoration: _inputDecoration(),
                          items: const [
                            DropdownMenuItem(
                              value: "-Tidak Ada-",
                              child: Text("-Tidak Ada-"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              vendor = value!;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        const Text("Note"),

                        const SizedBox(height: 6),

                        TextField(
                          controller: noteController,
                          maxLines: 5,
                          decoration: _inputDecoration(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
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
                          onPressed: _saveDocument,
                          label: const Text("Add Document"),
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintStyle: TextStyle(color: Colors.grey.shade400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xffE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xffE5E7EB)),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration().copyWith(hintText: hint),
    );
  }
}
