import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/models/login_model.dart';
import 'package:shop_savvy/modules/login/cubit/login_states.dart';
import 'package:shop_savvy/shared/network/end_points.dart';
import 'package:shop_savvy/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit(super.initialState);

static ShopLoginCubit get(context) => BlocProvider.of(context);

late LoginModel loginModel;

void userLogin({
  required String email,
  required String password,
})
{
  emit(ShopLoginLoadingState());

  DioHelper.postData(url: LOGIN, data:
  {
   'email':email,
    'password':password,
  }).then((value){
    if (kDebugMode) {
      print(value.data);
    }
    loginModel = LoginModel.formJson(value.data);
    emit(ShopLoginSuccessState(loginModel));
  }).catchError((error){
    if (kDebugMode) {
      print(error.toString());
    }
    emit(ShopLoginErrorState(error.toString()));
  });
}
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopChangePasswordVisibilityState());
  }


}
