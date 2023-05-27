

import 'package:intl/intl.dart';

class Wind {
  /*
     "speed": 5.14,
    "deg": 60
   */
  final double ?speed;

  final  int ? deg;

  Wind({ this.speed,  this.deg});

  factory Wind.fromJson( dynamic json) {
    if(json==null){
    return Wind();
    }
    return Wind(
      speed: json["speed"],
      deg: json["deg"],
    );
  }

//

}
