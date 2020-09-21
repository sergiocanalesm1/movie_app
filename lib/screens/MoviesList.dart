import 'package:movie_app/model/Movie.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/util/dbhelper.dart';
import 'package:movie_app/services/movieApi.dart';
import 'package:movie_app/screens/MovieDetail.dart';

class MovieList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MovieListState();
}

class _MovieListState extends State{
  List<Movie> movies;
  DbHelper helper = DbHelper();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (movies == null){
      movies = [];
      getDataOnline();
      movies.sort((a,b){
        return b.releaseDate.compareTo(a.releaseDate);//not working
      });
    }
    return Scaffold(
      body: movieListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip:"Add movie",
        child: Icon(Icons.add),
      ),
    );
  }
  ListView movieListItems(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white,//CAMBIAR
          elevation: 2.0,
          child: ListTile(
            leading:CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Text(this.movies[position].releaseDate.split("-")[0]),
            ),
            title: Text(this.movies[position].title),
            subtitle: Text(this.movies[position].director ),
            onTap:(){
              navigateToDetail(this.movies[position]);
            }
          ),
        );
      },
    );
  }
  void navigateToDetail(Movie movie) async{
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder:(context) => MovieDetail(movie)),
    );
  }
  void getDataOnline(){
    /*
    fetchMovies().then((data) {
      movies = data;
      DbHelper helper = DbHelper();
      helper.initializeDb().then(
              (result) => helper.getMovies().then(
                  (result) =>  setState(() {
                    movies = result;
                    count = result.length;
                  })
          ));
    });*/
    fetchMovies().then((data) {
      setState(() {
      movies = data;
      count = movies.length;
      });
      saveData();
    });
  }
  void saveData(){
    helper.initializeDb().then((result){
      for( var movie in movies){
        helper.insertMovie(movie);
      }
    });
  }
  void getDataDb(){
    final dbFuture = helper.initializeDb();
    dbFuture.then((result){
          final moviesFuture = helper.getMovies();
          moviesFuture.then((result) {
            List<Movie> list = [];
            count = result.length;
            for(int i = 0; i < count; i++){
              list.add(Movie.fromJson(result[i]));
              debugPrint(list[i].title);
            }
            setState(() {
              movies = list;
              count = count;
            });
          });
        }
    );
  }
}