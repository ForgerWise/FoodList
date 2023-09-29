import 'package:flutter/material.dart';

class SpecialThanksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            shape: Border(
                bottom:
                    BorderSide(color: Colors.black54, style: BorderStyle.none)),
            backgroundColor: Colors.blueGrey,
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Special Thanks',
                  style: TextStyle(color: Colors.white, fontSize: 35)),
              background: ColoredBox(color: Colors.transparent),
            ),
            floating: true,
            pinned: true,
          )
        ],
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("PBL Teammates",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("植田さん", style: TextStyle(fontSize: 20)),
              Text("谷さん", style: TextStyle(fontSize: 20)),
              Text("橋本さん", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Youtubers",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("HeyFlutter.com", style: TextStyle(fontSize: 20)),
              Text("Mitch Koko", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Others",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Chatgpt", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("My Family",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
