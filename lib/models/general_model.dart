import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class generalnews with ChangeNotifier{
  List<Map<String,dynamic>>addtask=[];
  Future<void> getData() async {
    try {
      var response = await get(
        Uri.parse( "https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=$apiKey"),
      );
      print("api: ${response.statusCode}");
      var data = jsonDecode(response.body);
      addtask.clear();
      for(var article in data["articles"])
      {
        addtask.add({
          "author": article['author'] ?? "Unknown",
          "img": article["urlToImage"] ?? "https://via.placeholder.com/150",
          "title": article["title"] ?? "No Title",
          "data": article["publishedAt"] ?? "",
          "content": article["description"] ?? "",
          "source" : article["source"]["name"]??"Unknown",
        });

      }
    }
    catch (e) {
      Text("Error");
    }
  }
}