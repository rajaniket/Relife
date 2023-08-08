import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getsocial_flutter_sdk/communities/activity.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/model/service%20model/others_profile_model.dart';
import 'package:relife/providers/others_profile_provider.dart';
import 'package:relife/providers/post_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/post_full_view__page/post_page.dart';
import 'package:relife/ui/pages/profile/other_user_profile.dart';
import 'package:relife/ui/pages/profile/profile_page.dart';
import 'package:relife/ui/widgets/journal_widget_shimmer.dart';
import 'package:relife/ui/widgets/post_shimmer.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:shimmer/shimmer.dart';

class JournalPostWidget extends StatefulWidget {
  final String postId;
  final int postIndex;
  final bool isGroup;

  const JournalPostWidget(
      {Key? key,
      required this.postId,
      required this.postIndex,
      this.isGroup = false})
      : super(key: key);

  @override
  State<JournalPostWidget> createState() => _JournalPostWidgetState();
}

class _JournalPostWidgetState extends State<JournalPostWidget>
    with AutomaticKeepAliveClientMixin {
  late bool _isLikedByMe;
  late String _personName;
  String? _personRankTitle;
  String? _profileImageUrl;
  late String _numberOfLikes;
  late String _numOfComments;
  String? _message;
  String? _postImageUrl;
  late String _postId;
  List<GetSocialActivity>? _postCommentsList;
  late GetSocialActivity _activity;
  bool _isLoading = true;
  String? _topic = "";
  int? _ranking;
  String? _relifeUserId; // from our backend
  String? currentStreak;
  DateTime? postedAt;
  bool showRankShimmer = true;

  _loadData() async {
    _postId = widget.postId;

    await Future.wait(
      [
        Provider.of<DetailedPostProvider>(context, listen: false)
            .loadDetailedPosTById(_postId)
            .then((result) {
          _activity = result;
        }),
        Provider.of<DetailedPostProvider>(context, listen: false)
            .loadAllComments(_postId)
            .then((value) {
          _postCommentsList = value;
        }),
      ],
    );

    // _personRankTitle =
    //     await Provider.of<DetailedPostProvider>(context, listen: false)
    //         .loadRankingTitle();
    _personName = _activity.author.displayName;
    _profileImageUrl = _activity.author.avatarUrl ??
        'https://p.kindpng.com/picc/s/24-248549_vector-graphics-computer-icons-clip-art-user-profile.png';
    _numberOfLikes = _activity.reactionsCount["like"].toString() == 'null'
        ? '0'
        : _activity.reactionsCount["like"].toString();
    _numOfComments = _activity.commentsCount.toString();
    _message = _activity.text;
    _postImageUrl = _activity.attachments.isNotEmpty
        ? _activity.attachments[0].imageUrl
        : null;
    _isLikedByMe = _activity.myReactions.contains('like');
    _isLoading = false;
    _topic = _activity.source.title;
    //  _relifeUserId = _activity.author.identities["relife_userId"]!;
    postedAt = DateTime.fromMillisecondsSinceEpoch(_activity.createdAt * 1000);

    if (_activity.properties.isNotEmpty) {
      currentStreak = _activity.properties["streak"];
    }

    getRankTitle();

    setState(() {});
    return true;
  }

  getRankTitle() async {
    if (_activity.author.identities["relife_userId"] != null) {
      // relife_userId is null for relife_app or if posted from dashboard
      _relifeUserId = _activity.author.identities["relife_userId"]!;
      await Provider.of<OthersProfileProvider>(context, listen: false)
          .getProfile(_relifeUserId!);

      OthersProfileModel? othersProfileModel =
          Provider.of<OthersProfileProvider>(context, listen: false)
              .othersProfileModel;
      if (othersProfileModel != null) {
        for (int i = 0; i < othersProfileModel.details.habits.length; i++) {
          if (othersProfileModel.details.habits[i].habitDetails.name ==
              _topic) {
            _ranking = othersProfileModel
                .details.habits[i].habitDetails.leaderboardRank;
            break;
          }
        }
      }

      _personRankTitle =
          _ranking == null ? null : "rank $_ranking in $_topic this month";
    }
    setState(() {
      showRankShimmer = false;
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    // isLiked ==> means state before button is pressed
    if (!isLiked) {
      Provider.of<DetailedPostProvider>(context, listen: false)
          .setReaction(widget.postId);
      _isLikedByMe = true;
      _numberOfLikes = (int.parse(_numberOfLikes) + 1).toString();
    } else {
      Provider.of<DetailedPostProvider>(context, listen: false)
          .removeReaction(widget.postId);
      _isLikedByMe = false;
      _numberOfLikes = (int.parse(_numberOfLikes) - 1).toString();
    }
    // log(_isLikedByMe.toString());
    // log((!isLiked).toString());
    // log("_______------_---_-_--");
    return !isLiked;
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        // child: FutureBuilder(
        //     future: _loadData(),
        //     builder: (context, snap) {
        child: _isLoading
            ? const Padding(
                padding: EdgeInsets.all(6.0),
                child: SizedBox(height: 380, child: JournalPostWidgetShimmer()),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PostFullViewPage(
                            personName: _personName,
                            personRank: _personRankTitle,
                            message: _message,
                            numberOfLikes: _numberOfLikes,
                            numOfComments: _numOfComments,
                            profileImageUrl: _profileImageUrl,
                            postImageUrl: _postImageUrl,
                            postId: _postId,
                            postIndex: widget.postIndex,
                            isLikedByMe: _isLikedByMe,
                            alertAboutLikesAndCommentsChanges: (numOfLikes,
                                isLiked, numOfComments, commentList) {
                              _numberOfLikes = numOfLikes;
                              _numOfComments = numOfComments;
                              _isLikedByMe = isLiked;
                              _postCommentsList = commentList;

                              if (mounted) {
                                setState(() {});
                              }
                            },
                          )));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 43,
                      height: 50,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            postedAt!.day.toString(),
                            style: const TextStyle(
                              height: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat.MMM().format(postedAt!).toLowerCase(),
                            style: const TextStyle(
                              height: 1,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xffF08A5D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: widget.isGroup
                                  ? Colors.transparent
                                  : Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(child: _buildProfileRow()),
                                const SizedBox(
                                  height: 12.65,
                                ),
                                if (_message != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: _buildPostMessage(),
                                  ),
                                if (_postImageUrl != null)
                                  const SizedBox(
                                    height: 8.4,
                                  ),
                                if (_postImageUrl != null)
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24.0),
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: CachedNetworkImage(
                                          imageUrl: _postImageUrl!,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Center(
                                              // child: CircularProgressIndicator(
                                              //   color: ,
                                              //     value: downloadProgress.progress),
                                              child: Lottie.asset(
                                                'assets/lottie/round loader.json',
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20.0,
                                ),

                                // like Row
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // StatefulBuilder(builder: (context, customSetState) {
                                      //   return Row(
                                      //     mainAxisAlignment: MainAxisAlignment.start,
                                      //     children: [
                                      //       IconButton(
                                      //         onPressed: () {
                                      //           customSetState(() {
                                      //             _isLikedByMe =
                                      //                 _isLikedByMe ? false : true;
                                      //           });
                                      //           if (_isLikedByMe) {
                                      //             Provider.of<DetailedPostProvider>(
                                      //                     context,
                                      //                     listen: false)
                                      //                 .setReaction(widget.postId);
                                      //             _numberOfLikes =
                                      //                 (int.parse(_numberOfLikes) + 1)
                                      //                     .toString();
                                      //           } else {
                                      //             Provider.of<DetailedPostProvider>(
                                      //                     context,
                                      //                     listen: false)
                                      //                 .removeReaction(widget.postId);
                                      //             _numberOfLikes =
                                      //                 (int.parse(_numberOfLikes) - 1)
                                      //                     .toString();
                                      //           }
                                      //         },
                                      //         padding: EdgeInsets.only(right: 4.w),
                                      //         constraints:
                                      //             const BoxConstraints(), //to remove the padding
                                      //         icon: _isLikedByMe
                                      //             ? SvgPicture.asset(
                                      //                 AppAssets.heartFilled,
                                      //                 height: 22.54.h,
                                      //               )
                                      //             : SvgPicture.asset(
                                      //                 AppAssets.heart,
                                      //                 height: 22.54.h,
                                      //               ),
                                      //       ),
                                      //       Text(
                                      //         _numberOfLikes,
                                      //         style: TextStyle(
                                      //           fontSize: 12.sp,
                                      //           fontWeight: FontWeight.w400,
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         width: 6.25.w,
                                      //       ),
                                      //       Padding(
                                      //         padding: EdgeInsets.only(right: 4.w),
                                      //         child: SvgPicture.asset(
                                      //           AppAssets.comment,
                                      //           height: 22.54.h,
                                      //         ),
                                      //       ),
                                      //       Text(
                                      //         _numOfComments,
                                      //         style: TextStyle(
                                      //           fontSize: 12.sp,
                                      //           fontWeight: FontWeight.w400,
                                      //         ),
                                      //       )
                                      //     ],
                                      //   );
                                      // }),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          LikeButton(
                                            size: 22.54,
                                            circleColor: const CircleColor(
                                                start: Color(0xffF08A5D),
                                                end: Color(0xffF08A5D)),
                                            likeBuilder: (bool isLiked) {
                                              return isLiked
                                                  ? SvgPicture.asset(
                                                      AppAssets.heartFilled,
                                                      height: 22.54,
                                                    )
                                                  : SvgPicture.asset(
                                                      AppAssets.heart,
                                                      height: 22.54,
                                                    );
                                            },
                                            isLiked: _isLikedByMe,
                                            likeCount:
                                                int.parse(_numberOfLikes),
                                            likeCountPadding:
                                                const EdgeInsets.only(left: 4),
                                            countBuilder:
                                                (count, isLiked, text) {
                                              return Text(
                                                text,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              );
                                            },
                                            onTap: onLikeButtonTapped,
                                          ),
                                          const SizedBox(
                                            width: 6.25,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 4),
                                            child: SvgPicture.asset(
                                              AppAssets.comment,
                                              height: 22.54,
                                            ),
                                          ),
                                          Text(
                                            _numOfComments,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),

                                      // IconButton(
                                      //   onPressed: () {},
                                      //   padding: EdgeInsets.only(right: 4.w),
                                      //   constraints:
                                      //       const BoxConstraints(), //to remove the padding
                                      //   icon: SvgPicture.asset(
                                      //     AppAssets.shareIcon,
                                      //     height: 22.54.h,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 17.0,
                                ),
                                // comment row
                                _numOfComments == '0'
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: const Color(
                                                        0xffFA8A3C)),
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipOval(
                                                child: SizedBox(
                                                  height: 19.25,
                                                  width: 19.25,
                                                  child: Image.network(
                                                    _postCommentsList![0]
                                                                .author
                                                                .avatarUrl ==
                                                            null
                                                        ? _profileImageUrl! +
                                                            "?v=${DateTime.now().millisecondsSinceEpoch}"
                                                        : _postCommentsList![0]
                                                                .author
                                                                .avatarUrl! +
                                                            "?v=${DateTime.now().millisecondsSinceEpoch}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6.75,
                                            ),
                                            Flexible(
                                              child: RichText(
                                                  text: TextSpan(
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins'),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${_postCommentsList![0].author.displayName} ",
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: _postCommentsList![0]
                                                        .text,
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            )
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          ),
                          if (currentStreak != null && currentStreak != "")
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF08A5D)
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          // widget.personRank,
                                          currentStreak!,
                                          style: const TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff062540)),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: SvgPicture.asset(
                                              AppAssets.fireIcon,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              )
        //   } else if (snap.hasError) {
        //     return Center(child: Text(snap.error.toString()));
        //   } else {
        //   return Container(
        //       padding: EdgeInsets.all(14.r),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(24.0.r),
        //         color: Colors.white,
        //       ),
        //       child: const Center(child: CircularProgressIndicator()));
        // }
        // }),
        );
  }

  _buildPostMessage() {
    // return Text(
    //   _message!,
    //   style: const TextStyle(
    //     fontSize: 12,
    //     fontWeight: FontWeight.w400,
    //   ),
    // );
    return ExpandableText(
      _message!,
      expandText: "see more",
      collapseText: "See Less",
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      urlStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.blue,
      ),
      linkStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xffF08A5D),
      ),
      mentionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      onMentionTap: (data) {
        print("_____________________-- $data");
        print(_activity.mentions);
      },
      maxLines: 8,
      onUrlTap: (link) async {
        String url = link;
        bool isEmail = link.contains("@");
        if (!isEmail) {
          if (!Uri.parse(url).hasScheme) {
            url = "http://" + link;
          }
        }
        bool _validURL = Uri.parse(url).isAbsolute;
        if (isEmail) {
        } else if (_validURL) {
          try {
            await launch(
              url,
              customTabsOption: const CustomTabsOption(
                toolbarColor: Color(0xffF7F6F2),
                enableDefaultShare: true,
                enableUrlBarHiding: true,
                showPageTitle: true,
                extraCustomTabs: <String>[
                  // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
                  'org.mozilla.firefox',
                  // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
                  'com.microsoft.emmx',
                ],
              ),
            );
          } catch (e) {
            // rethrow;
          }
        }
      },
    );
  }

  _buildProfileRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  if (_relifeUserId != null) {
                    final personalProfile =
                        Provider.of<ProfileProvider>(context, listen: false);
                    if (_relifeUserId == personalProfile.userId) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const ProfilePage();
                      }));
                    } else {
                      final otherProfile = Provider.of<OthersProfileProvider>(
                          context,
                          listen: false);
                      CustomProgressIndicator().buildShowDialog(context);
                      await otherProfile.getProfile(_relifeUserId!);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return OtherProfilePage(id: _relifeUserId!);
                      }));
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 2, color: const Color(0xffFA8A3C)),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      height: 48.0,
                      width: 48.0,
                      child:

                          // : CachedNetworkImage(
                          //     key: UniqueKey(),
                          //     // widget.profileImageUrl,
                          //     imageUrl: _profileImageUrl!,
                          //     // progressIndicatorBuilder:
                          //     //     (context, url, downloadProgress) => Center(
                          //     //   child: CircularProgressIndicator(
                          //     //       value: downloadProgress.progress),
                          //     // ),
                          //     errorWidget: (context, url, error) =>
                          //         const Icon(Icons.error),
                          //     fit: BoxFit.cover,
                          //   ),
                          Image.network(
                        _profileImageUrl! +
                            "?v=${DateTime.now().millisecondsSinceEpoch}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_relifeUserId != null) {
                          final personalProfile = Provider.of<ProfileProvider>(
                              context,
                              listen: false);
                          if (_relifeUserId == personalProfile.userId) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const ProfilePage();
                            }));
                          } else {
                            final otherProfile =
                                Provider.of<OthersProfileProvider>(context,
                                    listen: false);
                            CustomProgressIndicator().buildShowDialog(context);
                            await otherProfile.getProfile(_relifeUserId!);
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return OtherProfilePage(id: _relifeUserId!);
                            }));
                          }
                        }
                      },
                      child: Text(
                        // widget.personName,
                        _personName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff062540),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 00),
                      child: _personRankTitle != null
                          ? Text(
                              // widget.personRank,
                              _personRankTitle!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff062540)),
                            )
                          : Visibility(
                              visible: _activity
                                      .author.identities["relife_userId"] !=
                                  null,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 5),
                                child: Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 241, 240, 240),
                                  highlightColor:
                                      const Color.fromARGB(255, 252, 249, 249),
                                  enabled: true,
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        // if (!widget.isGroup)
        //   IconButton(
        //     onPressed: () {},
        //     splashRadius: 20.sp,
        //     splashColor: Colors.black,
        //     constraints: const BoxConstraints(),
        //     icon: RotatedBox(
        //       quarterTurns: 1,
        //       child: SvgPicture.asset(
        //         AppAssets.seeMoreIcon,
        //         height: 20.sp,
        //         color: const Color(0xff062540),
        //       ),
        //     ),
        //   )
      ],
    );
  }

  // Row _buildLikeRow() {
  //   return
  // }

  // _buildCommentRow() {
  //   return
  // }

  @override
  bool get wantKeepAlive => true;
}
