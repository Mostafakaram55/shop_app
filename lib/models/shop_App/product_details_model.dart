
class ProductDetailModel{
  bool status;
  Data data;
  ProductDetailModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data{
  int id;
  num price;
  num oldPrice;
  num discount;
  String name;
  String description;
  bool inFavorites;
  bool inCart;
  List<String>images;

  Data.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    name=json['name'];
    description=json['description'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
    images=json['images'].cast<String>();//دي ليست اوف اسرينج لازم تكتبها عشان يباصي داتا لي ليست عشان هيا مش ليست او اوبجكت
  }
}