import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/model/service%20model/update_profile_model.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/providers/update_profile_provider.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';

class EditProfilePage extends StatefulWidget {
  final String aboutYou;
  const EditProfilePage({Key? key, required this.aboutYou}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //TextEditingController bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final updateProvider =
        Provider.of<UpdateProfileProvider>(context, listen: false);
    final getprofile = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 44.0.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: _buildBackButton(context),
            ),
            SizedBox(
              height: 28.0.h,
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: _buildTextField(updateProvider.updateProfileModel),
            ),
            SizedBox(
              height: 15.h,
            ),
            _buildButton(context, updateProvider, getprofile),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return RoundBackButton(
      onPressed: () {
        Navigator.pop(context);
      },
      backgroundColour: Colors.white,
    );
  }

  Padding _buildButton(BuildContext context, UpdateProfileProvider model,
      ProfileProvider profileModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 93.0.w),
      child: CustomTextButton(
        message: 'save',
        fontSize: SuccessScreenTextStyle.buttonTextSize,
        fontWeight: SuccessScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 12.0.sp,
        elevation: 0,
        onTap: () async {
          await model.updateProfile();
          profileModel.getProfile(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('profile updated'),
              backgroundColor: Color(0xffDF532B),
              duration: Duration(milliseconds: 600),
            ),
          );
          // Fluttertoast.showToast(
          //   msg: 'profile updated',
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        },
      ),
    );
  }

  _buildTextField(UpdateProfileModel updateProfileModel) {
    return TextFormField(
      //controller: bioController,
      initialValue: widget.aboutYou,
      maxLines: 10,
      onChanged: (bio) {
        updateProfileModel.bio = bio;
      },
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.only(
            left: 24.0.w, right: 24.0.w, top: 24.0.h, bottom: 24.0.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
