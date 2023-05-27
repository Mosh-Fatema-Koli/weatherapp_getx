class MainWeather {
  /*
  "temp": 303.57,
    "feels_like": 307.25,
    "temp_min": 303.38,
    "temp_max": 303.57,
    "pressure": 1009,
    "humidity": 62
   */
  final double ?temp;
  final double ?feels_like;
  final double ?temp_min;
  final double ?temp_max;
  final int ?pressure;
  final int ?humidity;
  final int ?sea_level;



  final int ?grnd_level;

  MainWeather(
      { this.temp,
       this.feels_like,
       this.temp_min,
       this.temp_max,
       this.pressure,
       this.humidity,
        this.sea_level,
        this.grnd_level

      });

  factory MainWeather.fromJson( dynamic json) {
    if(json==null){
      return MainWeather();
    }
    return MainWeather(
      temp: json["temp"],
      feels_like: json['feels_like'],
      temp_min: json["temp_min"],
      temp_max: json["temp_max"],
      pressure: json["pressure"],
      humidity: (json["humidity"]),
      sea_level: json["sea_level"],
      grnd_level:json["grnd_level"],
    );
  }


//

}
