class CategoriesModel
{
  bool status=false;
  CategorieDataModel? data;
  CategoriesModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=CategorieDataModel.fromJson(json['data']);

  }

}
class CategorieDataModel
{
  int current_page=0;
  List<DataModel> data=[];
  CategorieDataModel.fromJson(Map<String ,dynamic> json)
  {
    current_page=json['current_page'];
    json['data'].forEach((element){
      data!.add(DataModel.fromJson(element));
    });
  }

}

class DataModel
{
  int id=0;
  String name='';
  String image='';


  DataModel.fromJson(Map<String , dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}