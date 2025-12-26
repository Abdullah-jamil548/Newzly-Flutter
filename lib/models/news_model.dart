import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class news with ChangeNotifier{
  List<Map<String,dynamic>>addtask=[];
  String ?author;
  String ?img;
  String ?title;
  Future<void> getData() async {
    try {
      var response = await get(
        Uri.parse("https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=4d0a4436a06946678895584c8c2eab90"),
      );
      print("api: ${response.statusCode}");
      addtask.clear();
      var data = jsonDecode(response.body);
      for(var article in data["articles"])
      {
        author= article['author'];
        img=article["urlToImage"];
        title=article["publishedAt"];
        addtask.add({
          "author":author,
          "img":img,
          "title":title
        });
      }
    }
    catch (e) {
      Text("Error");
    }

  }

}