import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newspaper/view/theme.dart';
import 'package:provider/provider.dart';

import '../models/general_model.dart';
import '../models/news_model.dart';
import 'categories_page.dart';
import 'custom_drawer.dart';

class NewFirst extends StatefulWidget {
  const NewFirst({super.key});

  @override
  State<NewFirst> createState() => _NewFirstState();
}

class _NewFirstState extends State<NewFirst> {
  late news News;
  late generalnews Neews;
  late ThemeProvider themeProvider;

  bool isLoading = true;
  bool _isInitialized = false;

  final List<String> channels = [
    "CNN", "BBC News", "Samaa News", "Al Jazeera", "Geo News",
    "Dawn News", "ARY News", "Fox News", "Sky News", "NDTV"
  ];

  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  Future<void> loadNews() async {
    await News.getData();
    await Neews.getData();
    setState(() {
      isLoading = false;
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        if (_pageController.page == News.addtask.length - 1) {
          _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      News = Provider.of<news>(context, listen: false);
      Neews = Provider.of<generalnews>(context, listen: false);
      themeProvider = Provider.of<ThemeProvider>(context, listen: false);

      loadNews();
      startTimer();

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: themeProvider.isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey[100],
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.menu, size: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    Text(
                      "KHABAR",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: themeProvider.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey[100],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      onTap: () {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // ---------------- BREAKING NEWS ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Breaking News",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDark ? Colors.white : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Top Trends",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Consumer<news>(
                    builder: (context, newsData, _) {
                      if (isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return PageView.builder(
                        controller: _pageController,
                        itemCount: newsData.addtask.length,
                        onPageChanged: (value) {
                          setState(() {
                            _activePage = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          final item = newsData.addtask[index];
                          return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: item["img"],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                    errorWidget: (context, url, error) => const Icon(Icons.error, size: 60),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  top: 10,
                                  child: Text(
                                    item["author"],
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDark ? Colors.white : Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Categories()));
                      },
                      child: Text(
                        "View all",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: channels.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          color: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40,
                            child: Text(
                              channels[index],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "News Picked for You",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Consumer<generalnews>(
                  builder: (context, generalNewsData, _) {
                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: generalNewsData.addtask.length,
                      itemBuilder: (context, index) {
                        final item = generalNewsData.addtask[index];
                        return Container(
                          height: 130,
                          margin: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: item["img"],
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: double.infinity,
                                  placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["title"],
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: themeProvider.isDark ? Colors.white : Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text("Author",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: themeProvider.isDark ? Colors.white : Colors.black,
                                          fontSize: 10,
                                        )),
                                    Text(
                                      item["author"],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 8,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Source: ",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: themeProvider.isDark ? Colors.white : Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                          TextSpan(
                                            text: item["source"],
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      item["data"],
                                      style: GoogleFonts.poppins(
                                        fontSize: 7,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
