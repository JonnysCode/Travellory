import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';

class TestWrapper extends StatefulWidget {
  @override
  _TestWrapperState createState() => _TestWrapperState();
}

class _TestWrapperState extends State<TestWrapper> {
  @override
  void initState() {
    print('been here dine that');
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _changePage(context));
  }

  Future<void> _changePage(BuildContext context) async {
    TripModel tripModel = TripModel(
        name: 'Castle Discovery',
        startDate: DateTime(2020, 5, 12),
        endDate: DateTime(2020, 5, 25),
        destination: 'Munich',
        imageNr: 3
    );
    await Navigator.pushNamed(context, '/booking/rentalCar', arguments: tripModel);
    print('rentalCar has been pushed');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
