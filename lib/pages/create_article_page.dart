import 'package:flutter/material.dart';

class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({super.key});

  @override
  State<CreateArticlePage> createState() =>
      _CreateArticlePageState();
}

class _CreateArticlePageState
    extends State<CreateArticlePage> {
  final TextEditingController _titleController =
      TextEditingController();

  final TextEditingController _contentController =
      TextEditingController();

  String? selectedCategory;
  bool isPublished = true;

  // ================= KATEGORI =================
  final List<String> categories = [
    "Engineering",
    "Design",
    "Marketing",
    "HR",
    "Finance",
  ];

  // ================= TOOLBAR ITEMS =================
  final List<Map<String, dynamic>> toolbarItems = [
    {"icon": Icons.format_bold, "tooltip": "Bold"},
    {"icon": Icons.format_italic, "tooltip": "Italic"},
    {"icon": Icons.format_underlined, "tooltip": "Underline"},
    {"icon": Icons.format_strikethrough, "tooltip": "Strikethrough"},
    {"icon": Icons.format_list_bulleted, "tooltip": "Bullet List"},
    {"icon": Icons.format_list_numbered, "tooltip": "Numbered List"},
    {"icon": Icons.link, "tooltip": "Link"},
    {"icon": Icons.image_outlined, "tooltip": "Image"},
    {"icon": Icons.code, "tooltip": "Code"},
    {"icon": Icons.functions, "tooltip": "Formula"},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 28,
              ),

              decoration: const BoxDecoration(
                color: Color(0xffB80D17),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),

              child: Column(
                children: [
                  // ================= APPBAR =================
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },

                        child: Container(
                          height: 42,
                          width: 42,

                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.2),

                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const Text(
                        "Create Article",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const CircleAvatar(
                        backgroundColor: Colors.white,

                        child: Text(
                          "A",

                          style: TextStyle(
                            color: Color(0xffB80D17),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ================= FORM =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      // ================= TITLE =================
                      const Text(
                        "Title",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2D2D2D),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _titleController,

                        decoration: InputDecoration(
                          hintText:
                              "Article Title (e.g. How to install Docker)",

                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),

                          filled: true,
                          fillColor: Colors.grey.shade50,

                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),

                            borderSide: BorderSide(
                              color:
                                  Colors.grey.shade300,
                            ),
                          ),

                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),

                            borderSide: BorderSide(
                              color:
                                  Colors.grey.shade300,
                            ),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),

                            borderSide: const BorderSide(
                              color: Color(0xffB80D17),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ================= CATEGORY =================
                      const Text(
                        "Category",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2D2D2D),
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: selectedCategory,

                        decoration: InputDecoration(
                          hintText:
                              "-- Select Category --",

                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),

                          filled: true,
                          fillColor: Colors.grey.shade50,

                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),

                            borderSide: BorderSide(
                              color:
                                  Colors.grey.shade300,
                            ),
                          ),

                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),

                            borderSide: BorderSide(
                              color:
                                  Colors.grey.shade300,
                            ),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),

                            borderSide: const BorderSide(
                              color: Color(0xffB80D17),
                            ),
                          ),
                        ),

                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                        ),

                        items: categories.map((cat) {
                          return DropdownMenuItem<String>(
                            value: cat,
                            child: Text(cat),
                          );
                        }).toList(),

                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      // ================= STATUS =================
                      const Text(
                        "Status",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2D2D2D),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,

                            child: Checkbox(
                              value: isPublished,

                              onChanged: (value) {
                                setState(() {
                                  isPublished =
                                      value ?? true;
                                });
                              },

                              activeColor:
                                  const Color(0xffB80D17),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  4,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            "Publish",

                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff2D2D2D),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ================= CONTENT =================
                      const Text(
                        "Content",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2D2D2D),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ================= TOOLBAR =================
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,

                          borderRadius:
                              const BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),

                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),

                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child: Row(
                            children: [
                              // Normal dropdown
                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),

                                child: Row(
                                  children: [
                                    Text(
                                      "Normal",

                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors
                                            .grey
                                            .shade700,
                                      ),
                                    ),

                                    Icon(
                                      Icons
                                          .arrow_drop_down,
                                      color: Colors
                                          .grey.shade700,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),

                              // Divider
                              Container(
                                width: 1,
                                height: 24,
                                color:
                                    Colors.grey.shade300,
                              ),

                              // Toolbar buttons
                              ...toolbarItems.map(
                                (item) => IconButton(
                                  onPressed: () {},

                                  icon: Icon(
                                    item["icon"]
                                        as IconData,

                                    size: 20,

                                    color: Colors
                                        .grey.shade700,
                                  ),

                                  tooltip:
                                      item["tooltip"]
                                          as String,

                                  padding:
                                      const EdgeInsets
                                          .all(6),

                                  constraints:
                                      const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ================= CONTENT FIELD =================
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color:
                                  Colors.grey.shade300,
                            ),
                            right: BorderSide(
                              color:
                                  Colors.grey.shade300,
                            ),
                            bottom: BorderSide(
                              color:
                                  Colors.grey.shade300,
                            ),
                          ),

                          borderRadius:
                              const BorderRadius.only(
                            bottomLeft:
                                Radius.circular(14),
                            bottomRight:
                                Radius.circular(14),
                          ),
                        ),

                        child: TextField(
                          controller: _contentController,

                          maxLines: 8,
                          minLines: 8,

                          decoration: InputDecoration(
                            hintText:
                                "Write your article content here...",

                            hintStyle: TextStyle(
                              color:
                                  Colors.grey.shade400,
                              fontSize: 14,
                            ),

                            filled: true,
                            fillColor: Colors.white,

                            contentPadding:
                                const EdgeInsets.all(16),

                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ================= BOTTOM BUTTONS =================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),

              child: Row(
                children: [
                  // ================= CANCEL BUTTON =================
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back,
                        size: 18,
                      ),

                      label: const Text("Cancel"),

                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            const Color(0xff2D2D2D),

                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            25,
                          ),
                        ),

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // ================= CREATE BUTTON =================
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_titleController
                                .text.isEmpty ||
                            selectedCategory == null ||
                            _contentController
                                .text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please fill in all required fields",
                              ),

                              backgroundColor:
                                  Color(0xffB80D17),
                            ),
                          );

                          return;
                        }

                        final articleData =
                            <String, String>{
                          "title":
                              _titleController.text,
                          "category":
                              selectedCategory ?? "",
                          "status": isPublished
                              ? "Published"
                              : "Draft",
                          "content":
                              _contentController.text,
                        };

                        Navigator.pop(
                          context,
                          articleData,
                        );
                      },

                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 18,
                      ),

                      label: const Text(
                        "Create Article",
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xffB80D17),

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            25,
                          ),
                        ),

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
