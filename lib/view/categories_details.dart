import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newspaper/view/theme.dart';
import 'package:provider/provider.dart';
import '../models/categories_model.dart';
import '../models/favourite_model.dart';
class ImagePage extends StatelessWidget {
  final String imageUrl;
  final String content;
  final String source;
  final String date;
  final String title;
  final int fill;
  const ImagePage({super.key, required this.imageUrl, required this.content,required this.source,required this.date,required this.title,required this.fill});
  @override
  Widget build(BuildContext context) {
    generacategories gen = Provider.of<generacategories>(context, listen: true);
    favourite fav = Provider.of<favourite>(context, listen: false);
    ThemeProvider theme = Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: theme.isDark?Colors.black:Colors.white,
      appBar: AppBar(
          actions: [
            Padding(padding: EdgeInsets.all(20),child:GestureDetector(
                onTap: (){
                  var item = {
                    "imageUrl": imageUrl,
                    "title": title,
                    "source": source,
                    "date": date,
                    "content": content,
                  };
                  fav.add(item);
                  gen.toggleFavourite(fill);
                },
                child: Icon(
                  gen.addtask[fill]["truee"]
                      ? Icons.bookmark
                      : Icons.bookmark_outline,

                  color:theme.isDark?Colors.white:Colors.black,
                )

            ))
          ],
          scrolledUnderElevation: 0,
          backgroundColor: theme.isDark?Colors.black:Colors.white,
          centerTitle: true,
          title: Text("KHABAR",style:GoogleFonts.poppins(fontWeight: FontWeight.bold,color:theme.isDark?Colors.white:Colors.black,))),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 20,),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Hero(
                transitionOnUserGestures: true,
                tag:imageUrl, child:ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 60),
                ),),
              ),
            ),
            SizedBox(height: 15),
            Text(
                title,
                style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color:theme.isDark?Colors.white:Colors.black,)
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${source}",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color:Colors.redAccent)),
                Text(date),
              ],
            ),
            SizedBox(height: 10,),
            Text(content,style: GoogleFonts.poppins(fontSize: 20,color:Colors.grey,))
          ],
        ),
      ),
    );
  }
}
