import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/stylePages/app_colors.dart';

class ImagePlaceCardWidget extends StatefulWidget {
  final String firstImagePlace;

  const ImagePlaceCardWidget({
    Key? key,
    required this.firstImagePlace,
  }) : super(key: key);

  @override
  State<ImagePlaceCardWidget> createState() => _ImagePlaceCardWidgetState();
}

class _ImagePlaceCardWidgetState extends State<ImagePlaceCardWidget> {
  @override
  Widget build(BuildContext context) {
    return LazyLoadingList(
      initialSizeOfItems: 2,
      index: 0,
      loadMore: () {},
      hasMore: false,
      child: Container(
        height: 20.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.transparentColor,
          borderRadius: BorderRadius.circular(2.h),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: MemoryImage(
              base64Decode(widget.firstImagePlace),
            ),
          ),
        ),
      ),
    );
  }
}
