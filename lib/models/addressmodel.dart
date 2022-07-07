class AddressModel{
  bool status;
  String message;
  DataModel data;
  AddressModel.fromJason(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['DataModel'];
  }
}
class DataModel{
String name;
String city;
String region;
String details;
double latitude;
double longitude;
String notes;
int id;
DataModel.fromJason(Map<String,dynamic>json){
  name=json['name'];
  city=json['city'];
  region=json['region'];
  details=json['details'];
  latitude=json['latitude'];
  longitude=json['longitude'];
  notes=json['notes'];
  id=json['id'];
}

}