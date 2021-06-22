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

  Product(
      {this.id,
      this.title,
      this.description,
      this.over18,
      this.name,
      this.barcode});
  @override
  String toString() {
    // TODO: implement toString
    return 'id: $id, title: $title, description: $description, over18: $over18, name: $name, barcode: $barcode,  multimedia:{ ${multimedias.map((element) => element.toString())}}';
  }
}

class Multimedia {
  int id;
  String title;
  String description;
  String multimediaTypeValue;
  int multimediaType;
  String url;
  int position;
  bool enable;

  Multimedia(
      {this.id,
      this.title,
      this.description,
      this.multimediaTypeValue,
      this.multimediaType,
      this.url,
      this.position,
      this.enable});

  @override
  String toString() {
    // TODO: implement toString
    return 'id: $id, title: $title, description: $description, multimediaTypeValue: $multimediaTypeValue, multimediaType: $multimediaType, url: $url, position: $position, enable: $enable';
  }
}
