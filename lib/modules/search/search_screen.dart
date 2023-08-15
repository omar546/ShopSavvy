import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/modules/search/cubit/search_cubit.dart';
import 'package:shop_savvy/modules/search/cubit/search_states.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(
              context,
              automaticallyImplyLeading: true,
              showBrand: false,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    customForm(
                        context: context,
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value.isEmpty!) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search_rounded,
                      onSubmit: (text)
                      {
                        SearchCubit.get(context).search(text);
                      }
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProducts(isOldPrice: false,
                              SearchCubit.get(context).model.data?.data![index]
                              ,
                              context),
                          separatorBuilder: (context, index) => Container(
                            height: MediaQuery.of(context).size.height * 0.001,
                            color: MyColors.greyColor,
                          ),
                          itemCount:
                          SearchCubit.get(context).model.data?.data?.length ??
                              0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
