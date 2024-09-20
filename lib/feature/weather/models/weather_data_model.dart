class WeatherData {
  Location? location;
  Current? current;

  WeatherData({this.location, this.current});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    Location? location;
    Current? current;

    try {
      location =
          json['location'] != null ? Location.fromJson(json['location']) : null;
    } catch (e) {
      print("Error parsing location: $e");
    }

    try {
      current =
          json['current'] != null ? Current.fromJson(json['current']) : null;
    } catch (e) {
      print("Error parsing current: $e");
    }

    return WeatherData(
      location: location,
      current: current,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['location'] = location?.toJson();
    } catch (e) {
      print("Error serializing location: $e");
    }

    try {
      data['current'] = current?.toJson();
    } catch (e) {
      print("Error serializing current: $e");
    }

    return data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    String? name;
    String? region;
    String? country;
    double? lat;
    double? lon;
    String? tzId;
    int? localtimeEpoch;
    String? localtime;

    try {
      name = json['name'];
    } catch (e) {
      print("Error parsing name: $e");
    }

    try {
      region = json['region'];
    } catch (e) {
      print("Error parsing region: $e");
    }

    try {
      country = json['country'];
    } catch (e) {
      print("Error parsing country: $e");
    }

    try {
      lat = json['lat']?.toDouble();
    } catch (e) {
      print("Error parsing lat: $e");
    }

    try {
      lon = json['lon']?.toDouble();
    } catch (e) {
      print("Error parsing lon: $e");
    }

    try {
      tzId = json['tz_id'];
    } catch (e) {
      print("Error parsing tzId: $e");
    }

    try {
      localtimeEpoch = json['localtime_epoch']?.toInt();
    } catch (e) {
      print("Error parsing localtimeEpoch: $e");
    }

    try {
      localtime = json['localtime'];
    } catch (e) {
      print("Error parsing localtime: $e");
    }

    return Location(
      name: name,
      region: region,
      country: country,
      lat: lat,
      lon: lon,
      tzId: tzId,
      localtimeEpoch: localtimeEpoch,
      localtime: localtime,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['name'] = name;
    } catch (e) {
      print("Error serializing name: $e");
    }

    try {
      data['region'] = region;
    } catch (e) {
      print("Error serializing region: $e");
    }

    try {
      data['country'] = country;
    } catch (e) {
      print("Error serializing country: $e");
    }

    try {
      data['lat'] = lat;
    } catch (e) {
      print("Error serializing lat: $e");
    }

    try {
      data['lon'] = lon;
    } catch (e) {
      print("Error serializing lon: $e");
    }

    try {
      data['tz_id'] = tzId;
    } catch (e) {
      print("Error serializing tzId: $e");
    }

    try {
      data['localtime_epoch'] = localtimeEpoch;
    } catch (e) {
      print("Error serializing localtimeEpoch: $e");
    }

    try {
      data['localtime'] = localtime;
    } catch (e) {
      print("Error serializing localtime: $e");
    }

    return data;
  }
}

class Current {
  int? lastUpdatedEpoch;
  String? lastUpdated;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  int? windDegree;
  String? windDir;
  double? pressureMb;
  double? pressureIn;
  double? precipMm;
  double? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? windchillC;
  double? windchillF;
  double? heatindexC;
  double? heatindexF;
  double? dewpointC;
  double? dewpointF;
  double? visKm;
  double? visMiles;
  int? uv;
  double? gustMph;
  double? gustKph;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    int? lastUpdatedEpoch;
    String? lastUpdated;
    double? tempC;
    double? tempF;
    int? isDay;
    Condition? condition;
    double? windMph;
    double? windKph;
    int? windDegree;
    String? windDir;
    double? pressureMb;
    double? pressureIn;
    double? precipMm;
    double? precipIn;
    int? humidity;
    int? cloud;
    double? feelslikeC;
    double? feelslikeF;
    double? windchillC;
    double? windchillF;
    double? heatindexC;
    double? heatindexF;
    double? dewpointC;
    double? dewpointF;
    double? visKm;
    double? visMiles;
    int? uv;
    double? gustMph;
    double? gustKph;

    try {
      lastUpdatedEpoch = json['last_updated_epoch']?.toInt();
    } catch (e) {
      print("Error parsing lastUpdatedEpoch: $e");
    }

    try {
      lastUpdated = json['last_updated'];
    } catch (e) {
      print("Error parsing lastUpdated: $e");
    }

    try {
      tempC = json['temp_c']?.toDouble();
    } catch (e) {
      print("Error parsing tempC: $e");
    }

    try {
      tempF = json['temp_f']?.toDouble();
    } catch (e) {
      print("Error parsing tempF: $e");
    }

    try {
      isDay = json['is_day']?.toInt();
    } catch (e) {
      print("Error parsing isDay: $e");
    }

    try {
      condition = json['condition'] != null
          ? Condition.fromJson(json['condition'])
          : null;
    } catch (e) {
      print("Error parsing condition: $e");
    }

    try {
      windMph = json['wind_mph']?.toDouble();
    } catch (e) {
      print("Error parsing windMph: $e");
    }

    try {
      windKph = json['wind_kph']?.toDouble();
    } catch (e) {
      print("Error parsing windKph: $e");
    }

    try {
      windDegree = json['wind_degree']?.toInt();
    } catch (e) {
      print("Error parsing windDegree: $e");
    }

    try {
      windDir = json['wind_dir'];
    } catch (e) {
      print("Error parsing windDir: $e");
    }

    try {
      pressureMb = json['pressure_mb']?.toDouble();
    } catch (e) {
      print("Error parsing pressureMb: $e");
    }

    try {
      pressureIn = json['pressure_in']?.toDouble();
    } catch (e) {
      print("Error parsing pressureIn: $e");
    }

    try {
      precipMm = json['precip_mm']?.toDouble();
    } catch (e) {
      print("Error parsing precipMm: $e");
    }

    try {
      precipIn = json['precip_in']?.toDouble();
    } catch (e) {
      print("Error parsing precipIn: $e");
    }

    try {
      humidity = json['humidity']?.toInt();
    } catch (e) {
      print("Error parsing humidity: $e");
    }

    try {
      cloud = json['cloud']?.toInt();
    } catch (e) {
      print("Error parsing cloud: $e");
    }

    try {
      feelslikeC = json['feelslike_c']?.toDouble();
    } catch (e) {
      print("Error parsing feelslikeC: $e");
    }

    try {
      feelslikeF = json['feelslike_f']?.toDouble();
    } catch (e) {
      print("Error parsing feelslikeF: $e");
    }

    try {
      windchillC = json['windchill_c']?.toDouble();
    } catch (e) {
      print("Error parsing windchillC: $e");
    }

    try {
      windchillF = json['windchill_f']?.toDouble();
    } catch (e) {
      print("Error parsing windchillF: $e");
    }

    try {
      heatindexC = json['heatindex_c']?.toDouble();
    } catch (e) {
      print("Error parsing heatindexC: $e");
    }

    try {
      heatindexF = json['heatindex_f']?.toDouble();
    } catch (e) {
      print("Error parsing heatindexF: $e");
    }

    try {
      dewpointC = json['dewpoint_c']?.toDouble();
    } catch (e) {
      print("Error parsing dewpointC: $e");
    }

    try {
      dewpointF = json['dewpoint_f']?.toDouble();
    } catch (e) {
      print("Error parsing dewpointF: $e");
    }

    try {
      visKm = json['vis_km']?.toDouble();
    } catch (e) {
      print("Error parsing visKm: $e");
    }

    try {
      visMiles = json['vis_miles']?.toDouble();
    } catch (e) {
      print("Error parsing visMiles: $e");
    }

    try {
      uv = json['uv']?.toInt();
    } catch (e) {
      print("Error parsing uv: $e");
    }

    try {
      gustMph = json['gust_mph']?.toDouble();
    } catch (e) {
      print("Error parsing gustMph: $e");
    }

    try {
      gustKph = json['gust_kph']?.toDouble();
    } catch (e) {
      print("Error parsing gustKph: $e");
    }

    return Current(
      lastUpdatedEpoch: lastUpdatedEpoch,
      lastUpdated: lastUpdated,
      tempC: tempC,
      tempF: tempF,
      isDay: isDay,
      condition: condition,
      windMph: windMph,
      windKph: windKph,
      windDegree: windDegree,
      windDir: windDir,
      pressureMb: pressureMb,
      pressureIn: pressureIn,
      precipMm: precipMm,
      precipIn: precipIn,
      humidity: humidity,
      cloud: cloud,
      feelslikeC: feelslikeC,
      feelslikeF: feelslikeF,
      windchillC: windchillC,
      windchillF: windchillF,
      heatindexC: heatindexC,
      heatindexF: heatindexF,
      dewpointC: dewpointC,
      dewpointF: dewpointF,
      visKm: visKm,
      visMiles: visMiles,
      uv: uv,
      gustMph: gustMph,
      gustKph: gustKph,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['last_updated_epoch'] = lastUpdatedEpoch;
    } catch (e) {
      print("Error serializing lastUpdatedEpoch: $e");
    }

    try {
      data['last_updated'] = lastUpdated;
    } catch (e) {
      print("Error serializing lastUpdated: $e");
    }

    try {
      data['temp_c'] = tempC;
    } catch (e) {
      print("Error serializing tempC: $e");
    }

    try {
      data['temp_f'] = tempF;
    } catch (e) {
      print("Error serializing tempF: $e");
    }

    try {
      data['is_day'] = isDay;
    } catch (e) {
      print("Error serializing isDay: $e");
    }

    try {
      data['condition'] = condition?.toJson();
    } catch (e) {
      print("Error serializing condition: $e");
    }

    try {
      data['wind_mph'] = windMph;
    } catch (e) {
      print("Error serializing windMph: $e");
    }

    try {
      data['wind_kph'] = windKph;
    } catch (e) {
      print("Error serializing windKph: $e");
    }

    try {
      data['wind_degree'] = windDegree;
    } catch (e) {
      print("Error serializing windDegree: $e");
    }

    try {
      data['wind_dir'] = windDir;
    } catch (e) {
      print("Error serializing windDir: $e");
    }

    try {
      data['pressure_mb'] = pressureMb;
    } catch (e) {
      print("Error serializing pressureMb: $e");
    }

    try {
      data['pressure_in'] = pressureIn;
    } catch (e) {
      print("Error serializing pressureIn: $e");
    }

    try {
      data['precip_mm'] = precipMm;
    } catch (e) {
      print("Error serializing precipMm: $e");
    }

    try {
      data['precip_in'] = precipIn;
    } catch (e) {
      print("Error serializing precipIn: $e");
    }

    try {
      data['humidity'] = humidity;
    } catch (e) {
      print("Error serializing humidity: $e");
    }

    try {
      data['cloud'] = cloud;
    } catch (e) {
      print("Error serializing cloud: $e");
    }

    try {
      data['feelslike_c'] = feelslikeC;
    } catch (e) {
      print("Error serializing feelslikeC: $e");
    }

    try {
      data['feelslike_f'] = feelslikeF;
    } catch (e) {
      print("Error serializing feelslikeF: $e");
    }

    try {
      data['windchill_c'] = windchillC;
    } catch (e) {
      print("Error serializing windchillC: $e");
    }

    try {
      data['windchill_f'] = windchillF;
    } catch (e) {
      print("Error serializing windchillF: $e");
    }

    try {
      data['heatindex_c'] = heatindexC;
    } catch (e) {
      print("Error serializing heatindexC: $e");
    }

    try {
      data['heatindex_f'] = heatindexF;
    } catch (e) {
      print("Error serializing heatindexF: $e");
    }

    try {
      data['dewpoint_c'] = dewpointC;
    } catch (e) {
      print("Error serializing dewpointC: $e");
    }

    try {
      data['dewpoint_f'] = dewpointF;
    } catch (e) {
      print("Error serializing dewpointF: $e");
    }

    try {
      data['vis_km'] = visKm;
    } catch (e) {
      print("Error serializing visKm: $e");
    }

    try {
      data['vis_miles'] = visMiles;
    } catch (e) {
      print("Error serializing visMiles: $e");
    }

    try {
      data['uv'] = uv;
    } catch (e) {
      print("Error serializing uv: $e");
    }

    try {
      data['gust_mph'] = gustMph;
    } catch (e) {
      print("Error serializing gustMph: $e");
    }

    try {
      data['gust_kph'] = gustKph;
    } catch (e) {
      print("Error serializing gustKph: $e");
    }

    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    String? text;
    String? icon;
    int? code;

    try {
      text = json['text'];
    } catch (e) {
      print("Error parsing text: $e");
    }

    try {
      icon = json['icon'];
    } catch (e) {
      print("Error parsing icon: $e");
    }

    try {
      code = json['code']?.toInt();
    } catch (e) {
      print("Error parsing code: $e");
    }

    return Condition(
      text: text,
      icon: icon,
      code: code,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['text'] = text;
    } catch (e) {
      print("Error serializing text: $e");
    }

    try {
      data['icon'] = icon;
    } catch (e) {
      print("Error serializing icon: $e");
    }

    try {
      data['code'] = code;
    } catch (e) {
      print("Error serializing code: $e");
    }

    return data;
  }
}
