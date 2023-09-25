// ignore_for_file: unused_local_variable, duplicate_ignore

// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/Channels_Headlines_Models.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcnews,
  arynews,
  businessinsider,
  independance,
  reuters,
  cnn,
}

class _HomeScreenState extends State<HomeScreen> {
  Newsviewmodel newsviewmodel = Newsviewmodel();

  final formate = DateFormat('MMMM ,DD ,YYYY');

  FilterList? selectedMenu;
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    // ignore: unused_local_variable
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              'images/category_icon.png',
              height: 25,
              width: 25,
            ),
            onPressed: () {},
          ),
          title: Center(
            child: Text(
              'News',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
          ),
          actions: [
            PopupMenuButton<FilterList>(
                initialValue: selectedMenu,
                onSelected: (FilterList items) {
                  if (FilterList.bbcnews.name == items.name) {
                    name = 'bbc-news';
                  }
                  if (FilterList.arynews.name == items.name) {
                    name = 'ary-news';
                  }
                  if (FilterList.cnn.name == items.name) {
                    name = 'cnn';
                  }
                  setState(() {
                    selectedMenu = items;
                  });
                },
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      PopupMenuItem<FilterList>(
                          value: FilterList.bbcnews, child: Text('bbcnews')),
                      PopupMenuItem<FilterList>(
                          value: FilterList.arynews, child: Text('arynews')),
                      PopupMenuItem<FilterList>(
                          value: FilterList.cnn, child: Text('cnn')),
                      // PopupMenuItem<FilterList>(
                      //     value: FilterList.ccn, child: Text('ccn')),
                      // PopupMenuItem<FilterList>(
                      //     value: FilterList.bbcnews, child: Text('bbcnews')),
                    ])
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .5,
              width: width,
              child: FutureBuilder<NewsChannelsHeadlinesModels>(
                future: newsviewmodel.fetchNewsChannelsApi(name),
                // initialData: InitialData,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.blue,
                        size: 47,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());

                        return SizedBox(
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              height: height * 0.6,
                              width: width * .9,
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * .02),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: spinkit2,
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.all(15),
                                  height: height * .22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.7,
                                        child: Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: width * 0.7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formate.format(dateTime),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}

const spinkit2 = SpinKitCircle(
  color: Colors.blue,
  size: 48,
);
