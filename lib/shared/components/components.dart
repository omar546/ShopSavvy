import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/cubit.dart';
import '../styles/colors.dart';

AppBar buildAppBar(
  BuildContext context, {
  bool automaticallyImplyLeading = false,
      MainAxisAlignment title = MainAxisAlignment.center,
      List<Widget>? actions,
      bool showBrand = true,
  }) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    elevation: 0.0,
    title: Visibility(
      visible: showBrand,
      child: Row(
        mainAxisAlignment: title,
        children: const [
          Text(
            'Shop',
            style: TextStyle(fontSize: 30, fontFamily: 'bebas'),
          ),
          Text(
            'Savvy',
            style: TextStyle(fontSize: 30, fontFamily: 'futura'),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
    actions: actions,
  );
}

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
    enabled: isClickable,
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

void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildListProducts( model, BuildContext context,{bool isOldPrice =true,}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: MediaQuery.of(context).size.height * 0.15,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model?.image ?? ''),
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.24,
            ),
            if (model?.discount != 0)
              Container(
                color: MyColors.fire,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  'OFFER',
                  style: TextStyle(
                    fontSize: 9,
                    color: MyColors.whiteColor,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model?.name?.toUpperCase() ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, height: 1.2),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model?.price!.round()}',
                    style: const TextStyle(
                        fontSize: 12, height: 1.2, color: MyColors.fire),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model?.discount != 0 && isOldPrice)
                    Text(
                      '${model?.oldPrice!.round()}',
                      style: const TextStyle(
                          fontSize: 10,
                          height: 1.2,
                          color: MyColors.greyColor,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: MyColors.fire),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context)
                          .changeFavourites(model!.id!);
                      if (kDebugMode) {}
                    },
                    tooltip: 'favourite',
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: ShopCubit.get(context)
                          .favourites[model?.id] ??
                          false
                          ? MyColors.fire
                          : MyColors.greyColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

