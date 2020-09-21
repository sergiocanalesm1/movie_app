import 'package:flutter/material.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/util/dbhelper.dart';
import 'package:intl/intl.dart';

class MovieDetail extends StatefulWidget{
  final Movie movie;
  MovieDetail(this.movie);
  @override
  State<StatefulWidget> createState() => _movieDetailState(movie);
}

class _movieDetailState extends State{
  /*
  int id;
  String title;
  String description;
  String director;
  String producer;
  String releaseDate;
  */
  Movie movie;
  _movieDetailState(this.movie);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController.text = movie.title;
    descriptionController.text = movie.description;
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(movie.title),
      ),
      body: Padding(
        padding:EdgeInsets.all(30.0),
        child:ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child:Text(
                        movie.director,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child:Text(
                        movie.releaseDate,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ],),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Text(
                    movie.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    movie.producer,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}