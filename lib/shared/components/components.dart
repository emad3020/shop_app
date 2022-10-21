import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/toast_type.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType inputType,
  required FormFieldValidator<String> validator,
  required String hintText,
  bool isPassword = false,
  bool focusInTouchMode = false,
  Widget? prefixIcon,
  IconData? suffixIcon,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onTextChanged,
  Function()? onSuffixPressed,
  Function()? onTap,
}) =>
    TextFormField(
        validator: validator,
        controller: controller,
        readOnly: focusInTouchMode,
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(),
          prefixIcon: prefixIcon != null ? prefixIcon : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onSuffixPressed,
                  icon: Icon(suffixIcon),
                )
              : null,
        ),
        keyboardType: inputType,
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        onChanged: onTextChanged,
        onTap: onTap);
Widget defaultButton({
  double width = double.infinity,
  double height = 40.0,
  Color background = Colors.blue,
  bool textAllCaps = true,
  double cornerRadius = 20,
  required Function() onPressed,
  required String title,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius), color: background),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          textAllCaps ? title.toUpperCase() : title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextButton({
  required Function() onPressed,
  required String title,
  Color? textColor,
  double? textSize,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
          fontFamily: 'cairo',
        ),
      ),
    );

void navigateTo(context, destination) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );

void navigateAndFinish(context, destination) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => destination),
      (route) => false,
    );

void showToast({required String message, ToastType type = ToastType.NORMAL}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: ToastTypeFactory(type: type).getColor(),
      textColor: Colors.white,
      fontSize: 16.0,
    );
