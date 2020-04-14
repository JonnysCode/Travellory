import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/trip_card.dart';

class TripList extends StatefulWidget {
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('home_page'),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 40, right: 25),
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 160,
                    child: FashionFetishText(
                      text: 'Upcoming Trips',
                      size: 22,
                      height: 1.15,
                      fontWeight: FashionFontWeight.heavy,
                    ),
                  ),
                  Positioned(
                    top: 24,
                    right: 36,
                    child: FashionFetishText(
                      text: 'Add',
                      size: 16,
                      color: Colors.black54,
                      fontWeight: FashionFontWeight.bold,
                    ),
                  ),
                  Positioned(
                    top: 11,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/createtrip'),
                      child: Container(
                        height: 32,
                        width: 32,
                        padding: EdgeInsets.only(top: 20, right: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/home/trip/add.png'),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: tripModels.length + 1,
              itemBuilder: (context, index) {
                if(index < tripModels.length){
                  final tripModel = tripModels[index] // TODO: Load trips from firestore
                      ..index = index
                      ..init();
                  return TripCard(tripModel: tripModel);
                } else {
                  return  _bottomMargin();
                }
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomMargin(){
    return SizedBox(
      height: 40,
    );
  }
}
