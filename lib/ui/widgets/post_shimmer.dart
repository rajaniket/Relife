import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostWidgetShimmer extends StatefulWidget {
  const PostWidgetShimmer({Key? key}) : super(key: key);

  @override
  _PostWidgetShimmerState createState() => _PostWidgetShimmerState();
}

class _PostWidgetShimmerState extends State<PostWidgetShimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        child: Column(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: const Color(0xffe0e0e0),
              highlightColor: const Color(0xfff5f5f5),
              enabled: true,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 48.r,
                          height: 48.r,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 50.w,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 5.r, left: 25.w, right: 100.w),
                    child: Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.r, left: 25.w, right: 50.w),
                    child: Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
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
