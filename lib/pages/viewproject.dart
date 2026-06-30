import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:app_mybhakti/pages/addteam.dart';
import 'package:app_mybhakti/pages/todos_view.dart';
import 'package:app_mybhakti/pages/docs_view.dart';
import 'package:app_mybhakti/pages/invoice_view.dart';

const List<Color> avatarColors = [
  Color(0xFFF4D03F),
  Color(0xFF5DADE2),
  Color(0xFF58D68D),
  Color(0xFFAF7AC5),
  Color(0xFFFF8A65),
];

class PmoViewData extends StatefulWidget {
  final String username;
  final Map<String, dynamic> project;

  const PmoViewData({super.key, required this.username, required this.project});

  @override
  State<PmoViewData> createState() => _PmoViewDataState();
}

class _PmoViewDataState extends State<PmoViewData> {
  late Map<String, dynamic> project;

  @override
  void initState() {
    super.initState();

    project = widget.project;
  }

  Widget card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xffE2E8F0)),
      ),
      child: child,
    );
  }

  Widget title(String icon, String text, {String? action}) {
    return Row(
      children: [
        Text(icon, style: TextStyle(fontSize: 14)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const Spacer(),
        if (action != null)
          Text(
            action,
            style: const TextStyle(color: Color(0xff8B000F), fontSize: 10),
          ),
      ],
    );
  }

  int getRemainingDays() {
    DateTime today = DateTime.now();

    DateTime end = DateTime.parse(project["endDate"]);

    return end.difference(today).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pendingTodos = (project["todos"] as List)
        .expand((section) => section["items"] as List)
        .where((item) => item["completed"] == false)
        .cast<Map<String, dynamic>>()
        .take(3)
        .toList();

    final List documents = (project["documents"] as List).take(3).toList();

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
              Container(
                padding: const EdgeInsets.fromLTRB(18, 15, 18, 18),
                decoration: BoxDecoration(
                  color: Color(0xffB1121B),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white24,
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(width: 12),

                        Text(
                          "Proyek View Data",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        Spacer(),

                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Text(
                            "A",
                            style: TextStyle(
                              color: Color(0xffB1121B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: project["status"] == "ON WORKING"
                                  ? const Color(0xff2563EB)
                                  : const Color(0xff16A34A),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            project["status"],
                            style: TextStyle(
                              color: project["status"] == "ON WORKING"
                                  ? const Color(0xff2563EB)
                                  : const Color(0xff16A34A),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      project["title"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      project["client"],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),

                    SizedBox(height: 8),

                    Row(
                      children: [
                        const Text(
                          "Anggota Tim",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),

                        const Spacer(),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Lead: ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: project["lead"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        ...List.generate(
                          project["anggota"].length > 5
                              ? 5
                              : project["anggota"].length,
                          (index) {
                            String nama = project["anggota"][index];

                            return Container(
                              margin: const EdgeInsets.only(right: 6),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    avatarColors[index % avatarColors.length],
                                child: Text(
                                  nama.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        if (project["anggota"].length > 5)
                          GestureDetector(
                            onTap: () {
                              showTeamOverviewDialog(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 6),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.grey.shade300,
                                child: Text(
                                  "+${project["anggota"].length - 5}",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ), // <-- INI YANG KURANG

                        const SizedBox(width: 10),

                        /// VENDOR / CLIENT
                        Column(
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.amber,
                                  width: 3,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(
                                  project["client"]
                                      .toString()
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              "vendor",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        /// ADD MEMBER
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (context) => AddTeam(
                                  username: widget.username,
                                  project: project,
                                ),
                              ),
                            );
                          },

                          child: DottedBorder(
                            borderType: BorderType.Circle,

                            color: Colors.white,

                            strokeWidth: 2.5,

                            dashPattern: const [6, 4],

                            child: Container(
                              width: 54,
                              height: 54,

                              alignment: Alignment.center,

                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Row(
                      children: [
                        Text(
                          "Progres Keseluruhan",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),

                        Spacer(),

                        Text(
                          "${project["progress"]}%",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),

                    SizedBox(height: 5),

                    LinearProgressIndicator(
                      value: project["progress"] / 100,
                      minHeight: 5,
                      backgroundColor: Colors.white30,
                      color: Color(0xffff383c),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    /// REMINDER
                    card(
                      child: Column(
                        children: [
                          title("⏰", "REMINDER"),

                          SizedBox(height: 12),

                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xfffff7df),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xffffbf00)),
                            ),

                            child: Row(
                              children: [
                                Icon(
                                  Icons.assignment,
                                  color: Color(0xffffbf00),
                                ),

                                SizedBox(width: 12),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sisa Waktu Pengerjaan",
                                      style: TextStyle(fontSize: 12),
                                    ),

                                    Text(
                                      "Deadline segera tiba!",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),

                                Spacer(),

                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Color(0xffffbf00),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "${getRemainingDays()} Hari",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// TODOS
                    card(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PmoViewToDos(
                                    username: widget.username,
                                    project: project,
                                  ),
                                ),
                              );
                            },
                            child: title("✅", "TO-DOS", action: "Lihat semua"),
                          ),

                          const SizedBox(height: 12),

                          ...pendingTodos.map(
                            (todo) => CheckboxListTile(
                              value: false,
                              onChanged: (v) {},
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                todo["task"],
                                style: const TextStyle(fontSize: 12),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// DOCS
                    card(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PmoViewDocs(
                                    username: widget.username,
                                    project: project,
                                  ),
                                ),
                              );
                            },
                            child: title(
                              "🗂",
                              "DOCS & FILES",
                              action: "Lihat semua",
                            ),
                          ),

                          const SizedBox(height: 10),

                          ...documents
                              .map<Widget>(
                                (doc) => Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,

                                      leading: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF1F5F9),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Icon(doc["icon"], size: 22),
                                      ),

                                      title: Text(
                                        doc["name"],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      subtitle: Text(
                                        "${doc["type"]} • ${doc["size"]}",
                                        style: const TextStyle(fontSize: 10),
                                      ),

                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),

                                    const Divider(),
                                  ],
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),

                    /// INVOICE
                    card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PmoViewInvoice(
                                    username: widget.username,
                                    project: project,
                                  ),
                                ),
                              );
                            },
                            child: title(
                              "💰",
                              "INVOICE",
                              action: "Lihat semua",
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Text(
                                "Proyek",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                project["totalProjectCost"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          const Divider(),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Text(
                                "Total Billed",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                project["totalBilled"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffE6DFDA),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xffB97A57),
                              ),
                            ),

                            child: Row(
                              children: [
                                /// SISA ANGGARAN
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sisa Anggaran",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        project["remainingBudget"],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 120),

                                /// PAJAK EDITABLE
                                Expanded(child: TaxEditable(project: project)),
                              ],
                            ),
                          ),
                        ],
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

  void showTeamOverviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            constraints: const BoxConstraints(maxHeight: 550),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  children: [
                    const Text(
                      "Team Overview",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                const Divider(),

                const SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// VENDOR
                          Text(
                            "Vendors (1)",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xffB1121B),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    project["client"]
                                        .toString()
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    project["client"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// TEAM
                          Text(
                            "Team (${project["anggota"].length})",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          ...List.generate(project["anggota"].length, (index) {
                            final nama = project["anggota"][index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xffE3282E),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        avatarColors[index %
                                            avatarColors.length],
                                    child: Text(
                                      nama[0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Text(
                                      nama,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TaxEditable extends StatefulWidget {
  final Map<String, dynamic> project;

  const TaxEditable({super.key, required this.project});

  @override
  State<TaxEditable> createState() => _TaxEditableState();
}

class _TaxEditableState extends State<TaxEditable> {
  bool isEditing = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.project["tax"]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pajak",
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            isEditing
                ? Expanded(
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          widget.project["tax"] = value;
                          isEditing = false;
                        });
                      },
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffC8A98F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.project["tax"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: () {
                setState(() {
                  isEditing = true;
                  controller.text = widget.project["tax"];
                });
              },
              child: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
