import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/model/Movie.dart';

Future<List<Movie>> fetchMovies() async {
  final response = await http.get("https://swapi.dev/api/films/");
  if(response.statusCode == 200){
    List<Movie> movies= [];
    var moviesLinkedFormat = json.decode(response.body)["results"];//class InternalLinkedHashMap<String,dynamic>
    moviesLinkedFormat.forEach((dynamic jObject) {
      movies.add(Movie.fromJson(jObject));
    });
    //return moviesCorrectFormat.map((movie) => Movie.fromJson(movie));
    return movies;
  }
}