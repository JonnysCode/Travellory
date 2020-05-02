import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

const googleApiKey = 'AIzaSyBTerG6FzsWzMxLZGxkz8KAXqUNCNtwsE0'; /// maybe have it somewhere else

class GooglePlaces {

  static Future<PlacesDetailsResponse> openGooglePlacesSearch(BuildContext context) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);

    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      //onError: onError,
      mode: Mode.overlay,
      language: "en",
      /// for country
      //components: [Component(Component.country, "ch")],
    );

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

    return detail;
  }
}
