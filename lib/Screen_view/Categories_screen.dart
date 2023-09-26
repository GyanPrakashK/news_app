// ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:news_app/Screen_view/home_screen.dart';
import 'package:news_app/models/Categories_News_Models.dart';
import 'package:news_app/view_model/news_view_model.dart';

class Catogries_Screen extends StatefulWidget {
  const Catogries_Screen({super.key});

  @override
  State<Catogries_Screen> createState() => _Catogries_ScreenState();
}

class _Catogries_ScreenState extends State<Catogries_Screen> {
  Newsviewmodel newsviewmodel = Newsviewmodel();

  final formate = DateFormat('yyyy dd MMMM');

  String categoriesname = 'general';

  List<String> categorielist = [
    'general',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'technology'
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final height = MediaQuery.sizeOf(context).height * 1;
    // ignore: unused_local_variable
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categorielist.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    categoriesname = categorielist[index];
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      decoration: BoxDecoration(
                          color: categoriesname == categorielist[index]
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                            child: Text(categorielist[index].toString())),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Expanded(
            child: FutureBuilder<CategoriesNewsModels>(
              future: newsviewmodel.fetchCategoriesNewsapi(categoriesname),
              // initialData: InitialData,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 47,
                    ),
                  );
                } else {
                  return ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (BuildContext context, int index) {
                      // ignore: unused_local_variable
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder: (context, url) => Container(
                                  child: spinkit2,
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              height: height * .18,
                              padding: EdgeInsets.only(left: 15),
                              child: Column(children: [
                                Text(
                                  snapshot.data!.articles![index].title
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot
                                          .data!.articles![index].source!.name
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      formate.format(dateTime),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                )
                              ]),
                            ))
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
