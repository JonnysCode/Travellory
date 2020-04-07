import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/utils/list_models.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/checkbox_form_field.dart';
import 'package:travellory/widgets/dropdown.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/form_field.dart';
import 'package:travellory/widgets/form_widgets.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/date_form_field.dart';
import 'package:travellory/widgets/time_form_field.dart';

class PublicTransport extends StatefulWidget {
  @override
  _PublicTransportState createState() => new _PublicTransportState();
}

class _PublicTransportState extends State<PublicTransport> {
  ListModel<Widget> publicTransportList;
  final publicTransportFormKey = GlobalKey<FormState>();
  final PublicTransportModel publicTransportModel = PublicTransportModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final _depDateFormFieldKey = GlobalKey<DateFormFieldState>();
  TravelloryDropdownField transportTypeDropdown;
  CheckboxFormField bookingMadeCheckbox;
  CheckboxFormField seatReservedCheckbox;

  Widget typeSpecificationAdditional;
  Widget bookingMadeAdditional;
  Widget seatReservationAdditional;

  bool validateForm() {
    return publicTransportFormKey.currentState.validate();
  }

  @override
  void initState() {
    super.initState();

    transportTypeDropdown = TravelloryDropdownField(
        title: 'Select Transport Type',
        types: types,
        onChanged: (value) {
          publicTransportModel.transportationType = value.name;
          showAdditional(publicTransportList, value.name == 'Other', transportTypeDropdown,
              typeSpecificationAdditional);
        },
        validatorText: 'Please enter the required information');

    bookingMadeCheckbox = CheckboxFormField(
      initialValue: false,
      label: 'Did you book this public transport?',
      onChanged: (value) {
        publicTransportModel.booked = value;
        showAdditional(publicTransportList, value, bookingMadeCheckbox, bookingMadeAdditional);
      },
    );

    seatReservedCheckbox = CheckboxFormField(
        initialValue: false,
        label: 'Did you make a seat reservation?',
        onChanged: (value) {
          publicTransportModel.seatReservation = value;
          showAdditional(
              publicTransportList, value, seatReservedCheckbox, seatReservationAdditional);
        });

    // don't put in build because it will be recreated on every build
    // with state changes this is not appreciated
    List<Widget> shown = [
      BookingSiteTitle("Add Public Transport", Icons.train),
      SectionTitle("Type of Transportation"),
      transportTypeDropdown,
      TravelloryFormField(
          labelText: "Company",
          icon: Icon(Icons.supervised_user_circle),
          optional: true,
          onChanged: (value) => publicTransportModel.company = value),
      SectionTitle("Departure Information"),
      TravelloryFormField(
        labelText: "Departure Location *",
        icon: Icon(Icons.location_on),
        optional: false,
        onChanged: (value) => publicTransportModel.departureLocation = value,
      ),
      DateFormField(
        key: _depDateFormFieldKey,
        labelText: "Departure Date *",
        icon: Icon(Icons.date_range),
        chosenDateString: (value) => publicTransportModel.departureDate = value,
      ),
      TimeFormField(
        labelText: "Departure Time *",
        icon: Icon(Icons.access_time),
        chosenTimeString: (value) => publicTransportModel.departureTime = value,
      ),
      SectionTitle("Arrival Information"),
      TravelloryFormField(
        labelText: "Arrival Location *",
        icon: Icon(Icons.location_on),
        optional: false,
        onChanged: (value) => publicTransportModel.arrivalLocation = value,
      ),
      DateFormField(
        labelText: "Arrival Date *",
        icon: Icon(Icons.date_range),
        beforeDateKey: _depDateFormFieldKey,
        dateValidationMessage: "Departure Date cannot be before Arrival Date",
        chosenDateString: (value) => publicTransportModel.arrivalDate = value,
      ),
      TimeFormField(
        labelText: "Arrival Time",
        icon: Icon(Icons.access_time),
        optional: true,
        chosenTimeString: (value) => publicTransportModel.arrivalTime = value,
      ),
      SectionTitle("Booking Details"),
      bookingMadeCheckbox,
      seatReservedCheckbox,
      SectionTitle("Notes"),
      TravelloryFormField(
        labelText: "Notes",
        icon: Icon(Icons.speaker_notes),
        optional: true,
        onChanged: (value) => publicTransportModel.notes = value,
      ),
      SubmitButton(),
      CancelButton(),
      SizedBox(height: 20),
    ];

    // this builds the animated list
    publicTransportList = ListModel<Widget>(
      listKey: _listKey,
      initialItems: shown,
      removedItemBuilder: _removedItemBuilder,
    );

    typeSpecificationAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          labelText: "Specific Type of Transportation",
          icon: Icon(Icons.train),
          optional: true,
          onChanged: (value) => publicTransportModel.specificType = value,
        ),
      ],
    );

    bookingMadeAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          labelText: "Booking Reference",
          icon: Icon(Icons.confirmation_number),
          optional: true,
          onChanged: (value) => publicTransportModel.reference = value,
        ),
        TravelloryFormField(
          labelText: "Booking Company",
          icon: Icon(Icons.supervised_user_circle),
          optional: true,
          onChanged: (value) => publicTransportModel.companyReservation = value,
        ),
      ],
    );

    seatReservationAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          labelText: "Seat",
          icon: Icon(Icons.airline_seat_recline_normal),
          optional: true,
          onChanged: (value) => publicTransportModel.seat = value,
        ),
      ],
    );
  }

  final String alertText =
      "You've just submitted the booking information for your public transportation booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  List<Item> types = <Item>[
    const Item('Rail', Icon(Icons.directions_railway, color: const Color(0xFF167F67))),
    const Item('Bus', Icon(Icons.directions_bus, color: const Color(0xFF167F67))),
    const Item('Metro', Icon(Icons.train, color: const Color(0xFF167F67))),
    const Item('Ferry', Icon(Icons.directions_boat, color: const Color(0xFF167F67))),
    const Item('Taxi', Icon(Icons.directions_car, color: const Color(0xFF167F67))),
    const Item('Uber', Icon(Icons.directions_car, color: const Color(0xFF167F67))),
    const Item('Other', Icon(Icons.directions_walk, color: const Color(0xFF167F67))),
  ];

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return FormItem(animation: animation, child: publicTransportList[index]);
  }

  Widget _removedItemBuilder(BuildContext context, Widget item, Animation<double> animation) {
    return FormItem(animation: animation, child: item);
  }

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pop(context);
    }

    // replace widget to get the context
    publicTransportList[publicTransportList.length - 3] = SubmitButton(
        highlightColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        validationFunction: validateForm,
        onSubmit: () async {
          databaseAdder.addModel(publicTransportModel, 'booking-addPublicTransport');
          showSubmittedBookingDialog(context, alertText, returnToTripScreen);
        });

    publicTransportList[publicTransportList.length - 2] = CancelButton(
      text: "CANCEL",
      onCancel: () {
        cancellingDialog(context, cancelText);
      },
    );

    return Scaffold(
      key: Key('Public Transport'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
                color: Color(0xFFCCD7DD),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () => returnToTripScreen(),
                      icon: FaIcon(FontAwesomeIcons.times),
                      iconSize: 26,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: -40,
                    child: Hero(
                      tag: 'trip_image${_tripModel.index.toString()}',
                      child: Container(
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_tripModel.imagePath),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    child: Container(
                      padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                          maxHeight: 100.0, maxWidth: MediaQuery.of(context).size.width - 200),
                      child: FashionFetishText(
                        text: _tripModel.name,
                        size: 24,
                        fontWeight: FashionFontWeight.HEAVY,
                        height: 1.05,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FashionFetishText(
                            text: 'From: ${DateConverter.format(_tripModel.startDate)}' +
                                '\n' +
                                'To: ${DateConverter.format(_tripModel.endDate)}',
                            color: Colors.black54,
                            fontWeight: FashionFontWeight.BOLD,
                            size: 14,
                            height: 1.25),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 15,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 3),
                              child: FashionFetishText(
                                text: _tripModel.destination,
                                size: 14,
                                fontWeight: FashionFontWeight.HEAVY,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                //child: Form(
                child: Container(
              height: double.infinity,
              child: Form(
                key: publicTransportFormKey,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: AnimatedList(
                        key: _listKey,
                        initialItemCount: publicTransportList.length,
                        itemBuilder: _itemBuilder,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
