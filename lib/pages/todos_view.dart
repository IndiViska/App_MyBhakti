import 'package:flutter/material.dart';

class PmoViewToDos extends StatefulWidget {
  final String username;
  final Map<String, dynamic> project;

  const PmoViewToDos({
    super.key,
    required this.username,
    required this.project,
  });

  @override
  State<PmoViewToDos> createState() => _PmoViewToDosState();
}

class _PmoViewToDosState extends State<PmoViewToDos> {
  late List todos;

  @override
  void initState() {
    super.initState();

    todos = List.from(widget.project["todos"] ?? []);
  }

  String formatDate(String date) {
    final d = DateTime.parse(date);

    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    return "${d.day} ${months[d.month]} ${d.year}";
  }

  Future<void> _addNewSection() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );

    if (pickedDate == null) return;

    setState(() {
      todos.add({
        "title": "",
        "deadline": pickedDate.toIso8601String(),
        "isExpanded": true,
        "isNew": true,
        "showInput": true,
        "items": [],
      });

      todos.sort((a, b) {
        final dateA = DateTime.parse(a["deadline"]);
        final dateB = DateTime.parse(b["deadline"]);

        return dateA.compareTo(dateB);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

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
                        "Work Plan",
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
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
              child: Text(
                "TO-DOS",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),

          /// LIST OF TO-DOS
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final todo = todos[index];

                final items = todo["items"] as List;

                final bool allCompleted =
                    items.isNotEmpty &&
                    items.every((item) => item["completed"] == true);

                final completed = items
                    .where((e) => e["completed"] == true)
                    .length;

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 12),

                    initiallyExpanded: todo["isExpanded"] ?? true,

                    onExpansionChanged: (value) {
                      setState(() {
                        todo["isExpanded"] = value;
                      });
                    },

                    childrenPadding: EdgeInsets.zero,

                    title: Row(
                      children: [
                        Container(width: 4, height: 16, color: Colors.black),

                        const SizedBox(width: 8),

                        Expanded(
                          child: todo["isNew"] == true
                              ? TextField(
                                  autofocus: true,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: "add new list...",
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onSubmitted: (value) {
                                    if (value.trim().isEmpty) return;

                                    setState(() {
                                      todo["title"] = value.trim();
                                      todo["isNew"] = false;
                                    });
                                  },
                                )
                              : Text(
                                  todo["title"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                        ),

                        Text(
                          "$completed completed",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    children: [
                      const Divider(height: 1),

                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    item["completed"] =
                                        !(item["completed"] ?? false);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    item["completed"]
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    size: 18,
                                    color: item["completed"]
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  item["task"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),

                              const Icon(
                                Icons.drag_indicator,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (todo["showInput"] == true)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_box_outline_blank,
                                color: Colors.grey,
                                size: 18,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: TextField(
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    hintText: "add to-do...",
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onSubmitted: (value) {
                                    if (value.trim().isEmpty) return;

                                    setState(() {
                                      items.add({
                                        "task": value.trim(),
                                        "completed": false,
                                      });

                                      todo["showInput"] = false;
                                    });
                                  },
                                ),
                              ),

                              const Icon(
                                Icons.drag_indicator,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            todo["showInput"] == true
                                ? const SizedBox()
                                : InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      setState(() {
                                        todo["showInput"] = true;
                                      });
                                    },
                                    child: Container(
                                      height: 28,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Add a to-do",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ),
                                  ),

                            const Spacer(),

                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: todo["deadline"] != null
                                      ? DateTime.parse(todo["deadline"])
                                      : DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime(2035),
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    todo["deadline"] = pickedDate
                                        .toIso8601String();
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: allCompleted
                                      ? const Color(0xffE8F5EE)
                                      : const Color(0xffFFF3E0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.event,
                                      size: 12,
                                      color: allCompleted
                                          ? const Color(0xff1A6B3C)
                                          : Colors.orange.shade700,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      formatDate(
                                        todo["deadline"] ??
                                            DateTime.now().toIso8601String(),
                                      ),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: allCompleted
                                            ? const Color(0xff1A6B3C)
                                            : Colors.orange.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: todos.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
