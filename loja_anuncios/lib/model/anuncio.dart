import 'dart:ffi';

final String tableAnuncios = 'anuncios';

class AnunciosFields {
  static final List<String> values = [id,state,category,title,price,telephone,description,photo];
  static final String id = '_id';
  static final String state = 'state';
  static final String category = 'category';
  static final String title = 'title';
  static final String price = 'price';
  static final String telephone = 'telephone';
  static final String description = 'description';
  static final String photo= 'photo';

}

class Anuncio {
  final int? id;
  final String state;
  final String category;
  final String title;
  final Float price;
  final String telephone;
  final String description;
  //final Blob photo;

  const Anuncio({
    this.id,
    required this.state,
    required this.category,
    required this.title,
    required this.price,
    required this.telephone,
    required this.description,
    //required this.photo,
  });
  Anuncio copy({
    int? id,
    String? state,
    String? category,
    String? title,
    Float? price,
    String? telephone,
    String? description,
    //Blob? photo,
  }) =>
      Anuncio(
          id: id ?? this.id,
          state: state ?? this.state,
          category: category ?? this.category,
          title: title ?? this.title,
          price: price ?? this.price,
          telephone: telephone ?? this.telephone,
          description: description ?? this.description,
          //photo: photo ?? this.photo,
      );

  static Anuncio fromJson(Map<String, Object?> json) => Anuncio(
    id: json[AnunciosFields.id] as int?,
    state: json[AnunciosFields.state] as String,
    category: json[AnunciosFields.category] as String,
    title: json[AnunciosFields.title] as String,
    price: json[AnunciosFields.price] as Float,
    telephone: json[AnunciosFields.telephone] as String,
    description: json[AnunciosFields.description] as String,
    //photo: json[AnunciosFields.photo] as Blob,
  );


  Map<String, Object?> toJson() => {
    AnunciosFields.id: id,
    AnunciosFields.state: state,
    AnunciosFields.category: category,
    AnunciosFields.title: title,
    AnunciosFields.price: price,
    AnunciosFields.telephone: telephone,
    AnunciosFields.description: description,
    //AnunciosFields.photo: photo,
  };
}