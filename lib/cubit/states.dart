
import 'package:shop_app/models/shop_App/login_model.dart';
abstract class ShopLoginStates{}
class ShopLoginInitialState  extends ShopLoginStates{}
class ShopLoginLoadingState  extends ShopLoginStates{}
class ShopLoginSuccessState  extends ShopLoginStates{
  final LoginModel model;
  ShopLoginSuccessState(this.model);
}
class ShopLoginErrorState  extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}