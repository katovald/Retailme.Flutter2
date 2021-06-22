class Product {
  int id;
  String title;
  String description;
  bool over18;
  String name;
  String barcode;

  List<Multimedia> multimedias = [];

  //TODO: promociones
  List<dynamic> promociones = [];

  Product({this.id, this.title, this.description, this.over18, this.name, this.barcode});
}

class Multimedia {
  int id;
  String title;
  String description;
  String multimediaTypeValue;
  String multimediaType;
  String url;
  int position;
  bool enable;

  Multimedia({this.id, this.title, this.description, this.multimediaTypeValue, this.multimediaType, this.url, this.position, this.enable});
}