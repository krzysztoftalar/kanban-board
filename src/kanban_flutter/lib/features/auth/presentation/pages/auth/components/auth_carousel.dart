import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../style/index.dart';

class AuthCarousel extends StatefulWidget {
  @override
  _AuthCarouselState createState() => _AuthCarouselState();
}

class _AuthCarouselState extends State<AuthCarousel> {
  final CarouselController _controller = CarouselController();
  int currPageIndex = 0;

  Widget _buildCardText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: ThemeColor.text_normal,
        fontSize: getSize(ThemeSize.fs_20),
        height: 1.7,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFirstCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.accent),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.gitAlt,
                size: getSize(30),
                color: ThemeColor.text_selected,
              ),
              SizedBox(width: getSize(8)),
              Text(
                'Git Boards',
                style: TextStyle(
                  color: ThemeColor.text_selected,
                  fontSize: getSize(35),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: getSize(30)),
          _buildCardText(
              'A more productive way for dev teams to track tasks and issues.'),
        ],
      ),
    );
  }

  Widget _buildSecondCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.accent),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCardText(
              'Use Git Boards to visualize the progress of tasks & issues through your workflow.'),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Center(
      child: Container(
        width: getSize(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Iterable<int>.generate(2)
              .map(
                (pageIndex) => InkWell(
                  onTap: () {
                    setState(() => currPageIndex = pageIndex);
                    _controller.animateToPage(
                      pageIndex,
                      duration: Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: getSize(20),
                    height: getSize(20),
                    decoration: BoxDecoration(
                      color: currPageIndex == pageIndex
                          ? ThemeColor.light_green
                          : ThemeColor.card_bg,
                      border: Border.all(
                        color: currPageIndex == pageIndex
                            ? Colors.transparent
                            : ThemeColor.blue,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: SizeConfig.screenHeight * 0.6,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              onPageChanged: (pageIndex, _) =>
                  setState(() => currPageIndex = pageIndex),
            ),
            items: [
              _buildFirstCard(),
              _buildSecondCard(),
            ],
          ),
          _buildButtons(),
        ],
      ),
    );
  }
}
