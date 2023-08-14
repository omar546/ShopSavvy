import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/layout/shop_layout.dart';
import 'package:shop_savvy/modules/login/cubit/login_cubit.dart';
import 'package:shop_savvy/modules/login/cubit/login_states.dart';
import 'package:shop_savvy/modules/login/login_screen.dart';
import 'package:shop_savvy/shared/components/constants.dart';
import 'package:shop_savvy/shared/styles/styles.dart';
import 'bloc_observer.dart';
import 'shared/cubit/cubit.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext ? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
void main() async {
  // just to show branding
  await Future.delayed(const Duration(milliseconds: 750));
  // if main() is async and there is await down here it will wait for it to finish before launching app
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token') ?? 'null';
  if (kDebugMode) {
    print(token);
  }

  if(onBoarding != false)
  {
    if(token!= 'null'){
      widget = const ShopLayout();
    }else
    {
      widget = LoginScreen();
    }
  }else
  {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp(this.startWidget, {super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopLoginCubit(ShopLoginInitialState())),
        BlocProvider(
            create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavData()..getProfData()
        ),
      ],
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode:
            // NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:startWidget,
          );
        },
      ),
    );
  }
}
