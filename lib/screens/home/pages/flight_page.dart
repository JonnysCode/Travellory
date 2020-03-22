import 'package:flutter/material.dart';
import 'package:travellory/models/flightModel.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FlightPage extends StatefulWidget {
  @override
  _FlightPageState createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  final TextEditingController _bookingReferenceController =
      TextEditingController();
  final TextEditingController _airlineController = TextEditingController();
  final TextEditingController _flightNrController = TextEditingController();
  final TextEditingController _seatController = TextEditingController();
  final TextEditingController _departureLocationController =
      TextEditingController();
  final TextEditingController _departureTimeController =
      TextEditingController();
  final TextEditingController _arrivalLocationController =
      TextEditingController();
  final TextEditingController _arrivalTimeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _valueBaggage = false;
  bool _valueExcessBaggage = false;

  void _valueBaggageChanged(bool value) =>
      setState(() => _valueBaggage = value);

  void _valueExcessBaggageChanged(bool value) =>
      setState(() => _valueExcessBaggage = value);

  @override
  Widget build(BuildContext context) {
    Widget buttonSection = Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Add Flight',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    Widget flight = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextField(
              controller: _bookingReferenceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Booking Reference',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _airlineController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Airline',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _flightNrController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Flight Nr.',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _seatController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Seat',
              ),
            ),
          ],
        ),
      ),
    );

    Widget departure = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            Text(
              'Departure',
              style: TextStyle(fontSize: 20),
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _departureLocationController,
                  decoration: InputDecoration(hintText: "Location"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _departureTimeController,
                  decoration: InputDecoration(hintText: "Date / Time"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ])
          ],
        ),
      ),
    );

    Widget arrival = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            Text(
              'Arrival',
              style: TextStyle(fontSize: 20),
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _arrivalLocationController,
                  decoration: InputDecoration(hintText: "Location"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _arrivalTimeController,
                  decoration: InputDecoration(hintText: "Date / Time"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ])
          ],
        ),
      ),
    );

    Widget baggage = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: new Column(
        children: <Widget>[
          new CheckboxListTile(
              value: _valueBaggage,
              onChanged: _valueBaggageChanged,
              title: new Text(
                'Checked baggage included in ticket?',
                style: TextStyle(fontSize: 16),
              ),
              controlAffinity: ListTileControlAffinity.leading),
          new CheckboxListTile(
              value: _valueExcessBaggage,
              onChanged: _valueExcessBaggageChanged,
              title: new Text(
                'Excess baggage included in ticket?',
                style: TextStyle(fontSize: 16),
              ),
              controlAffinity: ListTileControlAffinity.leading),
        ],
      ),
    );

    Widget notes = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            // TODO: adapt height
            SizedBox(height: 40.0),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Notes',
              ),
            ),
            RaisedButton(
              key: Key('testFunctionCall'),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add Flight',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                FlightModel flight = new FlightModel(
                    bookingReference: _bookingReferenceController.text,
                    airline: _airlineController.text,
                    flightNr: _flightNrController.text,
                    seat: _seatController.text,
                    departureLocation: _departureLocationController.text,
                    departureTime: _departureTimeController.text,
                    arrivalLocation: _arrivalLocationController.text,
                    arrivalTime: _arrivalTimeController.text,
                    checkedBaggage: _valueBaggage,
                    excessBaggage: _valueExcessBaggage,
                    notes: _notesController.text);
                _addFlight(flight);
              },
            ),
          ],
        ),
      ),
    );
    return Container(
        key: Key('flight_page'),
        child: ListView(
          children: [buttonSection, flight, departure, arrival, baggage, notes],
        ));
  }
}

void _addFlight(FlightModel flight) async {
  HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'booking-addFlight');
  try {
    final HttpsCallableResult result = await callable.call(<String, dynamic>{
      "bookingReference": flight.bookingReference,
      "airline": flight.airline,
      "flightNr": flight.flightNr,
      "seat": flight.seat,
      "departureLocation": flight.departureLocation,
      "departureTime": flight.departureTime,
      "arrivalLocation": flight.arrivalLocation,
      "arrivalTime": flight.arrivalTime,
      "checkedBaggage": flight.checkedBaggage,
      "excessBaggage": flight.excessBaggage,
      "notes": flight.notes
    });
    print(result.data);
  } on CloudFunctionsException catch (e) {
    print('caught firebase functions exception');
    print(e.code);
    print(e.message);
    print(e.details);
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}
