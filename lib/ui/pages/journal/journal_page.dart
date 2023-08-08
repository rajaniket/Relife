import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:relife/ui/widgets/journal_post_widget.dart';
import '../../../constants/text_data.dart';
import '../../../providers/post_provider.dart';
import '../../widgets/back_button.dart';
import '../../widgets/post_widget.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
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
              toolbarHeight: 50.h,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 32,
                          child: RawMaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            elevation: 0,
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            shape: const CircleBorder(),
                            highlightElevation: 0,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'my journal',
                          style: TextStyle(
                              fontSize: ViewHabitScreenTextStyle.headingSize,
                              fontWeight:
                                  ViewHabitScreenTextStyle.headingWeight,
                              color: const Color(0xff062540)),
                        ),
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
          padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
          child: _BuildPost(
              // homeScrollController: widget.homeScrollController,
              ),
        ),
      ),
    );
  }
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
        .loadAllPosts(getPostByUser: true, userId: UserId.currentUser());
    return true;
    //await widget.snapshot.loadAllPosts();
  }

  Future<void> _onRefresh() async {
    userPostList = await Provider.of<AllPostsProvider>(context, listen: false)
        .loadAllPosts(getPostByUser: true, userId: UserId.currentUser());
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
        child: FutureBuilder(
            future: loadFeedsData(),
            builder: (context, snap) {
              if (snap.hasData || userPostList != null) {
                return NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
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
                        return JournalPostWidget(
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
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
