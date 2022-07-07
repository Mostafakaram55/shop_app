import 'package:shop_app/models/shop_App/addfavoritemodel.dart';
import 'package:shop_app/models/shop_App/login_model.dart';
import 'package:shop_app/models/shop_App/ordersmodel.dart';

abstract class ShopStates{}

 class ShopInitialState extends ShopStates{}

 class ShopChangeState extends ShopStates{}

 class ShopLoadingHomeStates extends ShopStates{}

 class ShopSuccessHomeStates extends ShopStates{}

 class ShopErrorHomeStates extends ShopStates{
 final error;
  ShopErrorHomeStates(this.error);
 }

class ShopLoadingCategoriesStates extends ShopStates{}

class ShopSuccessCategoriesStates extends ShopStates{}

class ShopErrorCategoriesStates extends ShopStates{
 final error;
 ShopErrorCategoriesStates(this.error);
}

class ShopFavoritesStates extends ShopStates{}

class ShopSuccessFavoritesStates extends ShopStates{
 final ChangeFavoriteModel model;

  ShopSuccessFavoritesStates(this.model);
}

class ShopErrorFavoritesStates extends ShopStates{
 final error;
 ShopErrorFavoritesStates(this.error);
}

class ShopLoadingGetFavoritesStates extends ShopStates{}

class ShopSuccessGetFavoritesStates extends ShopStates{}


class ShopErrorGetFavoritesStates extends ShopStates{
 final error;
 ShopErrorGetFavoritesStates(this.error);
}

class ShopLoadingUserDataStates extends ShopStates{}

class ShopSuccessUserDataStates extends ShopStates{
 final LoginModel loginModel;

  ShopSuccessUserDataStates(this.loginModel);
}

class ShopErrorUserDataStates extends ShopStates{
 final error;
 ShopErrorUserDataStates(this.error);
}

class ShopLoadingGetProductDetailsStates extends ShopStates{}

class ShopSuccessGetProductDetailsStates extends ShopStates{}


class ShopErrorGetProductDetailsStates extends ShopStates{
 final error;
 ShopErrorGetProductDetailsStates(this.error);
}

class ShopOnPageChangeStates extends ShopStates{}
class ShopLoadingAddAndRemoveFromCartStates extends ShopStates{}
class ShopSuccessAddAndRemoveFromCartStates extends ShopStates{}

class ShopErrorAddAndRemoveFromCartStates extends ShopStates{
 final error;

  ShopErrorAddAndRemoveFromCartStates(this.error);
}
class ShopLoadingGetCartStates extends ShopStates{}
class ShopSuccessGetCartStates extends ShopStates{}

class ShopErrorGetCartStates extends ShopStates{
 final error;

 ShopErrorGetCartStates(this.error);
}
class ShopSuccessAddQuantityStates extends ShopStates{}
class ShopErrorAddQuantityStates extends ShopStates{}

////////////////////////////////

class ShopLoadingAddAddressState extends ShopStates {}

class ShopSuccessAddAddressState extends ShopStates {}

class ShopErrorAddAddressState extends ShopStates {
 final String error;

 ShopErrorAddAddressState(this.error);
}

class ShopLoadingAddOrderState extends ShopStates {}

class ShopSuccessAddOrderState extends ShopStates {
 final OrdersModel ordersModel;

  ShopSuccessAddOrderState(this.ordersModel);
}

class ShopErrorAddOrderState extends ShopStates {
 final String error;

 ShopErrorAddOrderState(this.error);
}
///////////////////////////////////////////

class SearchLoadingState extends ShopStates{}
class SearchSuccessState extends ShopStates{}
class SearchErrorState extends ShopStates{
 final error;

 SearchErrorState(this.error);
}
///////////////////////////

class ShopLoadingGetOrdersState extends ShopStates{}
class ShopSuccessGetOrdersState extends ShopStates{}
class ShopErrorGetOrdersState extends ShopStates {
 final String error;

 ShopErrorGetOrdersState(this.error);
}

class ShopSuccessCancelOrderState extends ShopStates{}
class ShopErrorCancelOrderState extends ShopStates{}
