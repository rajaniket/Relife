import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:relife/constants/assets.dart';

class _Message {
  int whom; // will tack care of client and user side , 0 for user 1 for client
  String text, time;

  _Message(this.whom, this.text, this.time);
}

class ChatPage extends StatefulWidget {
  final String profileImgUrl, personName;
  const ChatPage(
      {Key? key, required this.profileImgUrl, required this.personName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const clientID = 0;
  List<_Message> messages = List<_Message>.empty(growable: true);
  final ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14.0),
                child: Text(_message.text,
                    style: const TextStyle(
                      color: Colors.black,
                    )),
                margin:
                    const EdgeInsets.only(bottom: 8.0, left: 0.0, right: 0.0),
                width: 220.0.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
              ),
            ],
          )
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h, left: 10.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                    ),
                    splashRadius: 25.r,
                    constraints: const BoxConstraints(),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(child: _buildProfileRow()),
              ],
            ),
          ),
          SizedBox(
            width: 5.h,
          ),
          Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  controller: listScrollController,
                  children: list))
        ],
      ),
    );
  }

  Row _buildProfileRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2.r, color: const Color(0xffFA8A3C)),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: SizedBox(
                  height: 48.0.r,
                  width: 48.0.r,
                  child: Image.asset(
                    widget.profileImgUrl,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              widget.personName,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff062540)),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          splashRadius: 20.sp,
          constraints: const BoxConstraints(),
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
