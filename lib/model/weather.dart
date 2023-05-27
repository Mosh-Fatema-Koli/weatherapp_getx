class Weather{
  /*
  "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01n"
   */
  final  int ?id;
  final String ?main;
  final String ?description;
  final String ?icon;

  Weather({ this.id,  this.main,  this.description,  this.icon});



  factory Weather.fromJson( dynamic json) {
    if(json==null){
      return Weather();
    }
    return Weather(
      id: json["id"]??10,
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
//

}