import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesContainer extends StatefulWidget {
  final String categoryName;
  const CategoriesContainer({super.key, required this.categoryName});

  @override
  State<CategoriesContainer> createState() => _CategoriesContainerState();
}

class _CategoriesContainerState extends State<CategoriesContainer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Container(
      width: width * 0.3,
      height: height * 0.06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400),
      child: Center(
        child: Text(
          widget.categoryName,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
