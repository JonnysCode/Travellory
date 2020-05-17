import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/widgets/bookings/bookings_get_buttons.dart';
import 'package:travellory/widgets/bookings/edit.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/image_selector.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/services/api/google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:travellory/widgets/buttons/submit_button.dart';

class CreateTrip extends StatefulWidget {
  static final route = '/createtrip';

  @override
  _CreateTripState createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  static const int _imageItemCount = 11;

  final GlobalKey<DateFormFieldState> _startDateFormFieldKey = GlobalKey<DateFormFieldState>();
  final DatabaseAdder databaseAdder = DatabaseAdder();
  final createTripFormKey = GlobalKey<FormState>();
  TextEditingController locationController = TextEditingController();

  final String alertText =
      "You've just created a new trip. You can see all the information in the home screen. "
      "Add bookings and customize your trip with a click on it";

  final String cancelText = 'You are about to abort this new trip entry. '
      'Do you want to go back to the previous site and discard your changes?';

  TripModel _tripModel;

  @override
  Widget build(BuildContext context) {
    final TripsProvider trips = Provider.of<TripsProvider>(context, listen: false);
    final ModifyModelArguments arguments = ModalRoute.of(context).settings.arguments;

    _tripModel = TripModel.fromData(arguments.model.toMap());
    final bool isNewModel = arguments.isNewModel;

    bool _validateForm() {
      return createTripFormKey.currentState.validate();
    }

    SubmitButton _getSubmitButton() {
      void Function() onSubmit;
      if (isNewModel) {
        onSubmit = onSubmitTrip(trips, _tripModel, context, alertText);
      } else {
        onSubmit = onEditTrip(trips, _tripModel, context);
      }

      return SubmitButton(
        highlightColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        validationFunction: _validateForm,
        onSubmit: onSubmit,
      );
    }

    return SafeArea(
      child: Scaffold(
        key: Key('create_trip'),
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  child: Stack(
                    children: <Widget>[
                      Center(
                          child: BookingSiteTitle('Create Trip', FontAwesomeIcons.suitcaseRolling)),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: FaIcon(FontAwesomeIcons.times),
                          iconSize: 30,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Form(
                    key: createTripFormKey,
                    child: ListView(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: SectionTitle('Trip Details'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: DateFormField(
                          initialValue: _tripModel.startDate,
                          key: _startDateFormFieldKey,
                          labelText: 'Start Date *',
                          icon: Icon(Icons.date_range),
                          optional: false,
                          chosenDateString: (value) => _tripModel.startDate = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: DateFormField(
                          initialValue: _tripModel.endDate,
                          labelText: 'End Date *',
                          icon: Icon(Icons.date_range),
                          beforeDateKey: _startDateFormFieldKey,
                          optional: false,
                          dateValidationMessage: 'End Date cannot be before Start Date',
                          chosenDateString: (value) => _tripModel.endDate = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: TravelloryFormField(
                          initialValue: _tripModel.destination,
                          labelText: 'Destination *',
                          icon: Icon(Icons.directions_car),
                          optional: false,
                          controller: locationController,
                          onTap: (locationController) async {
                            final PlacesDetailsResponse detail =
                                await GooglePlaces.openGooglePlacesSearch(context);
                            final AddressComponent country =
                                GooglePlaces.getCountryAddressComponent(detail);
                            final String continent =
                                GooglePlaces.getContinentFromCountryCode(country.shortName);

                            locationController.text = detail.result.formattedAddress;
                            _tripModel.destination = detail.result.formattedAddress;
                            _tripModel.country = country.longName;
                            _tripModel.countryCode = country.shortName;
                            _tripModel.continent = continent;
                          },
                          onChanged: (value) => _tripModel.destination = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: SectionTitle('General Information'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: TravelloryFormField(
                          initialValue: _tripModel.name,
                          labelText: 'Trip Title *',
                          icon: Icon(Icons.supervised_user_circle),
                          optional: false,
                          onChanged: (value) => _tripModel.name = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: ImageSelector(
                          initialValue: _tripModel.imageNr,
                          onChanged: (value) => _tripModel.imageNr = value,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                          child: Container(
                        height: 32,
                        width: 120,
                        child: _getSubmitButton(),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: 32,
                          width: 120,
                          child: getBookingCancelButton(
                            context,
                            () {
                              cancellingDialog(context, cancelText);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
