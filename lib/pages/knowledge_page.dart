import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/create_article_page.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  final TextEditingController _searchController =
      TextEditingController();

  String selectedCategory = "All Categories";
  String searchQuery = "";

  // ================= DATA ARTIKEL =================
  final List<Map<String, String>> articles = [];

  // ================= KATEGORI =================
  final List<String> categories = [
    "All Categories",
    "Engineering",
    "Design",
    "Marketing",
    "HR",
    "Finance",
  ];

  // ================= FILTERED ARTICLES =================
  List<Map<String, String>> get filteredArticles {
    return articles.where((article) {
      final matchCategory = selectedCategory == "All Categories" ||
          article["category"] == selectedCategory;

      final matchSearch = searchQuery.isEmpty ||
          (article["title"] ?? "")
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (article["content"] ?? "")
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                        "Knowledge Base",

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

            // ================= BODY =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    // ================= CARD SEARCH =================
                    Container(
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
                        children: [
                          const Text(
                            "How can we help you?",

                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2D2D2D),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // ================= SEARCH FIELD =================
                          TextField(
                            controller: _searchController,

                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },

                            decoration: InputDecoration(
                              hintText:
                                  "Search for articles...",

                              hintStyle: TextStyle(
                                color:
                                    Colors.grey.shade400,
                                fontSize: 14,
                              ),

                              prefixIcon: Icon(
                                Icons.search,
                                color:
                                    Colors.grey.shade400,
                              ),

                              filled: true,
                              fillColor:
                                  Colors.grey.shade50,

                              contentPadding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),

                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),

                                borderSide: BorderSide(
                                  color: Colors
                                      .grey.shade300,
                                ),
                              ),

                              enabledBorder:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),

                                borderSide: BorderSide(
                                  color: Colors
                                      .grey.shade300,
                                ),
                              ),

                              focusedBorder:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),

                                borderSide:
                                    const BorderSide(
                                  color:
                                      Color(0xffB80D17),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // ================= NEW ARTICLE BUTTON =================
                          SizedBox(
                            width: 160,

                            child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                  0xffB80D17,
                                ),

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    25,
                                  ),
                                ),

                                padding: const EdgeInsets
                                    .symmetric(
                                  vertical: 12,
                                ),
                              ),

                              onPressed: () async {
                                final result =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const CreateArticlePage(),
                                  ),
                                );

                                if (result != null &&
                                    result
                                        is Map<String, String>) {
                                  setState(() {
                                    articles.add(result);
                                  });
                                }
                              },

                              child: const Text(
                                "New Article",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ================= CATEGORY CHIPS =================
                    SizedBox(
                      height: 40,

                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,

                        itemCount: categories.length,

                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 10),

                        itemBuilder: (context, index) {
                          final category =
                              categories[index];

                          final isSelected =
                              selectedCategory ==
                                  category;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory =
                                    category;
                              });
                            },

                            child: Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),

                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(
                                        0xffB80D17,
                                      )
                                    : Colors.white,

                                borderRadius:
                                    BorderRadius.circular(
                                  20,
                                ),

                                border: Border.all(
                                  color: isSelected
                                      ? const Color(
                                          0xffB80D17,
                                        )
                                      : Colors
                                          .grey.shade300,
                                ),
                              ),

                              child: Text(
                                category,

                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(
                                          0xffB80D17,
                                        ),

                                  fontSize: 14,

                                  fontWeight:
                                      FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ================= ARTICLE LIST =================
                    if (filteredArticles.isEmpty)
                      _buildEmptyState()
                    else
                      ...filteredArticles.map(
                        (article) =>
                            _buildArticleCard(article),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= EMPTY STATE =================
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),

        child: Column(
          children: [
            Icon(
              Icons.article_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 16),

            const Text(
              "No articles found",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff2D2D2D),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Try giving a different search term or category.",

              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ARTICLE CARD =================
  Widget _buildArticleCard(Map<String, String> article) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ================= CATEGORY & STATUS =================
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xffFDE4E4),

                  borderRadius:
                      BorderRadius.circular(10),
                ),

                child: Text(
                  article["category"] ?? "",

                  style: const TextStyle(
                    color: Color(0xffB80D17),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: article["status"] == "Published"
                      ? const Color(0xffE8F5E9)
                      : const Color(0xffFFF3E0),

                  borderRadius:
                      BorderRadius.circular(10),
                ),

                child: Text(
                  article["status"] ?? "",

                  style: TextStyle(
                    color:
                        article["status"] == "Published"
                            ? Colors.green.shade700
                            : Colors.orange.shade700,

                    fontSize: 12,

                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ================= TITLE =================
          Text(
            article["title"] ?? "",

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff2D2D2D),
            ),
          ),

          const SizedBox(height: 8),

          // ================= CONTENT PREVIEW =================
          Text(
            article["content"] ?? "",

            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}