import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/explore_tab_data_provider.dart';
import 'package:relife/services/GetSocial/group_services.dart';
import 'package:relife/ui/pages/groups_feed/group_feed_page.dart';

class YourGroupContainerWidget extends StatefulWidget {
  final String groupTitle, groupDescription, image, groupId;
  final Function updateExploreTab;
  final bool alreadyAMember;
  const YourGroupContainerWidget(
      {Key? key,
      required this.groupTitle,
      required this.groupDescription,
      required this.image,
      required this.updateExploreTab,
      required this.alreadyAMember,
      required this.groupId})
      : super(key: key);

  @override
  State<YourGroupContainerWidget> createState() =>
      _YourGroupContainerWidgetState();
}

class _YourGroupContainerWidgetState extends State<YourGroupContainerWidget> {
  late bool alreadyAMember;
  String count = "";
  Timer? timer;

  updateCount() async {
    var data = await Provider.of<ExploreTabDataProvider>(context, listen: false)
        .updateUnseenPostCount(widget.groupId);
    count = data <= 12 ? data.toString() : "12+";
    setState(() {});
  }

  joinGroup() async {
    await GroupServices().joinGroup(groupId: widget.groupId);
    alreadyAMember = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));
    widget.updateExploreTab();
  }

  @override
  void initState() {
    alreadyAMember = widget.alreadyAMember;
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      // updateCount();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (alreadyAMember) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupFeedPage(
                        groupname: widget.groupTitle,
                        groupId: widget.groupId,
                        updateExploreTab: widget.updateExploreTab,
                      )));
        }
      },
      child: Container(
        width: 332.17.w,
        height: 80.0.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0.r), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.fromLTRB(28.0.w, 6.0.h, 20.0.w, 6.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.groupTitle,
                      style: TextStyle(
                          fontSize: ExploreTabScreenTextStyle.subHeadingSize,
                          fontWeight:
                              ExploreTabScreenTextStyle.subHeadingWeight,
                          color: AppColors.defaultTextColor)),
                  Text('${widget.groupDescription} ',
                      style: TextStyle(
                          fontSize: ExploreTabScreenTextStyle.paragraphSize,
                          fontWeight:
                              ExploreTabScreenTextStyle.paragraphWeight300,
                          color: Colors.black))
                ],
              ),
              // SizedBox(
              //   child: SvgPicture.asset(
              //     image,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              !alreadyAMember
                  ? TextButton(
                      onPressed: () {
                        joinGroup();
                      },
                      child: Text(
                        'join',
                        style: TextStyle(
                            color: const Color(0xffFA8A3C), fontSize: 18.sp),
                      ))
                  : Container(
                      // height: 36.r,
                      // width: 36.r,
                      // decoration: const BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     gradient: LinearGradient(
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //         colors: [Color(0xffFB923C), Color(0xffFFC738)])),
                      // child: Center(
                      //     child: Text(
                      //   count,
                      //   style: TextStyle(
                      //       fontSize: 14.sp, fontWeight: FontWeight.w500),
                      // )),
                      )
            ],
          ),
        ),
      ),
    );
  }
}
