import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdsViewLoading extends StatelessWidget {
  const AdsViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  height: 175,
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                  autoPlay: false,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                ),
                items: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                ],
              ),
    );
  }
}