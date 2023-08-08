import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:getsocial_flutter_sdk/communities/activity.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/explore_tab_data_provider.dart';
import 'package:relife/providers/post_create_provider.dart';
import 'package:relife/providers/post_provider.dart';
import 'package:relife/services/GetSocial/group_services.dart';
import 'package:relife/services/localFileAccess/local_file_services.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/post_widget.dart';

class GroupFeedPage extends StatefulWidget {
  final String groupname;
  final String groupId;
  final Function updateExploreTab;
  const GroupFeedPage(
      {Key? key,
      required this.groupname,
      required this.groupId,
      required this.updateExploreTab})
      : super(key: key);

  @override
  _GroupFeedPageState createState() => _GroupFeedPageState();
}

class _GroupFeedPageState extends State<GroupFeedPage> {
  final _controller = TextEditingController();
  String? _typedText = "";
  late String groupname;

  attachImage() async {
    final image = await LocalFileServices().pickImageFromGallary();
    Provider.of<PostCreateProvider>(context, listen: false).setImagePath(image);
  }

  leaveGroup() async {
    try {
      await GroupServices()
          .removeMemberFromGroup(
            groupId: widget.groupId,
          )
          .then((value) => null);

      await Future.delayed(const Duration(seconds: 1));
      widget.updateExploreTab();
      Navigator.pop(context);
      // Navigator.pop(context);
    } catch (e) {}
  }

  onShare() async {
    bool? result;
    result = await Provider.of<PostCreateProvider>(context, listen: false)
        .sharePost(isThisGroup: true, feedId: widget.groupId);
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('your post was shared'),
          backgroundColor: Color(0xffDF532B),
          duration: Duration(milliseconds: 350),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('your post could not be shared'),
          backgroundColor: Color(0xffDF532B),
          duration: Duration(milliseconds: 350),
        ),
      );
    }
    _typedText = '';
  }

  @override
  void initState() {
    groupname = widget.groupname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Provider.of<PostCreateProvider>(context, listen: false).imagePath !=
            null) {
          Provider.of<PostCreateProvider>(context, listen: false)
              .setImagePath(null);
          return false;
        } else {
          widget.updateExploreTab();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF7F6F2),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 44.0.h, bottom: 44.h),
              child: Column(
                children: [
                  // _buildBackButtonAndTitle(context),
                  Container(
                    color: const Color(0xffF7F6F2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RoundBackButton(
                              onPressed: () {
                                widget.updateExploreTab();
                                Navigator.pop(context);
                              },
                              backgroundColour: Colors.white,
                            ),
                            Text(
                              groupname,
                              style: TextStyle(
                                  fontSize:
                                      ViewHabitScreenTextStyle.headingSize,
                                  fontWeight:
                                      ViewHabitScreenTextStyle.headingWeight,
                                  color: const Color(0xff062540)),
                            ),
                          ],
                        ),
                        Provider.of<PostCreateProvider>(context, listen: true)
                                    .imagePath !=
                                null
                            ? GestureDetector(
                                onTap: () {
                                  Provider.of<PostCreateProvider>(context,
                                          listen: false)
                                      .setImagePath(null);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 21.0),
                                  // child: Icon(
                                  //   Icons.cancel_outlined,
                                  //   size: 30,
                                  //   color: Color(0xff062540),
                                  // ),
                                  child: SvgPicture.asset(
                                    AppAssets.crossIcon,
                                    height: 19,
                                    color: const Color(0xff062540),
                                  ),
                                ))
                            : PopupMenuButton(
                                icon: const Icon(Icons
                                    .more_vert_rounded), //don't specify icon if you want 3 dot menu
                                color: Colors.white,

                                itemBuilder: (context) => [
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Center(
                                      child: Text(
                                        "leave",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                                onSelected: (item) => {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('confirm exit..!!!'),
                                        content: Text(
                                            'are you sure, you want to exit "${widget.groupname}" group?.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              leaveGroup();

                                              Navigator.pop(
                                                  context); // for popupmenu button
                                              Navigator.pop(
                                                  context); // for alert dialog
                                            },
                                            child: const Text('exit'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                },
                              ),
                        // IconButton(
                        //   onPressed: ()  {
                        //
                        //   },
                        //   splashRadius: 20.sp,
                        //   constraints: const BoxConstraints(),
                        //   padding: EdgeInsets.all(15.r),
                        //   icon: RotatedBox(
                        //     quarterTurns: 1,
                        //     child: SvgPicture.asset(
                        //       AppAssets.seeMoreIcon,
                        //       height: 20.sp,
                        //       color: const Color(0xff062540),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          _BuildPost(
                            groupId: widget.groupId,
                          ),
                          if (Provider.of<PostCreateProvider>(context,
                                      listen: true)
                                  .imagePath !=
                              null)
                            Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              padding: EdgeInsets.all(30.r),
                              color: const Color(0xffF7F6F2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Image.file(
                                  Provider.of<PostCreateProvider>(context,
                                          listen: true)
                                      .imagePath!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15.r))),
                padding: EdgeInsets.only(left: 11.w, bottom: 12.h, top: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTextField(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 12.w),
                      child: GestureDetector(
                          onTap: () {
                            attachImage()();
                          },
                          child: SvgPicture.asset(AppAssets.gallaryIcon)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            onShare();
                            _controller.clear();
                          },
                          child: SvgPicture.asset(AppAssets.postIcon)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildBackButtonAndTitle(
  //   BuildContext context,
  // ) {
  //   return Container(
  //     color: const Color(0xffF7F6F2),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           children: [
  //             RoundBackButton(
  //               onPressed: () {
  //                 widget.updateExploreTab();
  //                 Navigator.pop(context);
  //               },
  //               backgroundColour: Colors.white,
  //             ),
  //             Text(
  //               groupname,
  //               style: TextStyle(
  //                   fontSize: ViewHabitScreenTextStyle.headingSize,
  //                   fontWeight: ViewHabitScreenTextStyle.headingWeight,
  //                   color: const Color(0xff062540)),
  //             ),
  //           ],
  //         ),
  //         Provider.of<PostCreateProvider>(context, listen: true).imagePath !=
  //                 null
  //             ? GestureDetector(
  //                 onTap: () {
  //                   Provider.of<PostCreateProvider>(context, listen: false)
  //                       .setImagePath(null);
  //                 },
  //                 child: Padding(
  //                   padding: EdgeInsets.only(right: 21.0),
  //                   // child: Icon(
  //                   //   Icons.cancel_outlined,
  //                   //   size: 30,
  //                   //   color: Color(0xff062540),
  //                   // ),
  //                   child: SvgPicture.asset(
  //                     AppAssets.crossIcon,
  //                     height: 19,
  //                     color: const Color(0xff062540),
  //                   ),
  //                 ))
  //             : PopupMenuButton(
  //                 icon: const Icon(Icons
  //                     .more_vert_rounded), //don't specify icon if you want 3 dot menu
  //                 color: Colors.white,

  //                 itemBuilder: (context) => [
  //                   PopupMenuItem<int>(
  //                     value: 0,
  //                     child: Center(
  //                       child: Text(
  //                         "leave",
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 17.sp,
  //                             fontWeight: FontWeight.w500),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //                 onSelected: (item) => {
  //                   showDialog(
  //                     context: context,
  //                     builder: (Context) {
  //                       return AlertDialog(
  //                         title: const Text('confirm exit..!!!'),
  //                         content: Text(
  //                             'are you sure, you want to exit "${widget.groupname}" group?.'),
  //                         actions: [
  //                           TextButton(
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                             },
  //                             child: const Text('cancel'),
  //                           ),
  //                           TextButton(
  //                             onPressed: () {
  //                               leaveGroup();
  //                               print("nnnnnnnnnnnnnnn");
  //                               Navigator.pop(context); // for popupmenu button
  //                               Navigator.pop(context); // for alert dialog
  //                             },
  //                             child: const Text('exit'),
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                   ),
  //                 },
  //               ),
  //         // IconButton(
  //         //   onPressed: ()  {
  //         //
  //         //   },
  //         //   splashRadius: 20.sp,
  //         //   constraints: const BoxConstraints(),
  //         //   padding: EdgeInsets.all(15.r),
  //         //   icon: RotatedBox(
  //         //     quarterTurns: 1,
  //         //     child: SvgPicture.asset(
  //         //       AppAssets.seeMoreIcon,
  //         //       height: 20.sp,
  //         //       color: const Color(0xff062540),
  //         //     ),
  //         //   ),
  //         // )
  //       ],
  //     ),
  //   );
  // }

  TextField _buildTextField() {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      onChanged: (val) {
        _typedText = val.trim();
        if (_typedText != "") {
          Provider.of<PostCreateProvider>(context, listen: false)
              .setText(_typedText);
        }
      },
      decoration: InputDecoration(
        hintText: 'type a message',
        hintStyle: TextStyle(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.only(
            left: 16.0.w, right: 16.0.w, top: 10.0.h, bottom: 9.0.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.bottomSheetTextFieldColor,
      ),
    );
  }
}

class _BuildPost extends StatefulWidget {
  final String groupId;
  const _BuildPost({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  __BuildPostState createState() => __BuildPostState();
}

class __BuildPostState extends State<_BuildPost> {
  List<GetSocialActivity>? userPostList;

  Future loadFeedsData() async {
    userPostList = await Provider.of<AllPostsProvider>(context, listen: false)
        .loadAllPosts(isThisGroup: true, feedId: widget.groupId);
    int count = userPostList != null ? userPostList!.length : 0;

    Provider.of<ExploreTabDataProvider>(context, listen: false)
        .updateSeenPost(widget.groupId, count);

    return true;
    //await widget.snapshot.loadAllPosts();
  }

  Future<void> onRefresh() async {
    await loadFeedsData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
          future: loadFeedsData(),
          builder: (context, snap) {
            if (snap.hasData) {
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  key: UniqueKey(),
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: userPostList!.length,
                  reverse: true,
                  shrinkWrap: false,
                  itemBuilder: (context, index) => PostWidget(
                    postId: userPostList![index].id,
                    postIndex: index,
                    isGroup: true,
                  ),
                ),
              );
            } else if (snap.hasError) {
              return Center(child: Text(snap.error.toString()));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
