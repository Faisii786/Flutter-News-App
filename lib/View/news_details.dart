import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Model/headlines_model.dart';
import 'package:news_app/View%20Model/view_news_repo.dart';

class NewsDetailedPage extends StatefulWidget {
  final Articles articles;
  const NewsDetailedPage({super.key, required this.articles});

  @override
  State<NewsDetailedPage> createState() => _NewsDetailedPageState();
}

class _NewsDetailedPageState extends State<NewsDetailedPage> {
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    DateTime dateTime = DateTime.parse(widget.articles.publishedAt.toString());
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              child: CachedNetworkImage(
                imageUrl: widget.articles.urlToImage.toString(),
                fit: BoxFit.cover,
                width: width * 1,
                height: height * 0.6,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.articles.author.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14, // Corrected to fontSize
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 5, 56, 97)),
                  ),
                  Text(
                    "${dateTime.month.toString()}"
                    '/'
                    "${dateTime.day.toString()}"
                    '/'
                    "${dateTime.year.toString()}",
                    style: GoogleFonts.poppins(
                        fontSize: 14, // Corrected to fontSize
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 5, 56, 97)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                widget.articles.title.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 14, // Corrected to fontSize
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 5, 56, 97)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '${widget.articles.content.toString()}  ${widget.articles.description.toString()}',
                style: GoogleFonts.poppins(
                    fontSize: 13, // Corrected to fontSize
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'URL : ${widget.articles.url.toString()}',
                style: GoogleFonts.poppins(
                    fontSize: 13, // Corrected to fontSize
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 5, 56, 97)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
