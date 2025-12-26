import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:newspaper/view/theme.dart';
import 'package:provider/provider.dart';

import '../models/categories_model.dart';
import 'categories_details.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late ThemeProvider themeProvider;
  int myndex = 0;
  bool isLoading = false;

  List<String> categories = [
    "business",
    "entertainment",
    "health",
    "science",
    "sports",
    "technology",
  ];

  late generacategories Neews;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Neews = Provider.of<generacategories>(context, listen: false);
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    loadNews();
  }

  Future<void> loadNews() async {
    setState(() {
      isLoading = true;
    });

    await Neews.getData(categories[myndex]);
    Neews.addtask.removeWhere((item) {
      String? img = item["img"];
      return img == null || img.isEmpty || img == "null";
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: themeProvider.isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: themeProvider.isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "KHABAR",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: themeProvider.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        myndex = index;
                      });
                      loadNews();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: myndex == index ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        categories[index].toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: myndex == index ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                child: Lottie.asset(
                  "Assets/newlot.json",
                  width: 150,
                  height: 150,
                ),
              ) : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: Neews.addtask.length,
                itemBuilder: (context, index) {
                  final item = Neews.addtask[index];
                  final img = item["img"];
                  return CachedNetworkImage(
                    imageUrl: img,
                    imageBuilder: (context, provider) {
                      return newsCard(item, index);
                    },
                    placeholder: (context, url) =>
                    const SizedBox(height: 0),
                    errorWidget: (context, url, error) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted && index < Neews.addtask.length) {
                          setState(() {
                            Neews.addtask.removeAt(index);
                          });
                        }
                      });
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NEWS CARD
  Widget newsCard(dynamic item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePage(
              title: item["title"],
              imageUrl: item["img"],
              content: item["content"],
              source: item["source"],
              date: item["data"],
              fill: index,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        height: 120,
        decoration: BoxDecoration(
          color: themeProvider.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Hero(
                tag: item["img"],
                child: CachedNetworkImage(
                  imageUrl: item["img"],
                  width: 130,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // TEXT CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"] ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: themeProvider.isDark ? Colors.white : Colors.black,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    "Source: ${item["source"]}",
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    item["data"] ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      color: Colors.grey,
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
