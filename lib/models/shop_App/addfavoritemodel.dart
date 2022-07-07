class ChangeFavoriteModel{
  bool status;
  String message;
  ChangeFavoriteModel.fromJason(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}