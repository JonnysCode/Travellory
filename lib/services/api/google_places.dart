import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:travellory/logger.dart';

const googleApiKey = 'AIzaSyBTerG6FzsWzMxLZGxkz8KAXqUNCNtwsE0'; /// maybe have it somewhere else

class GooglePlaces {

  static final log = getLogger('GooglePlaces');

  static Future<PlacesDetailsResponse> openGooglePlacesSearch(BuildContext context, {String countryCode}) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);
    List<Component> country = [];
    if(countryCode != null){
      country.add(Component(Component.country, "ch"));
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      //onError: onError,
      mode: Mode.overlay,
      language: "en",
      /// for country
      components: country,
    );

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

    return detail;
  }

  static AddressComponent getCountryAddressComponent(PlacesDetailsResponse detail){
    for(AddressComponent add in detail.result.addressComponents){
      if(add.types.contains('country')){
        log.d('Country: ${add.longName} CountryCode: ${add.shortName}');
        return add;
      }
    }
  }
}
