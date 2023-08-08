import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/providers/alarm_provider.dart';
import 'package:relife/providers/login_provider.dart';
import 'package:relife/providers/payment_detail_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/providers/update_dp_provider.dart';
import 'package:relife/ui/pages/edit_profile/edit_profile.dart';
import 'package:relife/ui/pages/login/login_page.dart';
import 'package:relife/ui/pages/payment/active_payment_page.dart';
import 'package:relife/ui/pages/payment/payment_page.dart';
import 'package:relife/ui/pages/profile_pic_view/profile_pic_view.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiveData {
  LiveData(this.value, this.time, this.index);
  final num value;
  final num index;
  final String time;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ChartSeriesController _chartSeriesController;
  late List<LiveData> currentStreakChartData,
      doingNothingLine,
      currentStreakStartCordinate,
      currentStreakEndCordinate,
      preDefinedEndCordinate;
  List<LiveData> predefinedChartdata = [];

  String percentageValueBoldLetter = "", percentageImproveText = "";

  getPreDefinedChartData() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    int length =
        profileProvider.viewProfileResponseModel!.details.graph!.length;
    List<LiveData> temp = List.generate(length, (index) {
      return LiveData(
          profileProvider.viewProfileResponseModel!.details.graph![index].value,
          "week",
          index);
    });
    preDefinedEndCordinate = [
      if (length != 0)
        LiveData(
            profileProvider
                .viewProfileResponseModel!.details.graph![length - 1].value,
            "week",
            length - 1)
    ];

    // return temp;
  }

  List<LiveData> getCurrentStreakChartData() {
    var now = DateTime.now().toLocal();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    int currentDateIndex = profileProvider
        .viewProfileResponseModel!.details.graph!
        .indexWhere((element) => element.date.contains(formattedDate));

    currentStreakStartCordinate = [
      LiveData(
          profileProvider.viewProfileResponseModel!.details.graph![0].value,
          "date",
          // profileProvider.viewProfileResponseModel!.details.graph![0].date,
          0)
    ];

    currentStreakEndCordinate = [
      LiveData(
          profileProvider
              .viewProfileResponseModel!.details.graph![currentDateIndex].value,
          'date',
          currentDateIndex)
    ];

    //profileProvider.viewProfileResponseModel!.details.graph!.contains(element);
    List<LiveData> temp = List.generate(currentDateIndex + 1, (index) {
      return LiveData(
          profileProvider.viewProfileResponseModel!.details.graph![index].value,
          'date',
          index);
    });

    predefinedChartdata.add(currentStreakStartCordinate[0]);
    predefinedChartdata.add(currentStreakEndCordinate[0]);
    predefinedChartdata.add(preDefinedEndCordinate[0]);

    List<LiveData> temp2 = [];
    temp2.add(currentStreakStartCordinate[0]);
    temp2.add(temp[currentDateIndex ~/ 2]);
    temp2.add(currentStreakEndCordinate[0]);

    return temp2;
  }

  List<LiveData> getDoingNothingChartData() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    List<LiveData> temp = List.generate(
        profileProvider.viewProfileResponseModel!.details.graph!.length,
        (index) => LiveData(1, 'date', index));

    return temp;
  }

  String timeRange() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    int length =
        profileProvider.viewProfileResponseModel!.details.graph!.length;
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
    Provider.of<PaymentDetailProvider>(context, listen: false)
        .getPaymentDetials();
    // predefinedChartdata = getPreDefinedChartData();
    getPreDefinedChartData();
    currentStreakChartData = getCurrentStreakChartData();
    doingNothingLine = getDoingNothingChartData();
    getPercentageImprove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentDetail =
        Provider.of<PaymentDetailProvider>(context, listen: false);
    return Consumer2<ProfileProvider, UpdateDpProvider>(
        builder: (context, profileModel, updateDpProvider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
          elevation: 0,
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xffF7F6F2),

            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        backgroundColor: const Color(0xffF7F6F2),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5.0.h,
              ),
              _buildBackButtonAndTitle(context, profileModel, paymentDetail),
              SizedBox(
                height: 18.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0.w),
                child: _buildProfileRow(
                  profileModel,
                  updateDpProvider,
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              // FollowersContainer(
              //   followers: followModel.follower.toString(),
              //   following: followModel.following.toString(),
              //   posts: '24',
              // ),
              // SizedBox(
              //   height: 15.h,
              // ),
              AboutPersonContainer(
                message: profileModel.bio,
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0.w),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        // TextSpan(
                        //   text: 'you’ve gotten',
                        //   style: TextStyle(
                        //       fontSize: 14.sp, fontWeight: FontWeight.w400),
                        // ),

                        TextSpan(
                          text: percentageImproveText,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: percentageValueBoldLetter,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              // SvgPicture.asset(
              //   AppAssets.graphProfilePage,
              //   width: 336.w,
              // ),

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
                                series: <SplineSeries<LiveData, num>>[
                                  SplineSeries<LiveData, num>(
                                    animationDuration: 3000,
                                    onRendererCreated:
                                        (ChartSeriesController controller) {
                                      _chartSeriesController = controller;
                                    },
                                    dataSource: doingNothingLine,
                                    dashArray: const [2, 2],
                                    color: const Color(0xffCCCCCC),
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.index,
                                    yValueMapper: (LiveData sales, _) =>
                                        sales.value,
                                    isVisible: true,
                                    width: 1,
                                  ),
                                  SplineSeries<LiveData, num>(
                                    animationDuration: 3000,
                                    cardinalSplineTension: 0.9,
                                    splineType: SplineType.natural,
                                    onRendererCreated:
                                        (ChartSeriesController controller) {
                                      _chartSeriesController = controller;
                                    },
                                    dataSource: predefinedChartdata,
                                    color: const Color(0xffFA8A3C),
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.index,
                                    yValueMapper: (LiveData sales, _) =>
                                        sales.value,
                                    isVisible: true,
                                    width: 2,
                                    dashArray: [1, 9],
                                  ),
                                  SplineSeries<LiveData, num>(
                                    animationDuration: 3000,
                                    animationDelay: 2000,
                                    onRendererCreated:
                                        (ChartSeriesController controller) {
                                      _chartSeriesController = controller;
                                    },
                                    dataSource: currentStreakChartData,
                                    color: const Color(0xffFA8A3C),
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.index,
                                    yValueMapper: (LiveData sales, _) =>
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
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0.w),
                child: Text(
                  "you get 1 % better everyday you perform your habits and vice versa",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 27.h,
              ),
              profileModel.viewProfileResponseModel != null
                  ? Column(
                      children: List.generate(
                          profileModel.viewProfileResponseModel!.details.habits
                              .length, (index) {
                      var ranking = profileModel
                          .viewProfileResponseModel!.details.habits[index];
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
          ),
        ),
      );
    });
  }

  Row _buildProfileRow(
      ProfileProvider model, UpdateDpProvider updateDpProvider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  // ignore: curly_braces_in_flow_control_structures
                  onTap: () {
                    if (model.profilePicture != '') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileImageView(
                                    imgUrl: model.profilePicture,
                                  )));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4.r, color: const Color(0xffFA8A3C)),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: SizedBox(
                        height: 75.0.r,
                        width: 75.0.r,
                        child: model.profilePicture != ''
                            ? CachedNetworkImage(
                                imageUrl:
                                    'https://relife.co.in/api/${model.profilePicture}',
                                fit: BoxFit.cover,
                                cacheManager: CacheManager(Config(
                                  "profilePic",
                                  stalePeriod: const Duration(days: 1),
                                  //one week cache period
                                )),
                              )
                            : Image.asset('assets/images/user1.png'),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 15.r,
                      child: IconButton(
                        onPressed: () async {
                          final statusCode = await updateDpProvider.updateDp();
                          CustomProgressIndicator().buildShowDialog(context);
                          if (statusCode == 200 || statusCode == 201) {
                            await model.getProfile(context);
                            // var batchUpdate = UserUpdate();
                            // batchUpdate.updateAvatarUrl(
                            //     'https://relife.co.in/api/${model.profilePicture}');
                            // var user = await GetSocial.currentUser;
                            // await user!.updateDetails(batchUpdate);
                            await Provider.of<LoginProvider>(context,
                                    listen: false)
                                .updateUser(context);
                            await CachedNetworkImage.evictFromCache(
                                'https://relife.co.in/api/${model.profilePicture}');
                            PaintingBinding.instance!.imageCache!.clear();
                            DefaultCacheManager manager = DefaultCacheManager();
                            await manager.emptyCache();
                            await DefaultCacheManager()
                                .removeFile("profilePic");
                            Navigator.pop(context);
                            log("dp updated__________________");
                            setState(() {});
                          } else {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: 'Something went Wrong',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        },
                        color: const Color(0xffFA8A3C),
                        icon: Icon(
                          Icons.edit,
                          size: 15.r,
                        ),
                      ),
                    ),
                  ),
                )
              ],
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
                //   'member since ${DateTime.fromMillisecondsSinceEpoch(int.parse(currentStreakStartCordinate[0].time))}',
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

  Widget _buildBackButtonAndTitle(BuildContext context, ProfileProvider model,
      PaymentDetailProvider paymentDetailProvider) {
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
        IconButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              transitionDuration: const Duration(milliseconds: 500),
              barrierLabel: MaterialLocalizations.of(context).dialogLabel,
              // barrierColor: Colors.white.withOpacity(0.5),
              pageBuilder: (context, _, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xffF7F6F2),
                      child: Padding(
                        padding:
                            EdgeInsets.fromLTRB(12.0.w, 44.0.h, 12.0.w, 36.0.h),
                        child: Container(
                          padding: EdgeInsets.all(0.0.r),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0.r),
                              color: Colors.white),
                          child: Material(
                            color: Colors.transparent,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfilePage(
                                                aboutYou: model.bio,
                                              ),
                                            ),
                                          );
                                        },
                                        title: Center(
                                          child: Text(
                                            'edit profile',
                                            style: TextStyle(
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.72.h,
                                        width: 105.w,
                                        child: const Divider(
                                          thickness: 2.0,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          paymentDetailProvider.currentSub ==
                                                  null
                                              ? navigatorPush(
                                                  context,
                                                  const PaymentPage(),
                                                )
                                              : navigatorPush(
                                                  context,
                                                  const ActivePaymentPage(),
                                                );
                                        },
                                        title: Center(
                                          child: Text(
                                            'manage plan',
                                            style: TextStyle(
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 105.w,
                                        child: const Divider(
                                          thickness: 2.0,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () async {
                                          var loginprovider =
                                              Provider.of<LoginProvider>(
                                                  context,
                                                  listen: false);
                                          await loginprovider.logOut();
                                          //canceling alarm
                                          var alarmProvider =
                                              Provider.of<AlarmProvider>(
                                                  context,
                                                  listen: false);
                                          await alarmProvider.cancelAlarm(
                                              passAlarmId: 123);
                                          await alarmProvider.cancelAlarm(
                                              passAlarmId: 234);
                                          await alarmProvider.cancelAlarm(
                                              passAlarmId: 345);

                                          //

                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const LoginPage(),
                                            ),
                                          );
                                        },
                                        title: Center(
                                          child: Text(
                                            'logout',
                                            style: TextStyle(
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      //Text(data)
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 12.h,
                                  right: 12.h,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    constraints: const BoxConstraints(),
                                    splashRadius: 22.r,
                                    padding: EdgeInsets.zero,
                                    icon: SvgPicture.asset(
                                      AppAssets.crossIcon,
                                      height: 22.r,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ).drive(Tween<Offset>(
                    begin: const Offset(0, -1.0),
                    end: Offset.zero,
                  )),
                  child: child,
                );
              },
            );
          },
          splashRadius: 20.sp,
          constraints: const BoxConstraints(),
          padding: EdgeInsets.all(15.r),
          icon: RotatedBox(
            quarterTurns: 1,
            child: SvgPicture.asset(
              AppAssets.seeMoreIcon,
              height: 20.sp,
              color: const Color(0xff062540),
            ),
          ),
        )
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
  final String? message;

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
          message ?? 'Hey there! I\'m...',
          style: TextStyle(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
