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
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  SettingsScreen({super.key});

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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateProfDataState)
                    const LinearProgressIndicator(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  customForm(
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
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  customForm(
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
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  customForm(
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
                        // Spacer(),
                        const Text('Edit'),
                        IconButton(
                            tooltip: 'Edit',
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                ShopCubit.get(context).updateProfData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: MyColors.fire,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('LogOut'),
                        IconButton(
                            tooltip: 'LogOut',
                            onPressed: () {
                              CacheHelper.removeData(key: 'token')
                                  .then((value) {
                                if (value) {
                                  navigateAndFinish(
                                    context,
                                    LoginScreen(),
                                  );
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.logout_rounded,
                              color: MyColors.fire,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
