import 'package:flutter/material.dart';

import '../styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

Widget customButton(
    {required final String text,
    required BuildContext context,
    double widthRatio = double.infinity,
    double height = 50.0,
    required final VoidCallback onPressed}) {
  return SizedBox(
    height: height,
    width: MediaQuery.of(context).size.width * widthRatio,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(), backgroundColor: MyColors.fire),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'bitter-bold',
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    ),
  );
}

Widget customForm({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType type,
  dynamic onSubmit,
  dynamic onChange,
  dynamic onTap,
  bool isPassword = false,
  dynamic validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  dynamic suffixPressed,
  bool isClickable = true,
  IconButton? suffixIcon,
}) {
  return TextFormField(
    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    validator: validate,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: suffixPressed,
        icon: Icon(
          suffix,
        ),
      )
          : null,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: MyColors.greyColor,
          width: 2.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.fire,
        ),
      ),
    ),
  );
}

Widget customTextButton({
  required String text,
  required dynamic onPressed,
  Color color = MyColors.fire,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(color: color),
    ),
  );
}

