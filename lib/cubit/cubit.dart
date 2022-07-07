import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/dio/Dio.dart';
import 'package:shop_app/models/shop_App/login_model.dart';
import 'package:shop_app/shared/end_pointes.dart';
class ShopCubit extends Cubit<ShopLoginStates>{
  ShopCubit():super (ShopLoginInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  LoginModel model;
  void userLogin({
    @required String email,
    @required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password': password,
        },
    ).then((value)
    {
      print(value.data);
      model= LoginModel.modelJson(value.data);
      print(model.data.token);
      print(model.status);
      print(model.message);
      emit(ShopLoginSuccessState(model));
    }).catchError((e){
      print(e.toString());
      emit(ShopLoginErrorState(e.toString()));
      print('======================================');
      print(e.toString());
      print('======================================');
    });
  }
}