class ChangFavMode{
  String message='';
  bool status=false;

  ChangFavMode.fromJson(Map<String, dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}