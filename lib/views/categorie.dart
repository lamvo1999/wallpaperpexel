import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperpexel/data/data.dart';
import 'package:wallpaperpexel/model/wallpaper_model.dart';
import 'package:wallpaperpexel/widget/widget.dart';
import 'package:http/http.dart' as http;

class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({this.categorieName});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List<WallpaperModel> wallpapers = new List();
  getSearchWallpaper(String query) async{

    var url = Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=80');
    var response = await http.get(url,
        headers: {
          "Authorization" : apiKey});

    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
   getSearchWallpaper(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              wallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
