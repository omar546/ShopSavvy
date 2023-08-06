import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/shared/cubit/cubit.dart';
import 'package:shop_savvy/shared/cubit/states.dart';
import 'package:shop_savvy/modules/login/login_screen.dart';
import 'package:shop_savvy/modules/search/search_screen.dart';
import 'package:shop_savvy/shared/network/local/cache_helper.dart';

import '../shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar:
              buildAppBar(context, title: MainAxisAlignment.start, actions: [
            IconButton(
              onPressed: () {
                navigateTo(context, SearchScreen(),);
              },
              icon: Icon(Icons.search_rounded),
            ),
            IconButton(
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
                icon: Icon(Icons.logout_rounded))
          ]),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,

            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home_rounded),
                icon: Icon(Icons.home_outlined),
            label:'Home',
            ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.category_rounded),
                icon:Icon(Icons.category_outlined),
            label:'Categories',
            ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite_rounded),
                icon: Icon(Icons.favorite_outline_rounded),
            label:'Favourites',
            ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
            label:'Settings',
            ),
            ],
          ),
        );
      },
    );
  }
}
