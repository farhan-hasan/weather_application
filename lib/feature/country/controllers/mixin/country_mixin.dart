import 'package:bot_toast/bot_toast.dart';
import 'package:networking_practice/feature/country/repository/country_repository.dart';

import '../../models/country_data_model.dart';

mixin CountryMixin {
  Future<List<CountryData>?> fetchCountries(
      CountryRepository countryRepository) async {
    List<CountryData>? countryData;
    BotToast.showLoading();
    Object result = await countryRepository.getCountries();

    BotToast.closeAllLoading();

    if (result is List<CountryData>) {
      countryData = result;
      print(countryData);
    } else {
      BotToast.showText(text: "Something went wrong");
    }

    return countryData;
  }
}
