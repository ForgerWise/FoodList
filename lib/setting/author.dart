import 'package:flutter/material.dart';

class AuthorPage extends StatelessWidget {
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
              title: Text('Developer Info',
                  style: TextStyle(color: Colors.white, fontSize: 35)),
              background: ColoredBox(color: Colors.transparent),
            ),
            floating: true,
            pinned: true,
          )
        ],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/author.jpg'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                   Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text("王 映傑",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text("WANG YING CHIEH", style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        Text("オウ エイケツ", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Hi, I am a student studying at Osaka University, majoring in Information Science. I come from Taiwan, and I am currently learning Flutter as I am interested in it. I hope to create some simple, beautiful apps without Ads for people.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
