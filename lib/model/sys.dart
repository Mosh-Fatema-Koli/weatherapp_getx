import 'dart:convert';

class Sys{
  /*
  "type": 1,
    "id": 2514,
    "country": "EG",
    "sunrise": 1661225216,
    "sunset": 1661272133
   */
  final int ?type;
  final int ?id;
  final int ?sunrise;
  final int   ?sunset;
 final String ? country;

  Sys({ this.type,  this.id,  this.sunrise,  this.sunset,  this.country});



  factory Sys.fromJson( dynamic json) {
    if(json==null){
      return Sys();
    }
    var rise=json['sunrise'];

    return Sys(
      type: json["type"],
      id: json["id"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      country: json["country"],
    );
  }



//

}