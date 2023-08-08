import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/ui/pages/chat/chat_page.dart';
import 'package:relife/ui/widgets/back_button.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 44.0.h,
            ),
            _buildBackButtonAndTitle(context),
            SizedBox(
              height: 20.0.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.0.w, right: 12.0.w),
              child: _buildTextField(),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            const UserMessageContainer(
              personName: 'yash sharma',
              imgUrl: AppAssets.yash,
              isNew: true,
              message: 'that\'s true yaar',
              time: '2 min',
            ),
            SizedBox(
              height: 10.0.h,
            ),
            const UserMessageContainer(
              personName: 'yash sharma',
              imgUrl: AppAssets.yash,
              isNew: true,
              message: 'that\'s true yaar',
              time: '2 min',
            ),
            SizedBox(
              height: 10.0.h,
            ),
            const UserMessageContainer(
              personName: 'yash sharma',
              imgUrl: AppAssets.yash,
              isNew: false,
              message: 'that\'s true yaar',
              time: '2 min',
            ),
            SizedBox(
              height: 10.0.h,
            ),
            const UserMessageContainer(
              personName: 'yash sharma',
              imgUrl: AppAssets.yash,
              isNew: false,
              message: 'that\'s true yaar',
              time: '2 min',
            ),
            SizedBox(
              height: 10.0.h,
            ),
            const UserMessageContainer(
              personName: 'yash sharma',
              imgUrl: AppAssets.yash,
              isNew: false,
              message: 'that\'s true yaar',
              time: '2 min',
            ),
            SizedBox(
              height: 10.0.h,
            ),
            const UserMessageContainer(
              personName: 'yash sharma',
              imgUrl: AppAssets.yash,
              isNew: false,
              message: 'that\'s true yaar',
              time: '2 min',
            ),
            SizedBox(
              height: 10.0.h,
            ),
            const UserMessageContainer(
              personName: 'yash sharma',
              imgUrl: AppAssets.yash,
              isNew: false,
              message: 'that\'s true yaar',
              time: '2 min',
            )
          ],
        ),
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      //maxLength: 50,
      decoration: InputDecoration(
        hintText: 'search',
        hintStyle: TextStyle(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.only(
            left: 24.0.w, right: 24.0.w, top: 12.35.h, bottom: 14.69),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
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
            Text(
              'message',
              style: TextStyle(
                  fontSize: ViewHabitScreenTextStyle.headingSize,
                  fontWeight: ViewHabitScreenTextStyle.headingWeight,
                  color: const Color(0xff062540)),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
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

class UserMessageContainer extends StatelessWidget {
  final String personName, message, time, imgUrl;
  final bool isNew;

  const UserMessageContainer({
    Key? key,
    required this.personName,
    required this.message,
    required this.time,
    required this.isNew,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0.w, right: 12.0.w),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatPage(personName: personName, profileImgUrl: imgUrl)));
        },
        child: Container(
          //height: 80.h,
          padding: EdgeInsets.all(6.0.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0.h, left: 8.0.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2.r, color: const Color(0xffFA8A3C)),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            height: 36.0.r,
                            width: 36.0.r,
                            child: Image.asset(
                              imgUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    SizedBox(
                      width: 230.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            personName,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            message,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.0.h),
                          Text(
                            time,
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color(0xff062540).withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isNew)
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'new',
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffFA8A3C)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
