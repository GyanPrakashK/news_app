import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsimage,
      newstitle,
      newsdate,
      author,
      description,
      content,
      source;
  const NewsDetailScreen(
      {super.key,
      required this.newsimage,
      required this.newstitle,
      required this.newsdate,
      required this.author,
      required this.description,
      required this.content,
      required this.source});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final formate = DateFormat('yyyy dd MMMM');
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final height = MediaQuery.sizeOf(context).height * 1;
    // ignore: unused_local_variable
    final width = MediaQuery.sizeOf(context).width * 1;

    DateTime dateTime = DateTime.parse(widget.newsdate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height * .45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(33), topRight: Radius.circular(33)),
              child: CachedNetworkImage(
                imageUrl: widget.newsimage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(33), topRight: Radius.circular(33)),
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Text(
                  widget.newstitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.source,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(formate.format(dateTime),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  child: Text(widget.description,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  child: Text(widget.content,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  child: Text(widget.author,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
