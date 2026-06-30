import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  final String username;

  const SchedulePage({super.key, required this.username});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Map<String, dynamic>> schedules = [
    {
      "title": "Praying and Meditation Time",
      "time": "03:00 - 05:00",
      "color": Colors.green,
    },
    {
      "title": "Children's Prep for School",
      "time": "05:00 - 07:30",
      "color": Colors.blue,
    },
    {
      "title": "Focus Time",
      "time": "08:00 - 11:45",
      "subtitle": "Kantor Pusat",
      "color": Colors.red,
    },
    {"title": "Lunch", "time": "12:00 - 13:00", "color": Colors.grey},
  ];

  void addSchedule(Map<String, dynamic> newSchedule) {
    setState(() {
      schedules.add(newSchedule);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffC70D1A),

        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddSchedulePage()),
          );

          if (result != null) {
            addSchedule(result);
          }
        },

        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            width: double.infinity,

            padding: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              bottom: 30,
            ),

            decoration: const BoxDecoration(
              color: Color(0xffC70D1A),

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),

                bottomRight: Radius.circular(5),
              ),
            ),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    // ================= BACK BUTTON =================
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: Container(
                        height: 40,
                        width: 40,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),

                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.arrow_back_ios_new,

                          color: Colors.white,

                          size: 18,
                        ),
                      ),
                    ),

                    const Text(
                      "Schedule",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      height: 40,
                      width: 40,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),

                      alignment: Alignment.center,

                      child: const Text(
                        "A",

                        style: TextStyle(
                          color: Color(0xffC70D1A),

                          fontWeight: FontWeight.bold,

                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ================= CONTENT =================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Apr 2026",

                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      dateItem("Sen", "21", true),

                      dateItem("Sel", "22", false),

                      dateItem("Rab", "23", false),

                      dateItem("Kam", "24", false),

                      dateItem("Jum", "25", false),

                      dateItem("Sab", "26", false),

                      dateItem("Min", "27", false),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,

                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: const [
                        Text(
                          "Overdue",

                          style: TextStyle(
                            color: Colors.orange,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Reschedule",

                          style: TextStyle(
                            color: Colors.red,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "21 Apr • Hari ini • Senin",

                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  scheduleCard(schedules),

                  const SizedBox(height: 20),

                  const Text(
                    "22 Apr • Besok • Selasa",

                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  scheduleCard(schedules),

                  const SizedBox(height: 20),

                  const Text(
                    "23 Apr • Rabu",

                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  scheduleCard(schedules),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= DATE ITEM =================

  Widget dateItem(String day, String date, bool selected) {
    return Column(
      children: [
        Text(day, style: const TextStyle(color: Colors.grey, fontSize: 13)),

        const SizedBox(height: 10),

        Container(
          height: 40,
          width: 40,

          decoration: BoxDecoration(
            color: selected ? const Color(0xffC70D1A) : Colors.transparent,

            shape: BoxShape.circle,
          ),

          alignment: Alignment.center,

          child: Text(
            date,

            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,

              fontWeight: FontWeight.bold,

              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  // ================= CARD =================

  Widget scheduleCard(List<Map<String, dynamic>> data) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Column(
        children: data.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  width: 5,
                  height: 55,

                  decoration: BoxDecoration(
                    color: item["color"],

                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        item["title"],

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        item["time"],

                        style: const TextStyle(color: Colors.grey),
                      ),

                      if (item["subtitle"] != null)
                        Text(
                          item["subtitle"],

                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ================= ADD PAGE =================

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final titleController = TextEditingController();

  final descController = TextEditingController();

  final startController = TextEditingController();

  final endController = TextEditingController();

  Color selectedColor = Colors.green;

  List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: Column(
        children: [
          Container(
            width: double.infinity,

            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 30,
            ),

            decoration: const BoxDecoration(
              color: Color(0xffC70D1A),

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),

                bottomRight: Radius.circular(35),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Container(
                    height: 40,
                    width: 40,

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),

                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.arrow_back_ios_new,

                      color: Colors.white,

                      size: 18,
                    ),
                  ),
                ),

                const Text(
                  "Tambah Jadwal Baru",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  height: 40,
                  width: 40,

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),

                  alignment: Alignment.center,

                  child: const Text(
                    "A",

                    style: TextStyle(
                      color: Color(0xffC70D1A),

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Judul",

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: titleController,

                      decoration: InputDecoration(
                        hintText: "Nama agenda...",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Deskripsi",

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: descController,

                      maxLines: 4,

                      decoration: InputDecoration(
                        hintText: "Detail agenda...",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Warna label",

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: colors.map((color) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },

                          child: Container(
                            margin: const EdgeInsets.only(right: 10),

                            height: 25,
                            width: 25,

                            decoration: BoxDecoration(
                              color: color,

                              shape: BoxShape.circle,

                              border: Border.all(
                                color: selectedColor == color
                                    ? Colors.black
                                    : Colors.transparent,

                                width: 2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Tanggal",

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: startController,

                            decoration: InputDecoration(
                              hintText: "Mulai",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: TextField(
                            controller: endController,

                            decoration: InputDecoration(
                              hintText: "Selesai",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffC70D1A),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        onPressed: () {
                          Navigator.pop(context, {
                            "title": titleController.text,

                            "time":
                                "${startController.text} - ${endController.text}",

                            "subtitle": descController.text,

                            "color": selectedColor,
                          });
                        },

                        child: const Text(
                          "Simpan",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
}
