class CartModel{
  bool status;
  Data data;
  CartModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=Data.fromJson(json['data']);
  }
}

class Data{
  num total;
  List<CartItem> cartItem=[];
  Data.fromJson(Map<String,dynamic>json){
    total=json['total'];
    json['cart_items'].forEach((value){
      cartItem.add(CartItem.fromJson(value));
    });
  }
}

class CartItem{
  int id;
  int quantity;
  ProductDetails productDetails;
  CartItem.fromJson(Map<String,dynamic>json){
    id=json['id'];
    quantity=json['quantity'];
    productDetails=ProductDetails.fromJson(json['product']);
  }
}

class ProductDetails{
  int id;
  num price;
  String image;
  String name;
  ProductDetails.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    image=json['image'];
    name=json['name'];
  }
}