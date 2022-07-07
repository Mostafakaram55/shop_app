import 'package:shop_app/models/shop_App/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterinitialState  extends ShopRegisterStates{}

class ShopRegisterLoadingState  extends ShopRegisterStates{}

class ShopRegisterSuccessState  extends ShopRegisterStates{
  final LoginModel model;
  ShopRegisterSuccessState(this.model);
}
class ShopRegisterErrorState  extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}