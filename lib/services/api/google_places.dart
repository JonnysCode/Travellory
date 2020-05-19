import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:travellory/utils/logger.dart';

const googleApiKey = 'AIzaSyBTerG6FzsWzMxLZGxkz8KAXqUNCNtwsE0'; /// maybe have it somewhere else

class GooglePlaces {

  static final log = getLogger('GooglePlaces');

  static Future<PlacesDetailsResponse> openGooglePlacesSearch(BuildContext context, {String countryCode}) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);
    List<Component> country = [];
    if(countryCode != null){
      country.add(Component(Component.country, countryCode));
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      //onError: onError,
      mode: Mode.fullscreen,
      language: "en",
      /// for country
      components: country,
    );

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

    return detail;
  }

  static AddressComponent getCountryAddressComponent(PlacesDetailsResponse detail){
    AddressComponent addr;
    for(AddressComponent add in detail.result.addressComponents){
      log.d('Country: ${add.longName} CountryCode: ${add.shortName}');
      if(add.types.contains('country')){
        addr = add;
      }
    }
    return addr;
  }

  static String getContinentFromCountryCode(String countryCode){
    rootBundle.loadString('assets/g_map/continents.json').then((string) => json.decode(string))
        .then((jsonData) {
      print("Continent: ${jsonData[countryCode]}");
    });

  }
}
