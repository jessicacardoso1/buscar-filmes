import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buscar_filmes1/models/moviemodel.dart';
import 'package:buscar_filmes1/models/genremodel.dart';

class Api{
  static const url = "https://api.themoviedb.org/3";
  static const apiKey = "f476c933beeb792de073665402a501ad";

  //Retorna no futuro uma lista com os dados do filmes da API de acordo com gênero escolhido
  Future<List<GenreModel>> getGenreList() async {
    final response = await http.get('$url/genre/movie/list?api_key=$apiKey');

    // Caso o codigo do status seja 200, significia que ocorreu da forma correta
    if (response.statusCode == 200) {
      //retorno dos dados da api
      final parsed = json.decode(response.body)['genres'].cast<Map<String, dynamic>>();

      return parsed
          .map<GenreModel>((json) => GenreModel.fromJson(json))
          .toList();
    } else {
      // Se nao deu tudo certo, retorne a mensagem.
      throw Exception('Falha ao carregar');
    }
  }

  //Retorna no futuro uma lista com os dados do filme da API.
  Future<MovieModel> getMovieInfo(int movieId) async{
    final response = await http.get("$url/movie/$movieId?api_key=$apiKey");

    if (response.statusCode == 200){
      return MovieModel.fromJson(json.decode(response.body));
    } else{
      // Se nao deu tudo certo, retorne a mensagem.
      throw Exception('Falha ao carregar as informaçoes do filme');
    }
  }
}