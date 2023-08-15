import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/models/search_model.dart';
import 'package:shop_savvy/modules/search/cubit/search_states.dart';
import 'package:shop_savvy/shared/components/constants.dart';
import 'package:shop_savvy/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH,token: token, data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(SearchErrorState());
    });
  }
}
