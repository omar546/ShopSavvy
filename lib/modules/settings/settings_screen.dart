import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/shared/components/components.dart';
import 'package:shop_savvy/shared/cubit/cubit.dart';
import 'package:shop_savvy/shared/cubit/states.dart';
import 'package:shop_savvy/shared/styles/colors.dart';

import '../../shared/network/local/cache_helper.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).profModel;
        nameController.text = model?.data?.name ?? '';
        emailController.text = model?.data?.email ?? '';
        phoneController.text = model?.data?.phone ?? '';

        return ConditionalBuilder(
          condition: ShopCubit.get(context).profModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                customForm(
                  isClickable: false,
                    context: context,
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not br empty';
                      }
                      return null;
                    },
                    prefix: Icons.person_outline_rounded),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                customForm(
                    isClickable: false,

                    context: context,
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'email must not br empty';
                      }
                      return null;
                    },
                    prefix: Icons.alternate_email_rounded),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                customForm(
                    isClickable: false,

                    context: context,
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone must not br empty';
                      }
                      return null;
                    },
                    prefix: Icons.phone_android_rounded),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text('LogOut'),
                      IconButton(
                          tooltip: 'LogOut',

                          onPressed: () {
                            CacheHelper.removeData(key: 'token').then((value) {
                              if (value) {
                                navigateAndFinish(
                                  context,
                                  LoginScreen(),
                                );
                              }
                            });
                          },
                          icon: Icon(Icons.logout_rounded,color: MyColors.fire,)),
                    ],
                  ),
                )
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
