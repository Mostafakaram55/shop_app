import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/dio/Dio.dart';
import 'package:shop_app/models/addressmodel.dart';
import 'package:shop_app/models/shop_App/Categoriesmodel.dart';
import 'package:shop_app/models/shop_App/add_vart_model.dart';
import 'package:shop_app/models/shop_App/addfavoritemodel.dart';
import 'package:shop_app/models/shop_App/favoritemodel.dart';
import 'package:shop_app/models/shop_App/get_cart_model.dart';
import 'package:shop_app/models/shop_App/homemodel.dart';
import 'package:shop_app/models/shop_App/login_model.dart';
import 'package:shop_app/models/shop_App/ordersmodel.dart';
import 'package:shop_app/models/shop_App/product_details_model.dart';
import 'package:shop_app/models/shop_App/searchmodel.dart';
import 'package:shop_app/modules/categoriesscreen/categories.dart';
import 'package:shop_app/modules/favoritescreen/favorite.dart';
import 'package:shop_app/modules/help/help_screen.dart';
import 'package:shop_app/modules/productscreen/products.dart';
import 'package:shop_app/modules/settingsscreen/settings.dart';
import 'package:shop_app/shared/end_pointes.dart';
import 'package:shop_app/shooCupit/shopstates.dart';

class yoracubit extends Cubit<ShopStates> {
  yoracubit() : super(ShopInitialState());

  static yoracubit get(context) => BlocProvider.of(context);

  int currentPage = 0;
  dynamic x;
  dynamic t;
  dynamic z;

  void changePage(int index) {
    currentPage = index;
    emit(ShopChangeState());
  }

  List<Widget> screens = [
    Products(),
    Categories(),
    Favorite(),
    Settings(),
  ];

  void imagee() {
    ImagePicker y = ImagePicker();
    z = y.getImage(source: ImageSource.camera);
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getDataHome() {
    emit(ShopLoadingHomeStates());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJason(value.data);
      print(homeModel.status);
      //print(homeModel.data.banners[0].image);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
      });
      homeModel.data.products.forEach((element) {
        cart.addAll({element.id: element.in_cart});
      });
      print("+=================================");
      print(cart.length);
      print("+=================================");
      emit(ShopSuccessHomeStates());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorHomeStates(e));
    });
  }

  CategoriesModel categoriesModel;

  void getDataCategories() {
    emit(ShopLoadingCategoriesStates());

    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJason(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorCategoriesStates(e));
    });
  }

  ChangeFavoriteModel addFavorite;

  void changeFavorites(int productId) {
    favorites[productId] =
    !favorites[productId]; //حط عكس القيمة بتاعتي قبل ما ادخل علي dio

    emit(ShopFavoritesStates());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      addFavorite = ChangeFavoriteModel.fromJason(value.data);
      print(value.data);
      if (!addFavorite.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessFavoritesStates(addFavorite));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorFavoritesStates(error));
    });
  }

  favoritemodel getfavorite;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      getfavorite = favoritemodel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorGetFavoritesStates(e));
    });
  }

  LoginModel loginModel;

  void getProfile() {
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      loginModel = LoginModel.modelJson(value.data);
      print(loginModel.data.name);
      print(loginModel.data.id);
      print(loginModel.data.phone);
      print(loginModel.data.email);
      emit(ShopSuccessUserDataStates(loginModel));
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorUserDataStates(e));
    });
  }

  ProductDetailModel productDetailModel;

  void getProductDetails({@required int id}) {
    emit(ShopLoadingGetProductDetailsStates());
    DioHelper.getData(
      url: 'products/$id',
      token: token,
    ).then((value) {
      productDetailModel = ProductDetailModel.fromJson(value.data);
      emit(ShopSuccessGetProductDetailsStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProductDetailsStates(error.toString()));
    });
  }

  int activeIndex = 0;

  void onPageChange({@required int index}) {
    activeIndex = index;
    emit(ShopOnPageChangeStates());
  }

  Map<int, bool> cart = {};

  AddCartModel addCartModel;

  void addAndRemoveFromCart(int productId) {
    cart[productId] =
    !cart[productId]; //حط عكس القيمة بتاعتي قبل ما ادخل علي dio
    emit(ShopLoadingAddAndRemoveFromCartStates());
    DioHelper.postData(
      url: CARTS,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      addCartModel = AddCartModel.fromJson(value.data);
      print("+=================================");
      print(value.data['message']);
      print(cart.length);
      print("+=================================");
      if (!addCartModel.status) {
        cart[productId] = !cart[productId];
      } else {
        getCart();
      }
      emit(ShopSuccessAddAndRemoveFromCartStates());
    }).catchError((error) {
      cart[productId] = !cart[productId];
      print("+=================================");
      print(error.toString());
      print("+=================================");
      emit(ShopErrorAddAndRemoveFromCartStates(error.toString()));
    });
  }

  CartModel cartModel;

  void getCart() {
    emit(ShopLoadingGetCartStates());
    DioHelper.getData(url: CARTS, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(ShopSuccessGetCartStates());
    }).catchError((e) {
      emit(ShopErrorGetCartStates(e.toString()));
    });
  }


  void counter({@required int id, @required int quantity}) {
    DioHelper.putData(
      url: 'carts/$id',
      token: token,
      data: {'quantity': quantity},
    ).then((value) {
      emit(ShopSuccessAddQuantityStates());
    }).catchError((e) {
      emit(ShopErrorAddQuantityStates());
    });
  }

  searshmodel search;
  void Searsh(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: 'products/search',
        token: token,
        data: {
          'text':text
        }).then((value){
      search=searshmodel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(SearchErrorState(e));
    });
  }

  AddressModel addressModel;
  void addAddress({
    @required String name,
    @required String city,
    @required String region,
    @required String details,
    @required String notes,
  }) {
    emit(ShopLoadingAddAddressState());
    DioHelper.postData(
      url: ADDRESS,
      token: token,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': '3123123',
        'longitude': '2121545',
      },
    ).then((value) {
      addOrder(idAddress: value.data['data']['id']);
      print('============================================');
      print(value.data['message']);
      print('============================================');
      emit(ShopSuccessAddAddressState());
    }).catchError((error) {
      emit(ShopErrorAddAddressState(error.toString()));
      print(error.toString());
    });
  }

  void addOrder({
    @required int idAddress,
  }) {
    emit(ShopLoadingAddOrderState());
    DioHelper.postData(
      url: ORDERS,
      token: token,
      data: {
        'address_id': idAddress,
        'payment_method': 1,
        'use_points': false,
      },
    ).then((value) {
      print('============================================');
      print(value.data);
      print('============================================');
      getCart();
      emit(ShopSuccessAddOrderState(ordersModel));
    }).catchError((error) {
      emit(ShopErrorAddOrderState(error.toString()));
    });
  }

  OrdersModel ordersModel;

  void getOrders() {
    emit(ShopLoadingGetOrdersState());
    DioHelper.getData(
      url: ORDERS,
      token: token,
    ).then((value) {
      ordersModel = OrdersModel.fromJson(value.data);
      emit(ShopSuccessGetOrdersState());
    }).catchError((error) {
      emit(ShopErrorGetOrdersState(error.toString()));
    });
  }


  void cancelOrder({@required int id}) {
    DioHelper.getData(
      url: 'orders/${id}/cancel',
      token: token,
    ).then((value) {
      emit(ShopSuccessCancelOrderState());
    }).catchError((error) {
      emit(ShopErrorCancelOrderState());
    });
  }


}




