import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_demo/models/news_info.dart';

class Api_Manager{

  Future<NewsModel> getNews()async{
    var client=http.Client();
    var news_model=null;
    
    try {
      var response=await client.get(Uri.parse("https://newsapi.org/v2/everything?domains=wsj.com&apiKey=c5e766b1d1dc41679345d1b64eeda872"));
      
      if(response.statusCode==200){
        var jsonString=response.body;
        var jsonMap=jsonDecode(jsonString);
      
        news_model=NewsModel.fromJson(jsonMap);
      }
      
    } on Exception catch (e) {
          return news_model; 
    }
    return news_model;
  }
}