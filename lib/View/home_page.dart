import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Model/headlines_model.dart';
import 'package:news_app/View%20Model/view_news_repo.dart';
import 'package:news_app/View/category_screen.dart';
import 'package:news_app/View/news_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(
              () => const CategoriesOfNews(),
              transition: Transition.fadeIn,
            );
          },
          icon: Image.asset(
            "images/category_icon.png",
            width: width * 0.05,
          ),
        ),
        title: const Text(
          'News',
        ),
        actions: [
          InkWell(
              onTap: () {
                // PopupMenuButton(
                //   initialValue: 'abc',
                //   itemBuilder: (context ,)  {
                //     PopupMenuItem(child: Text('Business'), value: 'business');
                //     PopupMenuItem(child: Text('Business'), value: 'business');
                //     PopupMenuItem(child: Text('Business'), value: 'business');
                //     PopupMenuItem(child: Text('Business'), value: 'business');
                //   },
                // );
              },
              child: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          // fetch bbc news
          Expanded(
            child: FutureBuilder<NewsHeadlinesModel>(
              future: newsViewModel.fetchNewsHeadlines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitFadingCircle(
                    color: Colors.blue,
                    size: 40.0,
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        final article = snapshot.data!.articles![index];
                        DateTime dateTime =
                            DateTime.parse(article.publishedAt.toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  width: width * 0.6,
                                  height: height * 0.6,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => NewsDetailedPage(
                                          articles: article,
                                        ),
                                        transition: Transition.fadeIn,
                                      );
                                    },
                                    child: Container(
                                      width: width * 0.55,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            article.title ?? 'No Title',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            article.description ??
                                                'No Description',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  article.source!.name ??
                                                      'No Description',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${dateTime.month.toString()}"
                                                  '/'
                                                  "${dateTime.day.toString()}"
                                                  '/'
                                                  "${dateTime.year.toString()}",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
                return const Center(
                  child: Text("No Data Available"),
                );
              },
            ),
          ),

          // fetch everything news
          // Expanded(
          //   child: FutureBuilder<EverythingNewsModel>(
          //     future: newsViewModel.fetcheverythingNewsHeadlines(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const SpinKitFadingCircle(
          //           color: Colors.blue,
          //           size: 40.0,
          //         );
          //       } else if (snapshot.hasError) {
          //         return const Center(
          //           child: Text('An error occurred'),
          //         );
          //       } else {
          //         if (snapshot.hasData) {
          //           return ListView.builder(
          //             scrollDirection: Axis.vertical,
          //             itemCount: snapshot.data!.articles!.length,
          //             itemBuilder: (context, index) {
          //               final article = snapshot.data!.articles![index];
          //               return Padding(
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 10, vertical: 10),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     ClipRRect(
          //                       borderRadius: BorderRadius.circular(10),
          //                       child: CachedNetworkImage(
          //                         imageUrl: article.urlToImage.toString(),
          //                         fit: BoxFit.cover,
          //                         width: width * 0.3,
          //                         height: height * 0.13,
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: Padding(
          //                         padding:
          //                             const EdgeInsets.symmetric(horizontal: 8),
          //                         child: Column(
          //                           children: [
          //                             Text(
          //                               article.title ?? 'No Title',
          //                               style: GoogleFonts.poppins(
          //                                 color: Colors.black,
          //                                 fontWeight: FontWeight.w500,
          //                                 fontSize: 12,
          //                               ),
          //                               maxLines: 2,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //           );
          //         }
          //       }
          //       return const Center(
          //         child: Text("No Data Available"),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
