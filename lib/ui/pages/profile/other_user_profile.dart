import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/providers/others_profile_provider.dart';
import 'package:relife/ui/pages/profile_pic_view/profile_pic_view.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiveDataOtherUserProfile {
  LiveDataOtherUserProfile(this.value, this.time, this.index);
  final num value;
  final num index;
  final String time;
}

class OtherProfilePage extends StatefulWidget {
  final String id;
  const OtherProfilePage({Key? key, required this.id}) : super(key: key);

  @override
  State<OtherProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<OtherProfilePage> {
  final String aboutYou =
      'hey there\n\nI am akshay, a working professional from mumbai.\n\ni am here to build a habit of running,reading and reducing screen time\n\ni look forward to building these habits with you all. also, happy to help ';

  late ChartSeriesController _chartSeriesController;
  late List<LiveDataOtherUserProfile> currentStreakChartData,
      doingNothingLine,
      currentStreakStartCordinate,
      currentStreakEndCordinate,
      preDefinedEndCordinate;
  List<LiveDataOtherUserProfile> predefinedChartdata = [];

  String percentageValueBoldLetter = "", percentageImproveText = "";

  getPreDefinedChartData() {
    final profileProvider =
        Provider.of<OthersProfileProvider>(context, listen: false);
    int length = profileProvider.othersProfileModel!.details.graph!.length;
    List<LiveDataOtherUserProfile> temp = List.generate(length, (index) {
      return LiveDataOtherUserProfile(
          profileProvider.othersProfileModel!.details.graph![index].value,
          "week",
          index);
    });
    preDefinedEndCordinate = [
      if (length != 0)
        LiveDataOtherUserProfile(
            profileProvider
                .othersProfileModel!.details.graph![length - 1].value,
            "week",
            length - 1)
    ];

    // return temp;
  }

  List<LiveDataOtherUserProfile> getCurrentStreakChartData() {
    var now = DateTime.now().toLocal();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    final profileProvider =
        Provider.of<OthersProfileProvider>(context, listen: false);
    int currentDateIndex = profileProvider.othersProfileModel!.details.graph!
        .indexWhere((element) => element.date.contains(formattedDate));

    currentStreakStartCordinate = [
      LiveDataOtherUserProfile(
          profileProvider.othersProfileModel!.details.graph![0].value,
          "date",
          // profileProvider.viewProfileResponseModel!.details.graph![0].date,
          0)
    ];

    currentStreakEndCordinate = [
      LiveDataOtherUserProfile(
          profileProvider
              .othersProfileModel!.details.graph![currentDateIndex].value,
          'date',
          currentDateIndex)
    ];

    //profileProvider.viewProfileResponseModel!.details.graph!.contains(element);
    List<LiveDataOtherUserProfile> temp =
        List.generate(currentDateIndex + 1, (index) {
      return LiveDataOtherUserProfile(
          profileProvider.othersProfileModel!.details.graph![index].value,
          'date',
          index);
    });

    predefinedChartdata.add(currentStreakStartCordinate[0]);
    predefinedChartdata.add(currentStreakEndCordinate[0]);
    predefinedChartdata.add(preDefinedEndCordinate[0]);

    List<LiveDataOtherUserProfile> temp2 = [];
    temp2.add(currentStreakStartCordinate[0]);
    temp2.add(temp[currentDateIndex ~/ 2]);
    temp2.add(currentStreakEndCordinate[0]);

    return temp2;
  }

  List<LiveDataOtherUserProfile> getDoingNothingChartData() {
    final profileProvider =
        Provider.of<OthersProfileProvider>(context, listen: false);
    List<LiveDataOtherUserProfile> temp = List.generate(
        profileProvider.othersProfileModel!.details.graph!.length,
        (index) => LiveDataOtherUserProfile(1, 'date', index));

    return temp;
  }

  String timeRange() {
    final profileProvider =
        Provider.of<OthersProfileProvider>(context, listen: false);
    int length = profileProvider.othersProfileModel!.details.graph!.length;
    if (length <= 14) {
      return "2 weeks";
    } else if (length <= 30) {
      return "1 month";
    } else if (length > 30 && length < 365) {
      return "${length ~/ 30} months";
    } else if (length >= 365) {
      return "1 year";
    }
    return "1 year";
  }

  String getPercentageImprove() {
    double value = currentStreakEndCordinate[0].value.toDouble();
    int percentage;
    if (value < 1) {
      percentage = ((1 - value) * 100).round();
      percentageImproveText =
          "you're going back to your old habits. let's start today to regain this ";
      percentageValueBoldLetter = "$percentage% drop 💪🏻";
    } else if (value >= 1 && value < 2) {
      percentage = ((value - 1) * 100).round();
      percentageImproveText = "you've gotten ";
      percentageValueBoldLetter = "$percentage% better 🙌🏻";
    } else {
      percentageImproveText = "you've gotten ";
      percentageValueBoldLetter =
          "${value.roundToDouble().toStringAsFixed(1)} times better 🙌🏻";
    }
    return "";
  }

  @override
  void initState() {
    // predefinedChartdata = getPreDefinedChartData();
    getPreDefinedChartData();
    currentStreakChartData = getCurrentStreakChartData();
    doingNothingLine = getDoingNothingChartData();
    getPercentageImprove();
    super.initState();
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
      body: SingleChildScrollView(
        child: Consumer<OthersProfileProvider>(
            builder: (context, otherProfile, child) {
          return Column(
            children: [
              SizedBox(
                height: 5.0.h,
              ),
              _buildBackButtonAndTitle(context),
              SizedBox(
                height: 18.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0.w),
                child: _buildProfileRow(otherProfile),
              ),
              SizedBox(
                height: 15.h,
              ),
              AboutPersonContainer(
                message: otherProfile.bio,
              ),
              // SizedBox(
              //   height: 15.h,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 28.0.w),
              //   child: Center(
              //     child: Text.rich(
              //       TextSpan(
              //         children: [
              //           // TextSpan(
              //           //   text: 'you’ve gotten',
              //           //   style: TextStyle(
              //           //       fontSize: 14.sp, fontWeight: FontWeight.w400),
              //           // ),

              //           TextSpan(
              //             text: percentageImproveText,
              //             style: TextStyle(
              //                 fontSize: 14.sp, fontWeight: FontWeight.w400),
              //           ),
              //           TextSpan(
              //             text: percentageValueBoldLetter,
              //             style: TextStyle(
              //                 fontSize: 14.sp, fontWeight: FontWeight.w600),
              //           ),
              //         ],
              //       ),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Container(
                  padding: EdgeInsets.all(0.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                  height: 236.h,
                  child: Stack(
                    children: [
                      // Positioned(
                      //     top: 6.r,
                      //     right: 6.r,
                      //     child: SizedBox(
                      //         height: 50.r,
                      //         width: 50.r,
                      //         child:
                      //             SvgPicture.asset(AppAssets.leaderboardCup))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.r, left: 10.r, right: 10.r),
                            child: Container(
                              height: 200.h,
                              decoration: const BoxDecoration(
                                  // color: Colors.black45
                                  // border: Border(
                                  //   bottom: BorderSide(color: Colors.black),
                                  //   left: BorderSide(color: Colors.black),
                                  // ),
                                  ),
                              child: SfCartesianChart(
                                annotations: [
                                  // CartesianChartAnnotation(
                                  //   region: AnnotationRegion.chart,
                                  //   verticalAlignment: ChartAlignment.far,
                                  //   widget: Container(
                                  //       padding: EdgeInsets.only(top: 15.h),
                                  //       child: Column(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           Container(
                                  //             decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                   width: 1.5.r,
                                  //                   color: const Color(
                                  //                       0xffFA8A3C)),
                                  //               shape: BoxShape.circle,
                                  //             ),
                                  //             child: ClipOval(
                                  //               child: SizedBox(
                                  //                 height: 16.0.r,
                                  //                 width: 16.0.r,
                                  //                 child: profileModel
                                  //                             .profilePicture !=
                                  //                         ''
                                  //                     ? Image.network(
                                  //                         'https://relife.co.in/api/${profileModel.profilePicture}',
                                  //                         key: ValueKey<String>(
                                  //                             profileModel.key),
                                  //                       )
                                  //                     : Image.asset(
                                  //                         'assets/images/user1.png'),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           // Container(
                                  //           //   height: 0.h,
                                  //           //   width: 2.r,
                                  //           //   color: const Color(0xffF4CBB6),
                                  //           // )
                                  //         ],
                                  //       )),
                                  //   coordinateUnit: CoordinateUnit.point,
                                  //   x: currentStreakEndCordinate[0].index,
                                  //   y: currentStreakEndCordinate[0].value,
                                  // ),
                                  CartesianChartAnnotation(
                                    verticalAlignment: ChartAlignment.center,
                                    //horizontalAlignment: ChartAlignment.near,
                                    widget: Container(
                                      height: 8.r,
                                      width: 8.r,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFA8A3C)),
                                    ),
                                    coordinateUnit: CoordinateUnit.point,
                                    x: currentStreakEndCordinate[0].index,
                                    y: currentStreakEndCordinate[0].value,
                                  ),
                                  CartesianChartAnnotation(
                                    verticalAlignment: ChartAlignment.center,
                                    //horizontalAlignment: ChartAlignment.near,
                                    widget: Container(
                                      height: 8.r,
                                      width: 8.r,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff000000)),
                                    ),
                                    coordinateUnit: CoordinateUnit.point,
                                    x: currentStreakStartCordinate[0].index,
                                    y: currentStreakStartCordinate[0].value,
                                  ),
                                  // CartesianChartAnnotation(
                                  //   verticalAlignment: ChartAlignment.far,
                                  //   horizontalAlignment: ChartAlignment.far,
                                  //   widget: SizedBox(
                                  //       height: 25.14.r,
                                  //       child: SvgPicture.asset(
                                  //         AppAssets.cupIcon,
                                  //         // color: Color(0xffFB9248),
                                  //       )),
                                  //   coordinateUnit: CoordinateUnit.point,
                                  //   x: preDefinedEndCordinate[0].index,
                                  //   y: preDefinedEndCordinate[0].value,
                                  // ),
                                  CartesianChartAnnotation(
                                    verticalAlignment: ChartAlignment.far,
                                    horizontalAlignment: ChartAlignment.far,
                                    region: AnnotationRegion.plotArea,
                                    widget: Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: RotatedBox(
                                        quarterTurns: 2,
                                        child: SizedBox(
                                            height: 15.h,
                                            child: SvgPicture.asset(
                                              AppAssets.thumbsDown,
                                            )),
                                      ),
                                    ),
                                    coordinateUnit: CoordinateUnit.point,
                                    x: preDefinedEndCordinate[0].index,
                                    y: doingNothingLine[0].value,
                                  ),
                                  CartesianChartAnnotation(
                                    verticalAlignment: ChartAlignment.near,
                                    horizontalAlignment: ChartAlignment.far,
                                    region: AnnotationRegion.plotArea,
                                    widget: Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 15.h,
                                              child: SvgPicture.asset(
                                                AppAssets.thumbsDown,
                                              ))
                                        ],
                                      ),
                                    ),
                                    coordinateUnit: CoordinateUnit.point,
                                    x: preDefinedEndCordinate[0].index,
                                    y: doingNothingLine[0].value,
                                  ),
                                ],
                                plotAreaBackgroundColor: Colors.transparent,
                                series: <
                                    SplineSeries<LiveDataOtherUserProfile,
                                        num>>[
                                  SplineSeries<LiveDataOtherUserProfile, num>(
                                    animationDuration: 3000,
                                    onRendererCreated:
                                        (ChartSeriesController controller) {
                                      _chartSeriesController = controller;
                                    },
                                    dataSource: doingNothingLine,
                                    dashArray: const [2, 2],
                                    color: const Color(0xffCCCCCC),
                                    xValueMapper:
                                        (LiveDataOtherUserProfile sales, _) =>
                                            sales.index,
                                    yValueMapper:
                                        (LiveDataOtherUserProfile sales, _) =>
                                            sales.value,
                                    isVisible: true,
                                    width: 1,
                                  ),
                                  SplineSeries<LiveDataOtherUserProfile, num>(
                                    animationDuration: 3000,
                                    cardinalSplineTension: 0.9,
                                    splineType: SplineType.natural,
                                    onRendererCreated:
                                        (ChartSeriesController controller) {
                                      _chartSeriesController = controller;
                                    },
                                    dataSource: predefinedChartdata,
                                    color: const Color(0xffFA8A3C),
                                    xValueMapper:
                                        (LiveDataOtherUserProfile sales, _) =>
                                            sales.index,
                                    yValueMapper:
                                        (LiveDataOtherUserProfile sales, _) =>
                                            sales.value,
                                    isVisible: true,
                                    width: 2,
                                    dashArray: [1, 9],
                                  ),
                                  SplineSeries<LiveDataOtherUserProfile, num>(
                                    animationDuration: 3000,
                                    animationDelay: 2000,
                                    onRendererCreated:
                                        (ChartSeriesController controller) {
                                      _chartSeriesController = controller;
                                    },
                                    dataSource: currentStreakChartData,
                                    color: const Color(0xffFA8A3C),
                                    xValueMapper:
                                        (LiveDataOtherUserProfile sales, _) =>
                                            sales.index,
                                    yValueMapper:
                                        (LiveDataOtherUserProfile sales, _) =>
                                            sales.value,
                                    isVisible: true,
                                    width: 5,
                                  ),
                                ],
                                plotAreaBorderColor: Colors.transparent,
                                // axes: [
                                //   NumericAxis(
                                //     majorGridLines:
                                //         const MajorGridLines(width: 0),
                                //     edgeLabelPlacement:
                                //         EdgeLabelPlacement.hide,
                                //     axisLine: const AxisLine(width: 3),
                                //   )
                                // ],
                                // margin: EdgeInsets.zero,

                                primaryXAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.hide,
                                  axisLine: const AxisLine(width: 3),
                                  isVisible: true,
                                  maximumLabels: 0,
                                  tickPosition: TickPosition.inside,
                                  labelStyle: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 3),
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.hide,
                                  maximumLabels: 0,

                                  axisBorderType:
                                      AxisBorderType.withoutTopAndBottom,
                                  isVisible: true,
                                  tickPosition: TickPosition.inside,
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  anchorRangeToVisiblePoints: false,
                                  majorTickLines: const MajorTickLines(
                                      color: Colors.transparent),

                                  // title: AxisTitle(text: 'Y-Axis'),
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       left: 18.w, right: 15.w, bottom: 10.h),
                          //   child: Container(
                          //     color: Colors.black26,
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text(
                          //           "Start",
                          //           style: TextStyle(
                          //               fontSize: 16.sp,
                          //               color: const Color(0xff062540),
                          //               fontWeight: FontWeight.w500),
                          //         ),
                          //         Text(
                          //           "2 Weeks",
                          //           style: TextStyle(
                          //               color: const Color(0xff062540),
                          //               fontSize: 16.sp,
                          //               fontWeight: FontWeight.w500),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      Positioned(
                        bottom: 8.h,
                        left: 25.w,
                        child: const Text(
                          "start",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff062540),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Positioned(
                        bottom: 8.h,
                        right: 10.w,
                        child: Text(
                          timeRange(),
                          style: const TextStyle(
                              color: Color(0xff062540),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              otherProfile.othersProfileModel != null
                  ? Column(
                      children: List.generate(
                          otherProfile.othersProfileModel!.details.habits
                              .length, (index) {
                      var ranking = otherProfile
                          .othersProfileModel!.details.habits[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: RankingContainer(
                          habit: ranking.habitDetails.name,
                          ranking:
                              ranking.habitDetails.leaderboardRank.toString(),
                          image: ranking.habitDetails.name == 'reading'
                              ? AppAssets.reading
                              : ranking.habitDetails.name == 'running'
                                  ? AppAssets.running
                                  : AppAssets.exercise,
                          onTap: () {},
                        ),
                      );
                    }))
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          );
        }),
      ),
    );
  }

  Row _buildProfileRow(OthersProfileProvider model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileImageView(
                              imgUrl: model.profilePicture,
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 4.r, color: const Color(0xffFA8A3C)),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: SizedBox(
                      height: 75.0.r,
                      width: 75.0.r,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://relife.co.in/api/${model.profilePicture}',
                        key: ValueKey<String>(model.key),
                      )),
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.firstName + ' ${model.lastName}',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff062540)),
                ),
                SizedBox(
                  height: 7.0.h,
                ),
                // Text(
                //   'member since 12 nov,2021',
                //   style: TextStyle(
                //       fontSize: 12.sp,
                //       fontWeight: FontWeight.w400,
                //       color: const Color(0xff062540)),
                // )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBackButtonAndTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RoundBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColour: Colors.white,
            ),
            // Text(
            //   'my relife',
            //   style: TextStyle(
            //       fontSize: ViewHabitScreenTextStyle.headingSize,
            //       fontWeight: ViewHabitScreenTextStyle.headingWeight,
            //       color: const Color(0xff062540)),
            // ),
          ],
        ),
        // Padding(
        //   padding: EdgeInsets.only(right: 10.w),
        //   child: TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       'follow',
        //       style: TextStyle(
        //         color: const Color(0xffFA8A3C),
        //         fontSize: 17.28.sp,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class RankingContainer extends StatelessWidget {
  final String ranking, habit, image;
  final VoidCallback onTap;
  const RankingContainer(
      {Key? key,
      required this.habit,
      required this.ranking,
      required this.image,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 336.0.w,
        height: 95.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0.r), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.fromLTRB(28.0.w, 6.0.h, 5.0.w, 6.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("# $ranking",
                      style: TextStyle(
                          fontSize: 24.0.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.defaultTextColor)),
                  Text('in $habit this month',
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black))
                ],
              ),
              SizedBox(
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowersContainer extends StatelessWidget {
  final String followers, following, posts;

  const FollowersContainer({
    Key? key,
    required this.followers,
    required this.following,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.0.w,
      height: 80.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0.r), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.fromLTRB(28.0.w, 6.0.h, 28.0.w, 6.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: followers,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '\nfollowers',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: following,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '\nfollowing',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: posts,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '\nposts',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPersonContainer extends StatelessWidget {
  final String message;

  const AboutPersonContainer({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.0.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0.r), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0.w, 26.0.h, 24.0.w, 26.0.h),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
