class CountryData {
  Name? name;
  List<String>? tld;
  String? cca2;
  String? ccn3;
  String? cca3;
  bool? independent;
  String? status;
  bool? unMember;
  Map<String, Currency>? currencies;
  IDD? idd;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  Map<String, String>? languages;
  Map<String, Translation>? translations;
  List<double>? latlng;
  bool? landlocked;
  double? area; // Changed to double
  Map<String, Demonym>? demonyms;
  String? flag;
  Maps? maps;
  double? population; // Changed to double
  Car? car;
  List<String>? timezones;
  List<String>? continents;
  Flags? flags;
  Map<String, dynamic>? coatOfArms;
  String? startOfWeek;
  CapitalInfo? capitalInfo;

  CountryData({
    this.name,
    this.tld,
    this.cca2,
    this.ccn3,
    this.cca3,
    this.independent,
    this.status,
    this.unMember,
    this.currencies,
    this.idd,
    this.capital,
    this.altSpellings,
    this.region,
    this.languages,
    this.translations,
    this.latlng,
    this.landlocked,
    this.area,
    this.demonyms,
    this.flag,
    this.maps,
    this.population,
    this.car,
    this.timezones,
    this.continents,
    this.flags,
    this.coatOfArms,
    this.startOfWeek,
    this.capitalInfo,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    Name? name;
    List<String>? tld;
    Map<String, Currency>? currencies;
    IDD? idd;
    Maps? maps;
    Car? car;
    Map<String, Demonym>? demonyms;
    Map<String, String>? languages;
    Map<String, Translation>? translations;
    CapitalInfo? capitalInfo;

    try {
      name = json['name'] != null ? Name.fromJson(json['name']) : null;
    } catch (e) {
      print("Error parsing name: $e");
    }

    try {
      tld = List<String>.from(json['tld'] ?? []);
    } catch (e) {
      print("Error parsing tld: $e");
    }

    try {
      currencies = (json['currencies'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, Currency.fromJson(value)));
    } catch (e) {
      print("Error parsing currencies: $e");
    }

    try {
      idd = json['idd'] != null ? IDD.fromJson(json['idd']) : null;
    } catch (e) {
      print("Error parsing idd: $e");
    }

    try {
      maps = json['maps'] != null ? Maps.fromJson(json['maps']) : null;
    } catch (e) {
      print("Error parsing maps: $e");
    }

    try {
      car = json['car'] != null ? Car.fromJson(json['car']) : null;
    } catch (e) {
      print("Error parsing car: $e");
    }

    try {
      demonyms = (json['demonyms'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, Demonym.fromJson(value)));
    } catch (e) {
      print("Error parsing demonyms: $e");
    }

    try {
      languages = (json['languages'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      print("Error parsing languages: $e");
    }

    try {
      translations = (json['translations'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, Translation.fromJson(value)));
    } catch (e) {
      print("Error parsing translations: $e");
    }

    try {
      capitalInfo = json['capitalInfo'] != null
          ? CapitalInfo.fromJson(json['capitalInfo'])
          : null;
    } catch (e) {
      print("Error parsing capitalInfo: $e");
    }

    return CountryData(
      name: name,
      tld: tld,
      cca2: json['cca2'],
      ccn3: json['ccn3'],
      cca3: json['cca3'],
      independent: json['independent'],
      status: json['status'],
      unMember: json['unMember'],
      currencies: currencies,
      idd: idd,
      capital: List<String>.from(json['capital'] ?? []),
      altSpellings: List<String>.from(json['altSpellings'] ?? []),
      region: json['region'],
      languages: languages,
      translations: translations,
      latlng: List<double>.from(json['latlng'] ?? []),
      landlocked: json['landlocked'],
      area: json['area']?.toDouble(),
      // Changed to double
      demonyms: demonyms,
      flag: json['flag'],
      maps: maps,
      population: json['population']?.toDouble(),
      // Changed to double
      car: car,
      timezones: List<String>.from(json['timezones'] ?? []),
      continents: List<String>.from(json['continents'] ?? []),
      flags: json['flags'] != null ? Flags.fromJson(json['flags']) : null,
      coatOfArms: json['coatOfArms'],
      startOfWeek: json['startOfWeek'],
      capitalInfo: capitalInfo,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    try {
      data['name'] = name?.toJson();
    } catch (e) {
      print("Error serializing name: $e");
    }

    try {
      data['tld'] = tld;
    } catch (e) {
      print("Error serializing tld: $e");
    }

    try {
      data['cca2'] = cca2;
    } catch (e) {
      print("Error serializing cca2: $e");
    }

    try {
      data['ccn3'] = ccn3;
    } catch (e) {
      print("Error serializing ccn3: $e");
    }

    try {
      data['cca3'] = cca3;
    } catch (e) {
      print("Error serializing cca3: $e");
    }

    try {
      data['independent'] = independent;
    } catch (e) {
      print("Error serializing independent: $e");
    }

    try {
      data['status'] = status;
    } catch (e) {
      print("Error serializing status: $e");
    }

    try {
      data['unMember'] = unMember;
    } catch (e) {
      print("Error serializing unMember: $e");
    }

    try {
      data['currencies'] =
          currencies?.map((key, value) => MapEntry(key, value.toJson()));
    } catch (e) {
      print("Error serializing currencies: $e");
    }

    try {
      data['idd'] = idd?.toJson();
    } catch (e) {
      print("Error serializing idd: $e");
    }

    try {
      data['capital'] = capital;
    } catch (e) {
      print("Error serializing capital: $e");
    }

    try {
      data['altSpellings'] = altSpellings;
    } catch (e) {
      print("Error serializing altSpellings: $e");
    }

    try {
      data['region'] = region;
    } catch (e) {
      print("Error serializing region: $e");
    }

    try {
      data['languages'] = languages;
    } catch (e) {
      print("Error serializing languages: $e");
    }

    try {
      data['translations'] =
          translations?.map((key, value) => MapEntry(key, value.toJson()));
    } catch (e) {
      print("Error serializing translations: $e");
    }

    try {
      data['latlng'] = latlng;
    } catch (e) {
      print("Error serializing latlng: $e");
    }

    try {
      data['landlocked'] = landlocked;
    } catch (e) {
      print("Error serializing landlocked: $e");
    }

    try {
      data['area'] = area;
    } catch (e) {
      print("Error serializing area: $e");
    }

    try {
      data['demonyms'] =
          demonyms?.map((key, value) => MapEntry(key, value.toJson()));
    } catch (e) {
      print("Error serializing demonyms: $e");
    }

    try {
      data['flag'] = flag;
    } catch (e) {
      print("Error serializing flag: $e");
    }

    try {
      data['maps'] = maps?.toJson();
    } catch (e) {
      print("Error serializing maps: $e");
    }

    try {
      data['population'] = population;
    } catch (e) {
      print("Error serializing population: $e");
    }

    try {
      data['car'] = car?.toJson();
    } catch (e) {
      print("Error serializing car: $e");
    }

    try {
      data['timezones'] = timezones;
    } catch (e) {
      print("Error serializing timezones: $e");
    }

    try {
      data['continents'] = continents;
    } catch (e) {
      print("Error serializing continents: $e");
    }

    try {
      data['flags'] = flags?.toJson();
    } catch (e) {
      print("Error serializing flags: $e");
    }

    try {
      data['coatOfArms'] = coatOfArms;
    } catch (e) {
      print("Error serializing coatOfArms: $e");
    }

    try {
      data['startOfWeek'] = startOfWeek;
    } catch (e) {
      print("Error serializing startOfWeek: $e");
    }

    try {
      data['capitalInfo'] = capitalInfo?.toJson();
    } catch (e) {
      print("Error serializing capitalInfo: $e");
    }

    return data;
  }
}

class Name {
  String? common;
  String? official;
  Map<String, NativeName>? nativeName;

  Name({this.common, this.official, this.nativeName});

  factory Name.fromJson(Map<String, dynamic> json) {
    Name name = Name();
    try {
      name.common = json['common'];
    } catch (e) {
      print("Error parsing common name: $e");
    }

    try {
      name.official = json['official'];
    } catch (e) {
      print("Error parsing official name: $e");
    }

    try {
      name.nativeName = (json['nativeName'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, NativeName.fromJson(value)));
    } catch (e) {
      print("Error parsing native names: $e");
    }

    return name;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['common'] = common;
    } catch (e) {
      print("Error serializing common name: $e");
    }

    try {
      data['official'] = official;
    } catch (e) {
      print("Error serializing official name: $e");
    }

    try {
      data['nativeName'] =
          nativeName?.map((key, value) => MapEntry(key, value.toJson()));
    } catch (e) {
      print("Error serializing native names: $e");
    }

    return data;
  }
}

class NativeName {
  String? official;
  String? common;

  NativeName({this.official, this.common});

  factory NativeName.fromJson(Map<String, dynamic> json) {
    NativeName nativeName = NativeName();

    try {
      nativeName.official = json['official'];
    } catch (e) {
      print("Error parsing official name: $e");
    }

    try {
      nativeName.common = json['common'];
    } catch (e) {
      print("Error parsing common name: $e");
    }

    return nativeName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['official'] = official;
    } catch (e) {
      print("Error serializing official name: $e");
    }

    try {
      data['common'] = common;
    } catch (e) {
      print("Error serializing common name: $e");
    }

    return data;
  }
}

class Currency {
  String? name;
  String? symbol;

  Currency({this.name, this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) {
    Currency currency = Currency();
    try {
      currency.name = json['name'];
    } catch (e) {
      print("Error parsing currency name: $e");
    }

    try {
      currency.symbol = json['symbol'];
    } catch (e) {
      print("Error parsing currency symbol: $e");
    }

    return currency;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['name'] = name;
    } catch (e) {
      print("Error serializing currency name: $e");
    }

    try {
      data['symbol'] = symbol;
    } catch (e) {
      print("Error serializing currency symbol: $e");
    }

    return data;
  }
}

class IDD {
  String? root;
  List<String>? suffixes;

  IDD({this.root, this.suffixes});

  factory IDD.fromJson(Map<String, dynamic> json) {
    IDD idd = IDD();
    try {
      idd.root = json['root'];
    } catch (e) {
      print("Error parsing IDD root: $e");
    }

    try {
      idd.suffixes = List<String>.from(json['suffixes'] ?? []);
    } catch (e) {
      print("Error parsing IDD suffixes: $e");
    }

    return idd;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['root'] = root;
    } catch (e) {
      print("Error serializing IDD root: $e");
    }

    try {
      data['suffixes'] = suffixes;
    } catch (e) {
      print("Error serializing IDD suffixes: $e");
    }

    return data;
  }
}

class Maps {
  String? googleMaps;
  String? openStreetMaps;

  Maps({this.googleMaps, this.openStreetMaps});

  factory Maps.fromJson(Map<String, dynamic> json) {
    Maps maps = Maps();
    try {
      maps.googleMaps = json['googleMaps'];
    } catch (e) {
      print("Error parsing Google Maps URL: $e");
    }

    try {
      maps.openStreetMaps = json['openStreetMaps'];
    } catch (e) {
      print("Error parsing OpenStreetMaps URL: $e");
    }

    return maps;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['googleMaps'] = googleMaps;
    } catch (e) {
      print("Error serializing Google Maps URL: $e");
    }

    try {
      data['openStreetMaps'] = openStreetMaps;
    } catch (e) {
      print("Error serializing OpenStreetMaps URL: $e");
    }

    return data;
  }
}

class Demonym {
  String? f;
  String? m;

  Demonym({this.f, this.m});

  factory Demonym.fromJson(Map<String, dynamic> json) {
    Demonym demonym = Demonym();
    try {
      demonym.f = json['f'];
    } catch (e) {
      print("Error parsing female demonym: $e");
    }

    try {
      demonym.m = json['m'];
    } catch (e) {
      print("Error parsing male demonym: $e");
    }

    return demonym;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['f'] = f;
    } catch (e) {
      print("Error serializing female demonym: $e");
    }

    try {
      data['m'] = m;
    } catch (e) {
      print("Error serializing male demonym: $e");
    }

    return data;
  }
}

class Flags {
  String? png;
  String? svg;

  Flags({this.png, this.svg});

  factory Flags.fromJson(Map<String, dynamic> json) {
    Flags flags = Flags();
    try {
      flags.png = json['png'];
    } catch (e) {
      print("Error parsing PNG flag: $e");
    }

    try {
      flags.svg = json['svg'];
    } catch (e) {
      print("Error parsing SVG flag: $e");
    }

    return flags;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['png'] = png;
    } catch (e) {
      print("Error serializing PNG flag: $e");
    }

    try {
      data['svg'] = svg;
    } catch (e) {
      print("Error serializing SVG flag: $e");
    }

    return data;
  }
}

class Translation {
  String? official;
  String? common;

  Translation({this.official, this.common});

  factory Translation.fromJson(Map<String, dynamic> json) {
    Translation translation = Translation();

    try {
      translation.official = json['official'];
    } catch (e) {
      print("Error parsing official translation: $e");
    }

    try {
      translation.common = json['common'];
    } catch (e) {
      print("Error parsing common translation: $e");
    }

    return translation;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['official'] = official;
    } catch (e) {
      print("Error serializing official translation: $e");
    }

    try {
      data['common'] = common;
    } catch (e) {
      print("Error serializing common translation: $e");
    }

    return data;
  }
}

class Car {
  List<String>? signs;
  String? side;

  Car({this.signs, this.side});

  factory Car.fromJson(Map<String, dynamic> json) {
    Car car = Car();

    try {
      car.signs =
          json['signs'] != null ? List<String>.from(json['signs']) : null;
    } catch (e) {
      print("Error parsing signs: $e");
    }

    try {
      car.side = json['side'];
    } catch (e) {
      print("Error parsing side: $e");
    }

    return car;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['signs'] = signs;
    } catch (e) {
      print("Error serializing signs: $e");
    }

    try {
      data['side'] = side;
    } catch (e) {
      print("Error serializing side: $e");
    }

    return data;
  }
}

class CapitalInfo {
  List<double>? latlng;

  CapitalInfo({this.latlng});

  factory CapitalInfo.fromJson(Map<String, dynamic> json) {
    CapitalInfo capitalInfo = CapitalInfo();

    try {
      capitalInfo.latlng =
          json['latlng'] != null ? List<double>.from(json['latlng']) : null;
    } catch (e) {
      print("Error parsing latlng: $e");
    }

    return capitalInfo;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['latlng'] = latlng;
    } catch (e) {
      print("Error serializing latlng: $e");
    }

    return data;
  }
}
