import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getsocial_flutter_sdk/communities/activity.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/providers/post_create_provider.dart';
import 'package:relife/providers/post_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/profile/profile_page.dart';
import 'package:relife/ui/widgets/post_widget.dart';

class HomeTabScreen extends StatefulWidget {
  HomeTabScreen({
    Key? key,
    //required this.homeScrollController
  }) : super(key: key);
  // ScrollController homeScrollController;
  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, _) {
          return [
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color(0xffF7F6F2),

                statusBarIconBrightness:
                    Brightness.dark, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: const Color(0xffF7F6F2),
              elevation: 0,
              toolbarHeight: 60.h,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.relifeLogo,
                    height: 38.45.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        // IconButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => const MessagePage()));
                        //   },
                        //   icon: SvgPicture.asset(
                        //     AppAssets.chatIcon,
                        //     height: 30.h,
                        //     color: const Color(0xff062540),
                        //   ),
                        //   splashRadius: 25.r,
                        // ),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        Consumer<ProfileProvider>(
                            builder: (context, profile, child) {
                          return IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfilePage()));
                            },
                            icon: SizedBox(
                              height: 30.r,
                              width: 30.r,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.r,
                                      color: const Color(0xffFA8A3C)),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://relife.co.in/api/${profile.profilePicture}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            splashRadius: 25.r,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              titleSpacing: 25.w,
              automaticallyImplyLeading: false,
            ),
          ];
        },
        floatHeaderSlivers: true,
        body: Padding(
          padding: EdgeInsets.only(top: 1.h, left: 10.w, right: 10.w),
          child: _BuildPost(
              // homeScrollController: widget.homeScrollController,
              ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _BuildPost extends StatefulWidget {
  // final AllPostsProvider snapshot;
  _BuildPost({
    Key? key,
    // required this.homeScrollController,
  }) : super(key: key);

  //ScrollController homeScrollController;

  @override
  __BuildPostState createState() => __BuildPostState();
}

class __BuildPostState extends State<_BuildPost>
    with AutomaticKeepAliveClientMixin {
  List<GetSocialActivity>? userPostList;

  Future loadFeedsData() async {
    userPostList = await Provider.of<AllPostsProvider>(context, listen: false)
        .loadAllPosts();
    return true;
    //await widget.snapshot.loadAllPosts();
  }

  Future<void> _onRefresh() async {
    userPostList = await Provider.of<AllPostsProvider>(context, listen: false)
        .loadAllPosts();
    await Future.delayed(const Duration(seconds: 1));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        backgroundColor: Colors.white,
        edgeOffset: 0,
        color: const Color(0xffFA8A3C),
        child: Consumer<PostCreateProvider>(builder: (context, snap, _) {
          return FutureBuilder(
              future: loadFeedsData(),
              builder: (context, snap) {
                if (snap.hasData || userPostList != null) {
                  return NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: ListView.builder(
                        //  controller: widget.homeScrollController,
                        padding: EdgeInsets.zero,
                        key:
                            UniqueKey(), // key is important as it will update data if key is different
                        physics: const ClampingScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount: userPostList!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return PostWidget(
                            postId: userPostList![index].id,
                            postIndex: index,
                          );
                        }
                        // itemBuilder: (context, index) =>
                        //     Center(child: Text(userPostList![index].id)),
                        ),
                  );
                } else if (snap.hasError) {
                  return Center(child: Text(snap.error.toString()));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// // sliver app bar

// // Scaffold(
// //       backgroundColor: const Color(0xffF7F6F2),
// //       body: CustomScrollView(
// //         slivers: [
// //           SliverAppBar(
// //             snap: true,
// //             floating: true, // it should be true
// //             backgroundColor: const Color(0xffF7F6F2),

// //             // leading: Padding(
// //             //   padding: const EdgeInsets.only(left: 30.72),
// //             //   child: SvgPicture.asset(AppAssets.relifeLogo),
// //             // ),
// //             // actions: [SvgPicture.asset(AppAssets.relifeLogo)],
// //             title: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 SvgPicture.asset(
// //                   AppAssets.relifeLogo,
// //                   height: 38.45.h,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SliverList(
// //             delegate: SliverChildBuilderDelegate(
// //               (context, index) => Padding(
// //                 padding: const EdgeInsets.all(18.0),
// //                 child: Container(
// //                   height: 20,
// //                   color: Colors.grey,
// //                   child: Text('$index'),
// //                 ),
// //               ),
// //               childCount: 51,
// //             ), //SliverChildBuildDelegate
// //           ) //Sl
// //         ],
// //       ),
// //     );

// class HomeTabScreen extends StatefulWidget {
//   HomeTabScreen({
//     Key? key,
//     //required this.homeScrollController
//   }) : super(key: key);
//   // ScrollController homeScrollController;
//   @override
//   State<HomeTabScreen> createState() => _HomeTabScreenState();
// }

// class _HomeTabScreenState extends State<HomeTabScreen>
//     with AutomaticKeepAliveClientMixin {
//   List<GetSocialActivity> userPostList = [];
//   ValueNotifier<bool> isAllPostLoaded = ValueNotifier(false);
//   int pageCount = 0;
//   var query = ActivitiesQuery.inAllTopics(); // Create query
//   late PagingQuery<ActivitiesQuery> pagingQuery;
//   final scrollController = ScrollController();
//   PagingResult<GetSocialActivity>? result;

//   Future loadFeedsData() async {
//     userPostList = await Provider.of<AllPostsProvider>(context, listen: false)
//         .loadAllPosts();
//     return true;
//     //await widget.snapshot.loadAllPosts();
//   }

//   Future<void> _onRefresh() async {
//     // userPostList = await Provider.of<AllPostsProvider>(context, listen: false)
//     //     .loadAllPosts();
//     await Future.delayed(const Duration(seconds: 1));
//     userPostList = [];
//     isAllPostLoaded.value = false;
//     pagingQuery = PagingQuery(query);
//     pagingQuery.limit = 10;
//     pageCount = 0;

//     setState(() {});
//   }

//   Future<List<GetSocialActivity>> getPosts() async {
//     // var query = ActivitiesQuery.inAllTopics(); // Create query
//     // var pagingQuery = PagingQuery(query);
//     pagingQuery.limit = 10;
//     List<GetSocialActivity> tempPostList = [];
//     try {
//       var result = await Communities.getActivities(pagingQuery);
//       tempPostList = result.entries;
//       if (!isAllPostLoaded.value) {
//         pagingQuery.next = result.next;
//         pageCount = pageCount + 1;
//         userPostList.addAll(tempPostList);
//         if (result.next != "") {
//           isAllPostLoaded.value = false;
//         } else {
//           isAllPostLoaded.value = true;
//         }
//       }
//       return userPostList;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<List<GetSocialActivity>> getPost() async {
//     List<GetSocialActivity> tempPostList = [];
//     try {
//       result = await Communities.getActivities(pagingQuery);
//       tempPostList = result!.entries;
//       return tempPostList;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   loadMoreData(){

//   }

//   @override
//   void initState() {
//     scrollController.addListener(() {
//       if (scrollController.position.maxScrollExtent ==
//           scrollController.offset) {
//         if (!isAllPostLoaded.value) {
//           setState(() {
//             print("____________________________________ ___ _ _ ");
//           });
//         }
//       }
//     });
//     pagingQuery = PagingQuery(query);
//     pagingQuery.limit = 10;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Scaffold(
//       backgroundColor: const Color(0xffF7F6F2),
//       body: NestedScrollView(
//           physics: const ClampingScrollPhysics(),
//           headerSliverBuilder: (BuildContext context, _) {
//             return [
//               SliverAppBar(
//                 systemOverlayStyle: const SystemUiOverlayStyle(
//                   statusBarColor: Color(0xffF7F6F2),

//                   statusBarIconBrightness:
//                       Brightness.dark, // For Android (dark icons)
//                   statusBarBrightness: Brightness.light, // For iOS (dark icons)
//                 ),
//                 floating: true,
//                 pinned: false,
//                 snap: true,
//                 backgroundColor: const Color(0xffF7F6F2),
//                 elevation: 0,
//                 toolbarHeight: 60,
//                 title: SvgPicture.asset(
//                   AppAssets.relifeLogo,
//                   height: 38.45,
//                 ),
//                 actions: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 12.0, right: 22),
//                     child: Consumer<ProfileProvider>(
//                         builder: (context, profile, child) {
//                       return IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const ProfilePage()));
//                         },
//                         icon: SizedBox(
//                           height: 30,
//                           width: 30,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 1.r, color: const Color(0xffFA8A3C)),
//                               shape: BoxShape.circle,
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               child: Image.network(
//                                 "https://relife.co.in/api/${profile.profilePicture}" +
//                                     "?v=${DateTime.now().millisecondsSinceEpoch}",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         splashRadius: 25,
//                       );
//                     }),
//                   ),
//                 ],
//                 titleSpacing: 25,
//                 automaticallyImplyLeading: false,
//               ),
//             ];
//           },
//           floatHeaderSlivers: true,
//           body: Padding(
//             padding: const EdgeInsets.only(top: 1, left: 10, right: 10),
//             child: RefreshIndicator(
//               onRefresh: _onRefresh,
//               backgroundColor: Colors.white,
//               edgeOffset: 0,
//               color: const Color(0xffFA8A3C),
//               child:
//                   Consumer<PostCreateProvider>(builder: (context, snapshot, _) {
//                 return FutureBuilder<List<GetSocialActivity>>(
//                     future: getPosts(),
//                     builder: (context, snap) {
//                       if (snap.hasData) {
//                         return NotificationListener< // for removing oversroll blue stretch mark on scroll
//                             OverscrollIndicatorNotification>(
//                           onNotification:
//                               (OverscrollIndicatorNotification overscroll) {
//                             overscroll.disallowIndicator();
//                             return false;
//                           },
//                           child: ListView.builder(
//                               //  controller: widget.homeScrollController,
//                               controller: scrollController,
//                               padding: EdgeInsets.zero,
//                               key:
//                                   UniqueKey(), // key is important as it will update data if key is different
//                               physics: const ClampingScrollPhysics(),
//                               addAutomaticKeepAlives: true,
//                               itemCount: userPostList.length + 1,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 return index < userPostList.length
//                                     ? PostWidget(
//                                         postId: userPostList[index].id,
//                                         postIndex: index,
//                                       )
//                                     : ValueListenableBuilder<bool>(
//                                         valueListenable: isAllPostLoaded,
//                                         builder: (context, val, _) {
//                                           return Visibility(
//                                             visible: !val,
//                                             child: const Padding(
//                                               padding: EdgeInsets.only(
//                                                   top: 10, bottom: 20),
//                                               child: Center(
//                                                 child: SizedBox(
//                                                   height: 20,
//                                                   width: 20,
//                                                   child:
//                                                       CircularProgressIndicator(
//                                                     strokeWidth: 3,
//                                                     color: Color(0xffFA8A3C),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         });
//                               }
//                               // itemBuilder: (context, index) =>
//                               //     Center(child: Text(userPostList![index].id)),
//                               ),
//                         );
//                       } else if (snap.hasError) {
//                         return Center(child: Text(snap.error.toString()));
//                       } else {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                     });
//               }),
//             ),
//           )),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class HomeTabScreen extends StatefulWidget {
//   HomeTabScreen({
//     Key? key,
//     //required this.homeScrollController
//   }) : super(key: key);
//   // ScrollController homeScrollController;
//   @override
//   State<HomeTabScreen> createState() => _HomeTabScreenState();
// }

// class _HomeTabScreenState extends State<HomeTabScreen>
//     with AutomaticKeepAliveClientMixin {
//   List<GetSocialActivity> userPostList = [];
//   ValueNotifier<bool> isAllPostLoaded = ValueNotifier(false);
//   int pageCount = 0;
//   var query = ActivitiesQuery.inAllTopics(); // Create query
//   late PagingQuery<ActivitiesQuery> pagingQuery;
//   final scrollController = ScrollController();
//   PagingResult<GetSocialActivity>? result;
//   final PagingController<int, GetSocialActivity> _pagingController =
//       PagingController(firstPageKey: 0);

//   Future loadFeedsData() async {
//     userPostList = await Provider.of<AllPostsProvider>(context, listen: false)
//         .loadAllPosts();
//     return true;
//     //await widget.snapshot.loadAllPosts();
//   }

//   Future<void> _onRefresh() async {
//     // userPostList = await Provider.of<AllPostsProvider>(context, listen: false)
//     //     .loadAllPosts();
//     await Future.delayed(const Duration(seconds: 1));
//     userPostList = [];
//     isAllPostLoaded.value = false;
//     pagingQuery = PagingQuery(query);
//     pagingQuery.limit = 10;
//     pageCount = 0;

//     setState(() {});
//   }

//   Future<List<GetSocialActivity>> getPosts() async {
//     // var query = ActivitiesQuery.inAllTopics(); // Create query
//     // var pagingQuery = PagingQuery(query);
//     pagingQuery.limit = 10;
//     List<GetSocialActivity> tempPostList = [];
//     try {
//       var result = await Communities.getActivities(pagingQuery);
//       tempPostList = result.entries;
//       if (!isAllPostLoaded.value) {
//         pagingQuery.next = result.next;
//         pageCount = pageCount + 1;
//         userPostList.addAll(tempPostList);
//         if (result.next != "") {
//           isAllPostLoaded.value = false;
//         } else {
//           isAllPostLoaded.value = true;
//         }
//       }
//       return userPostList;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<List<GetSocialActivity>> getPost() async {
//     List<GetSocialActivity> tempPostList = [];
//     try {
//       result = await Communities.getActivities(pagingQuery);
//       tempPostList = result!.entries;
//       return tempPostList;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   loadMoreData() async {
//     if (!isAllPostLoaded.value) {
//       await getPost();
//       pagingQuery.next = result!.next;
//       pagingQuery.limit = 10;
//       pageCount = pageCount + 1;
//       if (result!.next != "") {
//         isAllPostLoaded.value = false;
//       } else {
//         isAllPostLoaded.value = true;
//       }
//     }
//   }

//   bool loading = true;
//   @override
//   void initState() {
//     // scrollController.addListener(() {
//     //   if (scrollController.position.maxScrollExtent ==
//     //       scrollController.offset) {
//     //     if (!isAllPostLoaded.value) {
//     //       setState(() {
//     //         print("____________________________________ ___ _ _ ");
//     //       });
//     //     }
//     //   }
//     // });
//     log("__________________________________- pre");
//     _pagingController.addPageRequestListener((pageKey) {
//       log("__________________________________-");
//       _fetchPage();
//     });
//     pagingQuery = PagingQuery(query);
//     pagingQuery.limit = 10;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchPage() async {
//     log("_________________ _ _ _ _ _ _fetchPage");
//     try {
//       final result = await Communities.getActivities(pagingQuery);
//       final isLastPage = result.next == "" ? true : false;
//       if (isLastPage) {
//         _pagingController.appendLastPage(result.entries);
//       } else {
//         pageCount++;
//         pagingQuery.next = result.next;
//         _pagingController.appendPage(result.entries, pageCount);
//       }
//       loading = false;
//       log("_________________ _ _ _ _ _ $loading");
//       setState(() {});
//     } catch (error) {
//       log("_________________ _ _ _ _ _ $error");
//       _pagingController.error = error;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Scaffold(
//       backgroundColor: const Color(0xffF7F6F2),
//       body: NestedScrollView(
//           physics: const ClampingScrollPhysics(),
//           headerSliverBuilder: (BuildContext context, _) {
//             return [
//               SliverAppBar(
//                 systemOverlayStyle: const SystemUiOverlayStyle(
//                   statusBarColor: Color(0xffF7F6F2),

//                   statusBarIconBrightness:
//                       Brightness.dark, // For Android (dark icons)
//                   statusBarBrightness: Brightness.light, // For iOS (dark icons)
//                 ),
//                 floating: true,
//                 pinned: false,
//                 snap: true,
//                 backgroundColor: const Color(0xffF7F6F2),
//                 elevation: 0,
//                 toolbarHeight: 60,
//                 title: SvgPicture.asset(
//                   AppAssets.relifeLogo,
//                   height: 38.45,
//                 ),
//                 actions: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 12.0, right: 22),
//                     child: Consumer<ProfileProvider>(
//                         builder: (context, profile, child) {
//                       return IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const ProfilePage()));
//                         },
//                         icon: SizedBox(
//                           height: 30,
//                           width: 30,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 1.r, color: const Color(0xffFA8A3C)),
//                               shape: BoxShape.circle,
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               child: Image.network(
//                                 "https://relife.co.in/api/${profile.profilePicture}" +
//                                     "?v=${DateTime.now().millisecondsSinceEpoch}",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         splashRadius: 25,
//                       );
//                     }),
//                   ),
//                 ],
//                 titleSpacing: 25,
//                 automaticallyImplyLeading: false,
//               ),
//             ];
//           },
//           floatHeaderSlivers: true,
//           body: Padding(
//             padding: const EdgeInsets.only(top: 1, left: 10, right: 10),
//             child: !loading
//                 ? PagedListView<int, dynamic>(
//                     pagingController: _pagingController,
//                     builderDelegate: PagedChildBuilderDelegate<dynamic>(
//                       itemBuilder: (context, item, index) {
//                         log("++++++++++++++++ $item");
//                         // return PostWidget(
//                         //   postId: item.id,
//                         //   postIndex: index,
//                         // );
//                         return Container(
//                           height: 30,
//                           width: 100,
//                           color: Colors.amber,
//                         );
//                       },
//                     ),
//                   )
//                 : const Center(child: CircularProgressIndicator()),
//           )),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
