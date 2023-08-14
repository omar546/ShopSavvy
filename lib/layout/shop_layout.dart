import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/shared/cubit/cubit.dart';
import 'package:shop_savvy/shared/cubit/states.dart';
import 'package:shop_savvy/modules/search/search_screen.dart';

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
              tooltip: 'Search',
              onPressed: () {
                navigateTo(context, SearchScreen(),);
              },
              icon: Icon(Icons.search_rounded),
            ),
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
                activeIcon: Icon(Icons.shopping_bag),
                icon: Icon(Icons.shopping_bag_outlined),
            label:'Shop',
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
