class GenreModel {
  final String name;
  final int id;

  GenreModel({this.name, this.id});
  //Retorna o Nome o ID do filme
  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
