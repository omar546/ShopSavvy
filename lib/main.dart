import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/modules/login/cubit/login_cubit.dart';
import 'package:shop_savvy/modules/login/cubit/login_states.dart';
import 'package:shop_savvy/shared/styles/styles.dart';
import 'bloc_observer.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'shared/network/remote/dio_helper.dart';


// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext ? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  // if main() is async and there is await down here it will wait for it to finish before launching app
  await Future.delayed(const Duration(milliseconds: 1000));
  Bloc.observer = MyBlocObserver();
  // await CacheHelper.init();
  // bool isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;

  runApp(
      const MyApp()
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
          create: (context) => ShopLoginCubit(ShopLoginInitialState())
        ),

      ],
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode:
            // NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}