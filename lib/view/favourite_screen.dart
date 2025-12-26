import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newspaper/view/theme.dart';
import 'package:provider/provider.dart';

import '../models/favourite_model.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    favourite fav = Provider.of<favourite>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: themeProvider.isDark ? Colors.black:Colors.white,
      appBar: AppBar(
        backgroundColor:  themeProvider.isDark ? Colors.black:Colors.white,
        title:Text("KHABAR",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20,color:  themeProvider.isDark ? Colors.white:Colors.black,
        ),
        ),
        centerTitle: true,
      ),
      body: fav.newfavourites.isEmpty
          ? const Center(child: Text("No favourites yet!"))
          : ListView.builder(
        itemCount: fav.newfavourites.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = fav.newfavourites[index];
          return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                fav.remove(index);
              },
              background: Padding(padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  alignment: Alignment.centerRight,
                ),),
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      width: double.infinity,
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: item["imageUrl"],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error, size: 60),
                              ),

                            ),
                            width: 130,
                            height: 100,
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Container(
                                  width: 200,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item["title"] ?? "No Title",style: GoogleFonts.poppins(color:themeProvider.isDark ? Colors.black:Colors.black,fontSize: 10,fontWeight: FontWeight.bold)),
                                      Text(item["source"] ?? "",style: GoogleFonts.poppins(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.bold)),
                                      Text(item["date"] ?? "",style: GoogleFonts.poppins(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.bold)),

                                    ],
                                  )

                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))

          );
        },
      ),
    );
  }
}