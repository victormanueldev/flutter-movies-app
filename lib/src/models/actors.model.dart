class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> jsonMap ) {
    castId = jsonMap['cast_id'];
    character = jsonMap['character'];
    creditId = jsonMap['credit_id'];
    gender = jsonMap['gender'];
    id = jsonMap['id'];
    name = jsonMap['name'];
    order = jsonMap['order'];
    profilePath = jsonMap['profile_path'];
  }

  String getImageUrl() {
    if( profilePath == null ){
      return 'https://comnplayscience.eu/app/images/notfound.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

class Cast {

  List<Actor> actors = new List();

  Cast.fromJsonToList( List<dynamic> jsonList ) {
    if( jsonList == null ) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap( item );
      actors.add(actor);
    });
  }
 
}
