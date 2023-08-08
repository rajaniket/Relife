// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getsocial_flutter_sdk/common/pagingquery.dart';
import 'package:getsocial_flutter_sdk/communities.dart';
import 'package:getsocial_flutter_sdk/communities/queries/usersquery.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';
import 'package:relife/providers/get_user_all_habits_provider.dart';
import 'package:relife/providers/page_provider/habit_tab_provider.dart';
import 'package:relife/providers/post_create_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/success/success_page.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({Key? key, required this.topic, required this.detail})
      : super(key: key);
  final String topic;
  final Detail detail;

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage>
    with AutomaticKeepAliveClientMixin {
  String? _typedText = "";
  String userName = "";
  int rank = 0;
  late TextEditingController _textEditingController;
  bool? result;
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  ScrollController scrollController = ScrollController();
  List<Map<String, dynamic>> mentionData = [];
  Future<File?> _cropImage(filepath) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: filepath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.ratio4x3,
        ],
        androidUiSettings: const AndroidUiSettings(hideBottomControls: true));
    return croppedImage;
  }

  Future pickImageFromGallary() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 35);
      if (image == null) return;
      final imagePath = File(image.path);

      final croppedImage = await _cropImage(imagePath.path);

      Provider.of<PostCreateProvider>(context, listen: false)
          .setImagePath(croppedImage);
    } on PlatformException catch (e) {
      // print("error $e");
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 40);
      if (image == null) return;
      final imagePath = File(image.path);
      final croppedImage = await _cropImage(imagePath.path);
      Provider.of<PostCreateProvider>(context, listen: false)
          .setImagePath(croppedImage);
    } on PlatformException catch (e) {
      // debugPrint("error $e");
    }
  }

  Future<void> onShare() async {
    result = await Provider.of<PostCreateProvider>(context, listen: false)
        .sharePost(topic: widget.topic, properties: {
      "streak": (widget.detail.currentStreak + 1).toString()
    });
    log(" post result : $result ---------");
    if (result == true) {
      // Fluttertoast.showToast(
      //   msg: 'your post was shared',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
      _typedText = '';
    } else {
      Fluttertoast.showToast(
        msg: 'your post could not be shared',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    userName = profileProvider.firstName;
    for (var i = 0; i < profileProvider.rankingList.length; i++) {
      if (widget.detail.habitDetails.name ==
          profileProvider.rankingList[i].habitName) {
        rank = profileProvider.rankingList[i].rank;
      }
    }
    _textEditingController = TextEditingController();
    // scrollController.animateTo(offset, duration: duration, curve: curve)

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffF7F6F2),
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
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5.0.h,
              ),
              _buildBackButtonAndTitle(context),
              SizedBox(
                height: 17.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 29.0.w),
                child: Text(
                  'tell us about today, $userName',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 21.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 33.0.w),
                child: Text(
                  '👉🏻 something you learned\n👉🏻 any difficulties you faced\n👉🏻 your experience',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 21.0.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: _buildTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextField() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlutterMentions(
            key: key,
            // controller: _textEditingController,
            suggestionListDecoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            onChanged: (text) {
              // _typedText = text.trim();
              // if (_typedText != "" && _typedText != null) {
              //   Provider.of<PostCreateProvider>(context, listen: false)
              //       .setText(_typedText);
              //   // print(_typedText);
              // }
            },
            suggestionPosition: SuggestionPosition.Top,
            suggestionListHeight: 200,
            minLines: 3,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'what\'s on your mind?',
              hintStyle: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.only(
                  left: 24.0.w, right: 24.0.w, top: 30.h, bottom: 0.0.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.r),
                borderSide: BorderSide.none,
              ),
              filled: false,
              fillColor: Colors.white,
            ),

            onMentionAdd: (data) {},
            onMarkupChanged: (val) {
              _typedText = val.trim();
              if (_typedText != "" && _typedText != null) {
                Provider.of<PostCreateProvider>(context, listen: false)
                    .setText(_typedText);
              }
            },
            onSearchChanged: (val1, val2) {
              var query = UsersQuery.find(val2);
              var pagingQuery = PagingQuery(query);
              pagingQuery.limit = 20;
              Communities.findUsers(pagingQuery).then((result) {
                var userList = result.entries;

                print(userList);
                for (var userDetail in userList) {
                  if (!(mentionData.any((e) => e["id"] == userDetail.userId))) {
                    mentionData.add({
                      'id': userDetail.userId,
                      'display': userDetail.displayName,
                      'full_name': userDetail.displayName,
                      'photo': userDetail.avatarUrl,
                    });
                  }
                }
                setState(() {});
              }).catchError(
                  (error) => print('Failed to find users, error: $error'));
            },

            mentions: [
              Mention(
                trigger: '@',
                style: const TextStyle(
                  color: Color(0xff062540),
                  fontWeight: FontWeight.w500, //Color(0xffFA8A3C),
                ),
                disableMarkup: false,
                data: mentionData.toList(),
                matchAll: false,
                suggestionBuilder: (data) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffFA8A3C),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                            data['photo'],
                          ),
                        ),
                      ),
                      title: Text(data['full_name']),
                    ),
                  );
                },
              ),
              // Mention(
              //   trigger: '#',
              //   disableMarkup: true,
              //   style: const TextStyle(
              //     color: Colors.blue,
              //   ),
              //   data: [
              //     {'id': 'reactjs', 'display': 'reactjs'},
              //     {'id': 'javascript', 'display': 'javascript'},
              //   ],
              //   matchAll: true,
              // )
            ],
          ),
          if (Provider.of<PostCreateProvider>(context, listen: true)
                  .imagePath !=
              null)
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 31.h, left: 12.w, right: 12.w, bottom: 31.h),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.file(
                          Provider.of<PostCreateProvider>(context, listen: true)
                              .imagePath!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15.w,
                      top: 12.w,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<PostCreateProvider>(context,
                                  listen: false)
                              .setImagePath(null);
                        },
                        child: SimpleShadow(
                          child: const Icon(
                            Icons.highlight_remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          if (Provider.of<PostCreateProvider>(context, listen: true)
                  .imagePath ==
              null)
            Padding(
              padding: EdgeInsets.only(right: 10.0.r, bottom: 6.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      pickImageFromGallary();
                    },
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30.r,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pickImageFromCamera();
                    },
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                      size: 30.r,
                    ),
                  ),
                ],
              ),
            ),
          // if (imagePath != null)
          //   SizedBox(
          //     width: 200,
          //     height: 200,
          //     child: Image.file(
          //       imagePath,
          //       fit: BoxFit.cover,
          //     ),
          //   )
        ],
      ),
    );
  }

  Widget _buildBackButtonAndTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColour: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: TextButton(
            onPressed: (Provider.of<PostCreateProvider>(context, listen: false)
                            .imagePath ==
                        null &&
                    (Provider.of<PostCreateProvider>(context, listen: false)
                                .text ==
                            null &&
                        Provider.of<PostCreateProvider>(context, listen: false)
                                .text ==
                            ""))
                ? () {
                    null;
                  }
                : () async {
                    FocusManager.instance.primaryFocus
                        ?.unfocus(); // for keyboard
                    CustomProgressIndicator().buildShowDialog(context);
                    await onShare();
                    await Provider.of<HabitTabProvider>(context, listen: false)
                        .getHabitTabData(context: context); // update habits
                    Navigator.pop(context);
                    if (result == true) {
                      // _textEditingController.clear();
                      key.currentState!.controller!.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SuccessPage(
                            detail: widget.detail,
                          ),
                        ),
                      );
                    }
                  },
            child: Text(
              'share',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffFA8A3C)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
