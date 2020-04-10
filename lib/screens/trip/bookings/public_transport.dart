import 'package:flutter/material.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/list_models.dart';
import 'package:travellory/screens/trip/bookings/bookings.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/dropdown.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';

import 'header.dart';

class PublicTransport extends StatefulWidget {
  @override
  _PublicTransportState createState() => _PublicTransportState();
}

class _PublicTransportState extends State<PublicTransport> {
  ListModel<Widget> publicTransportList;
  final GlobalKey<FormState> publicTransportFormKey = GlobalKey<FormState>();
  final PublicTransportModel publicTransportModel = PublicTransportModel();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<DateFormFieldState> _depDateFormFieldKey = GlobalKey<DateFormFieldState>();
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
    final List<Widget> shown = [
      BookingSiteTitle('Add Public Transport', Icons.train),
      SectionTitle('Type of Transportation'),
      transportTypeDropdown,
      TravelloryFormField(
          labelText: 'Company',
          icon: Icon(Icons.supervised_user_circle),
          optional: true,
          onChanged: (value) => publicTransportModel.company = value),
      SectionTitle('Departure Information'),
      TravelloryFormField(
        labelText: 'Departure Location *',
        icon: Icon(Icons.location_on),
        optional: false,
        onChanged: (value) => publicTransportModel.departureLocation = value,
      ),
      DateFormField(
        key: _depDateFormFieldKey,
        labelText: 'Departure Date *',
        icon: Icon(Icons.date_range),
        chosenDateString: (value) => publicTransportModel.departureDate = value,
      ),
      TimeFormField(
        labelText: 'Departure Time *',
        icon: Icon(Icons.access_time),
        chosenTimeString: (value) => publicTransportModel.departureTime = value,
      ),
      SectionTitle('Arrival Information'),
      TravelloryFormField(
        labelText: 'Arrival Location *',
        icon: Icon(Icons.location_on),
        optional: false,
        onChanged: (value) => publicTransportModel.arrivalLocation = value,
      ),
      DateFormField(
        labelText: 'Arrival Date *',
        icon: Icon(Icons.date_range),
        beforeDateKey: _depDateFormFieldKey,
        dateValidationMessage: 'Departure Date cannot be before Arrival Date',
        chosenDateString: (value) => publicTransportModel.arrivalDate = value,
      ),
      TimeFormField(
        labelText: 'Arrival Time',
        icon: Icon(Icons.access_time),
        optional: true,
        chosenTimeString: (value) => publicTransportModel.arrivalTime = value,
      ),
      SectionTitle('Booking Details'),
      bookingMadeCheckbox,
      seatReservedCheckbox,
      SectionTitle('Notes'),
      TravelloryFormField(
        labelText: 'Notes',
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
          labelText: 'Specific Type of Transportation',
          icon: Icon(Icons.train),
          optional: true,
          onChanged: (value) => publicTransportModel.specificType = value,
        ),
      ],
    );

    bookingMadeAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          labelText: 'Booking Reference',
          icon: Icon(Icons.confirmation_number),
          optional: true,
          onChanged: (value) => publicTransportModel.reference = value,
        ),
        TravelloryFormField(
          labelText: 'Booking Company',
          icon: Icon(Icons.supervised_user_circle),
          optional: true,
          onChanged: (value) => publicTransportModel.companyReservation = value,
        ),
      ],
    );

    seatReservationAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          labelText: 'Seat',
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
    const Item('Rail', Icon(Icons.directions_railway, color: Color(0xFF167F67))),
    const Item('Bus', Icon(Icons.directions_bus, color: Color(0xFF167F67))),
    const Item('Metro', Icon(Icons.train, color: Color(0xFF167F67))),
    const Item('Ferry', Icon(Icons.directions_boat, color: Color(0xFF167F67))),
    const Item('Taxi', Icon(Icons.directions_car, color: Color(0xFF167F67))),
    const Item('Uber', Icon(Icons.directions_car, color: Color(0xFF167F67))),
    const Item('Other', Icon(Icons.directions_walk, color: Color(0xFF167F67))),
  ];

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return FormItem(animation: animation, child: publicTransportList[index]);
  }

  Widget _removedItemBuilder(BuildContext context, Widget item, Animation<double> animation) {
    return FormItem(animation: animation, child: item);
  }

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;

    // replace widget to get the context
    publicTransportList[publicTransportList.length - 3] = SubmitButton(
        highlightColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        validationFunction: validateForm,
        onSubmit: onSubmitBooking(publicTransportModel, 'booking-addPublicTransport', context, alertText),
        );

    publicTransportList[publicTransportList.length - 2] = CancelButton(
      text: 'CANCEL',
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
            getBookingHeader(context, tripModel),
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
