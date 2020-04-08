import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/trip/trip_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget _bottomMargin(){
    return SizedBox(
      height: 62,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('home_page'),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 65, left: 25, right: 25),
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Text(
                      'Upcoming trips',
                      style: TextStyle(
                          fontFamily: 'FashionFetish',
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          letterSpacing: -2.0,
                          height: 1.15
                      ),
                    ),
                  ),
                  Positioned(
                    top: 24,
                    right: 42,
                    child: Text(
                      'Add trip',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'FashionFetish',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: -2.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _openCreateTripScreen(),
                      child: Container(
                        height: 36,
                        width: 36,
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
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: tripModels.length + 1,
              itemBuilder: (context, index) {
                if(index < tripModels.length){
                  final tripModel = tripModels[index];
                  tripModel.index = index;
                  return TripCard(tripModel: tripModel);
                } else {
                  return  _bottomMargin();
                }
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }

  _openCreateTripScreen() {
    Navigator.pushNamed(context, '/createtrip');
  }
}
