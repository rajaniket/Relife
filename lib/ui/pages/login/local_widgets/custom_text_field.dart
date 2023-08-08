import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/colors.dart';

Widget customTextField({
  required String hintText,
  TextInputType? keyboard,
  required final bool isObscure,
  required Function(String?) onSaved,
  required String? Function(String?) validator,
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    onChanged: onSaved,
    validator: validator,
    keyboardType: keyboard,
    obscureText: isObscure,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: 17.w, top: 16.h, bottom: 13.h),
      hintText: hintText,
      hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0.sp),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.textFieldBorderColor, width: 1.0.r),
        borderRadius: BorderRadius.circular(10.r),
      ),
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.textFieldBorderColor, width: 0.5.r),
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}





// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final TextInputType keyboard;
//   final bool isObscure;

//   const CustomTextField({
//     Key? key,
//     required this.hintText,
//     required this.keyboard,
//     required this.isObscure,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onSaved: (val) {},
//       validator: (val) {},
//       keyboardType: keyboard,
//       obscureText: isObscure,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(left: 17.w, top: 16.h, bottom: 13.h),
//         hintText: hintText,
//         hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0.sp),
//         focusedBorder: OutlineInputBorder(
//           borderSide:
//               BorderSide(color: AppColors.textFieldBorderColor, width: 1.0.r),
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         border: OutlineInputBorder(
//           borderSide:
//               BorderSide(color: AppColors.textFieldBorderColor, width: 0.5.r),
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//       ),
//     );
//   }
// }

