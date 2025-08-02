// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class Imageshow extends StatefulWidget {
  List<File> imageList;
  int selectedIndex;
  Imageshow({super.key, required this.imageList, required this.selectedIndex});
  @override
  State<Imageshow> createState() => _ImageshowState();
}

class _ImageshowState extends State<Imageshow> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = widget.selectedIndex;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  bool isArabic = CacheHelper.languageCode == 'ar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          double velocity = details.delta.dy;
          if (velocity < 15) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  selectedPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(color: Colors.black),
                  child: InteractiveViewer(
                    panEnabled: false, // Set it to false
                    boundaryMargin: EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 2,
                    child: Image.file(widget.imageList[index]),
                  ),
                );
              },
              itemCount: widget.imageList.length,
            ),
            Visibility(
              visible: widget.imageList.length > 1,
              child: Positioned(
                bottom: 50,
                child: PageViewDotIndicator(
                  currentItem: selectedPage,
                  count: widget.imageList.length,
                  unselectedColor: Colors.blueGrey,
                  selectedColor: AppColors.orange,
                  duration: const Duration(milliseconds: 200),
                  boxShape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6),
                  onItemClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  size: Size(20, 6),
                  unselectedSize: Size(6, 6),
                ),
              ),
            ),
            Positioned(
              left: !isArabic ? 10 : null,
              top: 50,
              right: !isArabic ? null : 10,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 34,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
