import 'package:retailmi/domain/models/product_model.dart';

class Sucursal {
  /*
  * "id": 1,
    "title": "Sams",
    "description": "Sams calzada Ignacio Zaragoza Pasillo 12",
    "address": "Ignacio Zaragoza 1046",
    "videoUrl": "https://retailmistorage.blob.core.windows.net/image/branch-file-1623184139025",
    "deviceId": null,
    "products": [],
    "supervisors": []
    * */
  final int id;
  final String title;
  final String description;
  final String address;
  String videoUrl;
  String deviceId;
  List<Product> products;

  Sucursal(this.id, this.title, this.description, this.address, this.videoUrl, this.deviceId, this.products);

  Sucursal.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        address = map['address'],
        videoUrl = map['videoUrl'],
        products = map['products'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'description' : description,
    'address' : address,
    'videoUrl' : videoUrl,
    'products' : products
  };
}