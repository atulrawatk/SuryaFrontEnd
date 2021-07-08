// import 'package:flutter/material.dart';

// class Validators {
//   const Validators._();

//   static String validateEmpty(String v) {
//     if (v.isEmpty) {
//       return Strings.fieldCantBeEmpty;
//     } else {
//       return null;
//     }
//   }

//   static const Pattern patternNameOnlyChar =
//       r'^[A-Za-z ]+(?:[ _-][A-Za-z ]+)*$';
//   static const Pattern passwordMinLen8withCamelAndSpecialChar =
//       r'^((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,20})';
//   static const Pattern passwordMinLen8withLowerCaseAndSpecialChar =
//       r'^((?=.*\d)(?=.*[a-z])(?=.*[\W_]).{8,20})';
//   static const Pattern patternEmail =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   static const Pattern patternPhone = r'^(?:[+0]9)?[0-9]{11}$';

//   static bool hasMatch(String value, String pattern) {
//     return (value == null) ? false : RegExp(pattern).hasMatch(value);
//   }

//   static bool hasLength(dynamic value) {
//     return value is Iterable || value is String || value is Map;
//   }

//   static bool dateTime(String s) =>
//       hasMatch(s, r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$');
//   //
//   static String userName(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 3) {
//       return Strings.errorFullName;
//     } else {
//       return null;
//     }
//   }

//   static String address(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 3) {
//       return Strings.errorAddress;
//     } else {
//       return null;
//     }
//   }

//   static String city(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 3) {
//       return Strings.errorCity;
//     } else {
//       return null;
//     }
//   }

//   static String state(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 3) {
//       return Strings.errorState;
//     } else {
//       return null;
//     }
//   }

//   static String mobileNumber(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 10) {
//       return Strings.errorMobileNumber;
//     } else {
//       return null;
//     }
//   }

//   static String postalCode(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 6) {
//       return Strings.errorPostalCode;
//     } else {
//       return null;
//     }
//   }

//   static String startDate(dynamic value) {
//     if (hasMatch(value, r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$')) {
//       return 'Please select date!';
//     } else {
//       return null;
//     }
//   }

//   static String endDate(dynamic value) {
//     if (hasMatch(value, r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$')) {
//       return 'Please select date!';
//     } else {
//       return null;
//     }
//   }

//   static String vehicleNumber(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 10) {
//       return Strings.errorVehicleNumber;
//     } else {
//       return null;
//     }
//   }

//   static String vehicleModelName(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 3) {
//       return Strings.errorVehicleModelName;
//     } else {
//       return null;
//     }
//   }

//   static String vehicleColor(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 3) {
//       return Strings.errorVehicleColor;
//     } else {
//       return null;
//     }
//   }

//   static String bankName(String value) {
//     if (value.isEmpty) {
//       return Strings.errorBankName;
//     } else {
//       return null;
//     }
//   }

//   static String branchName(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 3) {
//       return Strings.errorVehicleColor;
//     } else {
//       return null;
//     }
//   }

//   // hasMatch(input, '[0-9]{9,18}')

//   static String accountNumber(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (!hasMatch(value, '[0-9]{9,18}')) {
//       return Strings.errorAccountNumber;
//     } else {
//       return null;
//     }
//   }

//   static String reaccountCheck(
//     String input,
//     String value,
//   ) {
//     if (input.isEmpty) {
//       return 'Field is empty!';
//     } else if (input != value) {
//       return Strings.errorReAccountNumber;
//     } else {
//       return null;
//     }
//   }

//   static String ifscCode(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 3) {
//       return Strings.errorIfscCode;
//     } else {
//       return null;
//     }
//   }

//   static String passwordCheck(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else if (value.length < 8) {
//       return Strings.errorPassword;
//     } else {
//       return null;
//     }
//   }

//   static String repasswordCheck(
//     String input,
//     String value,
//   ) {
//     if (input.isEmpty) {
//       return 'Field is empty!';
//     } else if (input != value) {
//       return Strings.errorRePassword;
//     } else {
//       return null;
//     }
//   }

//   static String amount(String value) {
//     if (value.isEmpty) {
//       return 'Field is empty!';
//     } else {
//       return null;
//     }
//   }
// }
