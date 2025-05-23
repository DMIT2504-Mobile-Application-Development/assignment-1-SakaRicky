
class CurrentWeather {
  String _city  = "";
  String _description   = "";
  double _currentTemp   = 0;
  DateTime _currentTime   = DateTime.now();
  DateTime _sunrise = DateTime.now();
  DateTime _sunset  = DateTime.now();

  String get city => _city;
  String get description => _description;
  double get currentTemp => _currentTemp;
  DateTime get currentTime => _currentTime;
  DateTime get sunrise => _sunrise;
  DateTime get sunset => _sunset;

  set city(String newCity) {
      if(newCity.trim() == "" ){
        throw Exception("City cannot be empty");
      } else {
        _city = newCity;
      }
  }

  set description(String newDescription) {
    if(newDescription.trim() == "" ){
      throw Exception("Description cannot be empty");
    } else {
      _description = newDescription;
    }
  }

  set currentTemp(double newTemp) {
    if(newTemp < -100 || newTemp > 100){
      throw Exception("Temperature must be between -100 and 100");
    } else {
      _currentTemp = newTemp;
    }
  }

  set currentTime(DateTime newTime) {
    if(newTime.isAfter(DateTime.now())){
      throw Exception("Current time cannot be in the future");
    } else {
      _currentTime = newTime;
    }
  }

  set sunrise(DateTime newSunrise) {
    if(!areOnSameDay(newSunrise, _currentTime)){
      throw Exception("Sunrise must be on the same day as current time");
    } else if(newSunrise.isAfter(_sunset)) {
      throw Exception("Sunrise cannot be after sunset");
    } else {
      _sunrise = newSunrise;
    }
  }

  set sunset(DateTime newSunset) {
    if(!areOnSameDay(newSunset, _currentTime)){
      throw Exception("Sunset must be on the same day as current time");
    } else if(newSunset.isBefore(_sunrise)) {
      throw Exception("Sunset cannot be before sunrise");
    } else {
      _sunset = newSunset;
    }
  }

  bool areOnSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  CurrentWeather({required String city,
    required String description,
    required DateTime currentTime,
    required double currentTemp,
    required DateTime sunrise,
    required DateTime sunset
  }): _city = city,
  _description = description,
  _currentTime =currentTime,
  _currentTemp = currentTemp,
  _sunrise = sunrise,
  _sunset = sunset;

  factory CurrentWeather.fromOpenWeatherData(Map<String,dynamic> weatherJSONData) {
    String city = weatherJSONData["name"];
    String description = weatherJSONData["weather"][0]["description"];
    DateTime currentTime = DateTime.fromMillisecondsSinceEpoch((weatherJSONData["dt"] * 1000).toInt());
    double temp = weatherJSONData["main"]["temp"];
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch((weatherJSONData["sys"]["sunrise"] * 1000).toInt());
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch((weatherJSONData["sys"]["sunset"]* 1000).toInt());

    return CurrentWeather(
      city: city,
      description: description,
      currentTime: currentTime,
      currentTemp: temp,
      sunrise: sunrise,
      sunset: sunset,
    );
  }

  @override
  String toString() {

    return "City: $city, Description: $description, Current Temperature: $currentTemp, Current Time: $currentTime, Sunrise: $sunrise, Sunset: $sunset";
  }

}