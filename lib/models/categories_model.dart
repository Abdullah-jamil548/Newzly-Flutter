import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class generacategories with ChangeNotifier{
  List<Map<String,dynamic>>addtask=[];
  void toggleFavourite(int index) {
    addtask[index]["truee"] = !addtask[index]["truee"];
    notifyListeners();
  }
  Future<void>getData(String category) async {
    try {
      addtask.clear();
      var response = await get(
        Uri.parse("https://newsapi.org/v2/everything?q=$category&apiKey=$apiKey",
        ),
      );
      if(response.statusCode==200)
      {
        var data = jsonDecode(response.body);
        for(var article in data["articles"])
        {
          addtask.add({
            "author": article['author'] ?? "Unknown",
            "img": article["urlToImage"] ?? "https://via.placeholder.com/150",
            "title": article["title"] ?? "No Title",
            "data": article["publishedAt"] ?? "",
            "content": article["description"] ?? "",
            "source" : article["source"]["name"]??"Unknown",
            "truee":false,
          });
        }
        notifyListeners();
      }
      else {
        print("Failed: ${response.statusCode}");
      }
    }
    catch (e) {
      Text("Error");
    }
  }
}