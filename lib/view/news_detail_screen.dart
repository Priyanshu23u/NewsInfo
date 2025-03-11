import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  const NewsDetailScreen({
    super.key,
    required this.newsImage,
    required this.newsDate,
    required this.newsTitle,
    required this.description,
    required this.author,
    required this.content,
    required this.source,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  late ScrollController _scrollController;
  double _opacity = 0;

  // Define theme colors to match other screens
  final primaryColor = const Color(0xFF2D3250);
  final accentColor = const Color(0xFF7077A1);
  final backgroundColor = const Color(0xFFF6F4EB);
  final cardColor = Colors.white;
  final highlightColor = const Color(0xFF424769);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _opacity = (_scrollController.offset / 250).clamp(0, 1);
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    DateTime dateTime;

    try {
      dateTime = DateTime.parse(widget.newsDate);
    } catch (e) {
      dateTime = DateTime.now();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cardColor.withOpacity(_opacity),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: cardColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 150),
          child: Text(
            widget.source,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: primaryColor,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.newsImage,
              child: Container(
                height: height * 0.45,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.newsImage,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: SpinKitFadingCircle(
                          color: highlightColor,
                          size: 50,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: accentColor.withOpacity(0.1),
                        child: Icon(
                          Icons.error_outline,
                          color: highlightColor,
                          size: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: height * 0.15,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              primaryColor.withOpacity(0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: highlightColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.source,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: highlightColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          widget.newsTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            if (widget.author.isNotEmpty) ...[
                              Icon(
                                Icons.person_outline,
                                size: 20,
                                color: accentColor,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  widget.author,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: accentColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                            ],
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                              color: accentColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              format.format(dateTime),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: accentColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.description,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            height: 1.7,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          widget.content,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            height: 1.7,
                            color: primaryColor.withOpacity(0.9),
                          ),
                        ),
                        SizedBox(height: height * 0.1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}