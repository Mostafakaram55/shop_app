import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/registerstates.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/dio/Dio.dart';
import 'package:shop_app/models/shop_App/login_model.dart';
import 'package:shop_app/shared/end_pointes.dart';
class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super (ShopRegisterinitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  LoginModel model;
  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'name':name,
        'email':email,
        'password': password,
        'phone': phone,
      },
    ).then((value)
    {
      print(value.data);
      model= LoginModel.modelJson(value.data);
      print(model.data.token);
      print(model.status);
      print(model.message);
      emit(ShopRegisterSuccessState(model));
    }).catchError((e){
      print(e.toString());
      emit(ShopRegisterErrorState(e.toString()));
    });
  }
}