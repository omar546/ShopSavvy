

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/shared/styles/styles.dart';

import 'bloc_observer.dart';
import 'layout/news_layout.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/colors.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext ? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // if main() is async and there is await down here it will wait for it to finish before launching app

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  // await CacheHelper.init();
  // bool isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  // const MyApp(this.isDark, {super.key});
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),

      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            title: 'PressPulse',
            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode:
            // NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}