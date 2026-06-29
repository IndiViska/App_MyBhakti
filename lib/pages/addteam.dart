import 'package:flutter/material.dart';

class AddTeam extends StatefulWidget {
  final String username;
  final Map<String, dynamic> project;

  const AddTeam({super.key, required this.username, required this.project});

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  String selectedRole = "Vendor";

  final TextEditingController paymentController = TextEditingController();

  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xffEEEEEE))),
        ),

        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  side: const BorderSide(color: Color(0xffCBD5E1)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 18, color: Color(0xff64748B)),
                    SizedBox(width: 12),
                    Text("Cancel", style: TextStyle(color: Color(0xff64748B))),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffC1121F),

                  padding: const EdgeInsets.symmetric(vertical: 20),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {},

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
               
                    Text(
                      "Add New People",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(width: 20),

                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      body: CustomScrollView(
        slivers: [
          /// HEADER
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
                        color: Colors.white.withOpacity(.15),
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
                        "Manage People",
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
            ),
          ),

          /// PROJECT HEADER
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,

              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),

              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xffEFF6FF),

                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Text(
                        "• ${project["status"]}",
                        style: const TextStyle(
                          color: Color(0xff2563EB),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    project["title"],

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    project["client"],

                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),

                  Text(
                    "Lead: ${project["lead"]}",

                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),

                  const SizedBox(height: 18),

                  const Divider(),
                ],
              ),
            ),
          ),

          /// CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Manage People",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(12),

                      border: Border.all(color: Color(0xffE2E8F0)),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          "Add New Person",

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text("Role", style: TextStyle(fontSize: 12)),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            roleButton("Vendor"),
                            const SizedBox(width: 8),
                            roleButton("Team"),
                          ],
                        ),

                        const SizedBox(height: 18),

                        /// FORM BERDASARKAN ROLE
                        if (selectedRole == "Vendor") ...[
                          const Text("Vendor", style: TextStyle(fontSize: 12)),

                          const SizedBox(height: 8),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),

                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffCBD5E1),
                              ),

                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,

                                hint: const Text("------------"),

                                items:
                                    [
                                          "V-0003-PT Example Maju",
                                          "V-0002-PT Example Sejahtera",
                                          "V-0001-PT Perangkat",
                                        ]
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),

                                onChanged: (v) {},
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            "Skema Pembayaran",
                            style: TextStyle(fontSize: 12),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            controller: paymentController,

                            decoration: InputDecoration(
                              hintText: "Masukkan skema pembayaran vendor",

                              hintStyle: const TextStyle(fontSize: 12),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          const Text("Note", style: TextStyle(fontSize: 12)),

                          const SizedBox(height: 8),

                          TextField(
                            controller: noteController,

                            maxLines: 5,

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ] else ...[
                          const Text(
                            "Employee",
                            style: TextStyle(fontSize: 12),
                          ),

                          const SizedBox(height: 8),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),

                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffCBD5E1)),

                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,

                                hint: const Text("------------"),

                                items: ["Andi", "Budi", "Citra", "Dimas"]
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),

                                onChanged: (v) {},
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget roleButton(String text) {
    bool active = selectedRole == text;

    return InkWell(
      onTap: () {
        setState(() {
          selectedRole = text;
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

        decoration: BoxDecoration(
          color: active ? const Color(0xffFFF1F2) : Colors.white,

          border: Border.all(
            color: active ? const Color(0xffC1121F) : const Color(0xffCBD5E1),
          ),

          borderRadius: BorderRadius.circular(8),
        ),

        child: Text(
          text,
          style: TextStyle(
            color: active ? const Color(0xffC1121F) : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
