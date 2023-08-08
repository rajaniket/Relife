import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/services/GetSocial/group_services.dart';
import 'package:relife/ui/pages/community_ritual/community_ritual_page.dart';

import '../../../../utils/page_transition_navigator/custom_navigator_push.dart';
import 'local_widget/whats_new_container_widget.dart';
import 'local_widget/your_group_container.dart';

class ExploreTabScreen extends StatefulWidget {
  const ExploreTabScreen({Key? key}) : super(key: key);

  @override
  State<ExploreTabScreen> createState() => _ExploreTabScreenState();
}

class _ExploreTabScreenState extends State<ExploreTabScreen> {
  late var alreadyAMember;
  late List<Widget> childrenForYourGroup;
  late List<Widget> childrenForJoinNewGroup;
  late bool _isLoading = true;
  List<String> groupIds = ['exercise', 'introduction', 'reading', 'running'];

  checkGroupMemberJoined() async {
    alreadyAMember = await GroupServices().checkGroupMember(groupIds: groupIds);
    return;
  }

  updateChildrenForYourGroup() {
    childrenForYourGroup = [
      if (alreadyAMember['exercise'])
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: YourGroupContainerWidget(
            groupTitle: 'exercise',
            groupId: 'exercise',
            groupDescription: 'see what others are doing',
            image: AppAssets.exercise,
            updateExploreTab: () async {
              loadData();
            },
            alreadyAMember: true,
          ),
        ),
      if (alreadyAMember['introduction'])
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: YourGroupContainerWidget(
            groupTitle: 'introduction',
            groupId: 'introduction',
            groupDescription: 'make new Friends',
            image: AppAssets.introduction,
            updateExploreTab: () {
              loadData();
            },
            alreadyAMember: true,
          ),
        ),
      if (alreadyAMember['reading'])
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: YourGroupContainerWidget(
            groupTitle: 'reading',
            groupId: 'reading',
            groupDescription: 'see what others are reading',
            image: AppAssets.reading,
            updateExploreTab: () {
              loadData();
            },
            alreadyAMember: true,
          ),
        ),
      if (alreadyAMember['running'])
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: YourGroupContainerWidget(
            groupTitle: 'running',
            groupId: 'running',
            groupDescription: 'discuss your best runs',
            image: AppAssets.running,
            updateExploreTab: () {
              loadData();
            },
            alreadyAMember: true,
          ),
        ),
    ];
  }

  updateChildrenForJoinNewGroup() {
    childrenForJoinNewGroup = [
      if (!alreadyAMember['exercise'])
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: YourGroupContainerWidget(
            groupTitle: 'exercise',
            groupId: 'exercise',
            groupDescription: 'see what others are doing',
            image: AppAssets.exercise,
            updateExploreTab: () {
              loadData();
            },
            alreadyAMember: false,
          ),
        ),
      if (!alreadyAMember['introduction'])
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: YourGroupContainerWidget(
            groupTitle: 'introduction',
            groupId: 'introduction',
            groupDescription: 'make new Friends',
            image: AppAssets.introduction,
            updateExploreTab: () {
              loadData();
            },
            alreadyAMember: false,
          ),
        ),
      if (!alreadyAMember['reading'])
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: YourGroupContainerWidget(
            groupTitle: 'reading',
            groupId: 'reading',
            groupDescription: 'see what others are reading',
            image: AppAssets.reading,
            updateExploreTab: () {
              loadData();
            },
            alreadyAMember: false,
          ),
        ),
      if (!alreadyAMember['running'])
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: YourGroupContainerWidget(
            groupTitle: 'running',
            groupId: 'running',
            groupDescription: 'discuss your best runs',
            image: AppAssets.running,
            updateExploreTab: () {
              loadData();
            },
            alreadyAMember: false,
          ),
        ),
    ];
  }

  Future<void> loadData() async {
    await checkGroupMemberJoined();
    await Future.delayed(const Duration(milliseconds: 300));
    updateChildrenForJoinNewGroup();
    updateChildrenForYourGroup();

    // print(alreadyAMember);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xffF7F6F2),

          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      backgroundColor: const Color(0xffF7F6F2),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadData,
              key: UniqueKey(),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.w),
                          child: Text('what\'s new',
                              style: TextStyle(
                                  fontSize: AddHabitScreenTextStyle.headingSize,
                                  fontWeight:
                                      AddHabitScreenTextStyle.headingWeight,
                                  color: AppColors.startScreenBackgroundColor)),
                        ),
                      ),
                      SizedBox(
                        height: 14.0.h,
                      ),
                      SizedBox(
                        height: 165.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(width: 20.w),
                            // WhatsNewContainerWidget(
                            //     message: 'how to really build habits',
                            //     imgPath: AppAssets.howToReallyBuildHabits),
                            // const WhatsNewContainerWidget(
                            //     message: 'challenge your friend',
                            //     imgPath: AppAssets.challengeYourFriend),
                            // const WhatsNewContainerWidget(
                            //     message: 'take the 21 days challange',
                            //     imgPath: AppAssets.takeThe21DaysChallange),
                            GestureDetector(
                              onTap: () async {
                                String url =
                                    "https://lu.ma/embed-events/usr-RWwKPWezXQDkLBl";
                                bool isEmail = url.contains("@");
                                if (!isEmail) {
                                  if (!Uri.parse(url).hasScheme) {
                                    url = "http://" + url;
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
                                    print(e);
                                    // rethrow;
                                  }
                                }
                              },
                              child: const WhatsNewContainerWidget(
                                message: 'upcoming events',
                                imgPath: AppAssets.upcomingEvents,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigatorPush(
                                  context,
                                  const CommunityRitualPage(),
                                );
                              },
                              child: const WhatsNewContainerWidget(
                                message: 'community rituals 🙌🏻',
                                imgPath: AppAssets.communityRitual,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0.h,
                      ),
                      if (childrenForYourGroup.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Text('your groups',
                                style: TextStyle(
                                    fontSize:
                                        AddHabitScreenTextStyle.headingSize,
                                    fontWeight:
                                        AddHabitScreenTextStyle.headingWeight,
                                    color:
                                        AppColors.startScreenBackgroundColor)),
                          ),
                        ),
                      if (childrenForYourGroup.isNotEmpty)
                        SizedBox(
                          height: 15.0.h,
                        ),
                      if (childrenForYourGroup.isNotEmpty)
                        Column(
                          children: childrenForYourGroup,
                        ),
                      if (childrenForJoinNewGroup.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Text('join new groups',
                                style: TextStyle(
                                    fontSize:
                                        AddHabitScreenTextStyle.headingSize,
                                    fontWeight:
                                        AddHabitScreenTextStyle.headingWeight,
                                    color:
                                        AppColors.startScreenBackgroundColor)),
                          ),
                        ),
                      if (childrenForJoinNewGroup.isNotEmpty)
                        SizedBox(
                          height: 15.0.h,
                        ),
                      if (childrenForJoinNewGroup.isNotEmpty)
                        Column(
                          children: childrenForJoinNewGroup,
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
