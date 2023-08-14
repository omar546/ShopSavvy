import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/layout/shop_layout.dart';
import 'package:shop_savvy/modules/login/cubit/login_cubit.dart';
import 'package:shop_savvy/modules/login/cubit/login_states.dart';
import 'package:shop_savvy/shared/components/constants.dart';
import 'package:shop_savvy/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(ShopLoginInitialState()),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status ?? false) {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                    token = state.loginModel.data?.token??'';
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  message: state.loginModel.message ?? '',
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Join now to browse our hot offers!',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        customForm(
                          context: context,
                          label: 'Email Address',
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          onSubmit: (String value) {
                            print(value);
                          },
                          onChange: (String value) {
                            print(value);
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "email..please!";
                            } else {
                              return null;
                            }
                          },
                          prefix: Icons.alternate_email_rounded,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        customForm(
                          context: context,
                          label: 'Password',
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          onChange: (String value) {
                            print(value);
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "forgot your password!";
                            } else {
                              return null;
                            }
                          },
                          prefix: Icons.password_rounded,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Center(
                          child: ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => customButton(
                                  widthRatio: 0.6,
                                  context: context,
                                  text: "LOGIN",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  }),
                              fallback: (context) =>
                                  const CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            customTextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'REGISTER',
                              color: Colors.lightBlue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
