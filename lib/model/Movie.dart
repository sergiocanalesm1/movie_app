class Movie{
  int _id;
  String _title;
  String _description;
  String _director;
  String _producer;
  String _releaseDate;

  Movie(this._id,this._title,this._description,this._director,this._producer,this._releaseDate);

  Movie.fromJson(Map<String,dynamic> json){
        this._id = json["episode_id"];
        this._title = json["title"];
        this._description = json["opening_crawl"];
        this._director = json["director"];
        this._producer = json["producer"];
        this._releaseDate = json["release_date"];
  }

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["id"] = _id;
    map["title"] = _title;
    map["description"] = _description;
    map["director"] = _director;
    map["producer"] = _producer;
    map["releaseDate"] = _releaseDate;
    return map;
  }
  //getters and setters (business rules)
  int get id => this._id;
  String get title => this._title;
  String get releaseDate => this._releaseDate;
  String get director => this._director;
  String get producer => this._producer;
  String get description => this._description;
}