
class CurrentWeather {
  String city  = "";
  String description   = "";
  double currentTemp   = 0;
  DateTime currentTime   = DateTime.now();
  DateTime sunrise = DateTime.now();
  DateTime sunset  = DateTime.now();

  String get aCity => city;
  String get getDescription => description;
  double get getCurrentTemp => currentTemp;
  DateTime get getCurrentTime => currentTime;
  DateTime get getSunrise => sunrise;
  DateTime get getSunset => sunset;

  set setCity(String newCity) {
      if(newCity.trim() == "" ){
        throw Exception("City can't be an empty string");
      } else {
        city = newCity;
      }
  }

  set setDescription(String newDescription) {
    if(newDescription.trim() == "" ){
      throw Exception("Description can't be an empty string");
    } else {
      description = newDescription;
    }
  }

  set setTemperature(double newTemp) {
    if(newTemp < -100 && newTemp > 100){
      throw Exception("Temperature must be between -100 and 100");
    } else {
      currentTemp = newTemp;
    }
  }

  set setCurrentTime(DateTime newTime) {
    if(newTime.isAfter(DateTime.now())){
      throw Exception("Current time cannot be in the future");
    } else {
      currentTime = newTime;
    }
  }

  set setSunrise(DateTime newSunrise) {
    if(!areOnSameDay(newSunrise, currentTime)){
      throw Exception("Sunrise must be on the same day as current time");
    } else if(newSunrise.isAfter(sunset)) {
      throw Exception("Sunrise cannot be after sunset");
    } else {
      sunrise = newSunrise;
    }
  }

  set setSunset(DateTime newSunset) {
    if(!areOnSameDay(newSunset, currentTime)){
      throw Exception("Sunrise must be on the same day as current time");
    } else if(newSunset.isBefore(sunrise)) {
      throw Exception("Sunrise cannot be after sunset");
    } else {
      sunset = newSunset;
    }
  }

  bool areOnSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  CurrentWeather({required this.city,
    required this.description,
    required this.currentTime,
    required this.currentTemp,
    required this.sunrise,
    required this.sunset
  });

  factory CurrentWeather.fromOpenWeatherData(Map<String,dynamic> weatherJSONData) {
    String city = weatherJSONData["name"];
    String description = weatherJSONData["weather"][0]["description"];
    DateTime currentTime = DateTime(weatherJSONData["dt"]);
    double temp = weatherJSONData["main"]["temp"];
    DateTime sunrise = DateTime(weatherJSONData["sys"]["sunrise"]);
    DateTime sunset = DateTime(weatherJSONData["sys"]["sunset"]);

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