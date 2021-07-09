import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    //
    return ThemeData.light().copyWith(
      // fontFamily: 'Helvetica Neue Ultra Light',
      brightness: Brightness.light,
      primaryColor: AppColors.appColor,
      // accentColor: AppColors.,
      buttonColor: AppColors.appColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        // color: AppColors.appColor,
        backgroundColor: AppColors.appColor,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: AppDimen.fontSize24,
        ),
        textTheme: TextTheme(
          bodyText1: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          caption: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          button: AppTextStyle.buttonTextStyle(
            color: Colors.white,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline1: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline2: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline3: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline4: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline5: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline6: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          overline: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          subtitle1: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize20,
            fontWeight: FontWeight.w400,
          ),
          subtitle2: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize30,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.appColor,
        height: 45.h,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(.14);
              }

              return AppColors.lightAppColor;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (_) => AppTextStyle.buttonTextStyle(
              color: AppColors.whiteColor,
              fontSize: AppDimen.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.lightAppColor;
              }
              return AppColors.appColor;
            },
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.lightAppColor;
              }
              return AppColors.appColor;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.lightAppColor.withOpacity(.14);
              }

              return AppColors.appColor;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (_) => AppTextStyle.buttonTextStyle(
              color: AppColors.whiteColor,
              fontSize: AppDimen.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: AppColors.appColor,
      ),
      primaryTextTheme: TextTheme(
        bodyText1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        caption: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        button: AppTextStyle.buttonTextStyle(
          color: Colors.white,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline3: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline4: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline5: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline6: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        overline: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        subtitle2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
      ),
      textTheme: TextTheme(
        bodyText1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        caption: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        button: AppTextStyle.buttonTextStyle(
          color: Colors.white,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline3: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline4: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline5: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline6: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        overline: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        subtitle2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 3,
        ),
        prefixStyle: AppTextStyle.buttonTextStyle(
          color: AppColors.whiteColor,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: AppTextStyle.buttonTextStyle(
          color: AppColors.whiteColor,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.appColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.appColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.appColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.appColor,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white.withOpacity(0.85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.r),
            topRight: Radius.circular(23.r),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    //
    return ThemeData.dark().copyWith(
      // fontFamily: 'Helvetica Neue Ultra Light',
      brightness: Brightness.light,
      primaryColor: AppColors.appColor,
      // accentColor: AppColors.,
      buttonColor: AppColors.appColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        // color: AppColors.appColor,
        backgroundColor: AppColors.appColor,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: AppDimen.fontSize24,
        ),
        textTheme: TextTheme(
          bodyText1: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          caption: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          button: AppTextStyle.buttonTextStyle(
            color: Colors.white,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline1: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline2: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline3: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline4: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline5: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          headline6: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          overline: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          subtitle1: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
          subtitle2: AppTextStyle.buttonTextStyle(
            color: Colors.black,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.white,
        height: 45.h,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(.14);
              }

              return AppColors.lightAppColor;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (_) => AppTextStyle.buttonTextStyle(
              color: AppColors.whiteColor,
              fontSize: AppDimen.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.lightAppColor;
              }
              return AppColors.appColor;
            },
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.lightAppColor;
              }
              return AppColors.appColor;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.lightAppColor.withOpacity(.14);
              }

              return AppColors.appColor;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (_) => AppTextStyle.buttonTextStyle(
              color: AppColors.whiteColor,
              fontSize: AppDimen.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: AppColors.appColor,
      ),
      primaryTextTheme: TextTheme(
        bodyText1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        caption: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        button: AppTextStyle.buttonTextStyle(
          color: Colors.white,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline3: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline4: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline5: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        headline6: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        overline: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        subtitle2: AppTextStyle.buttonTextStyle(
          color: Colors.black,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.w400,
        ),
      ),
      textTheme: TextTheme(
        subtitle1: AppTextStyle.buttonTextStyle(
          color: AppColors.whiteColor,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 3,
        ),
        prefixStyle: AppTextStyle.buttonTextStyle(
          color: AppColors.whiteColor,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: AppTextStyle.buttonTextStyle(
          color: AppColors.whiteColor,
          fontSize: AppDimen.fontSize16,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.appColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.appColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.appColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.appColor,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white.withOpacity(0.85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.r),
            topRight: Radius.circular(23.r),
          ),
        ),
      ),
    );
  }
}
