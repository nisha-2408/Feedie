import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/screens/hunger_spot_donate.dart';
import 'package:flutter/material.dart';
import 'package:feedie/models/hunger_spot_data.dart';
import 'package:provider/provider.dart';

class HungerSpotCarousel extends StatelessWidget {
  const HungerSpotCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    List<HungerSpotData> data = Provider.of<HungerSpot>(context, listen: false).allHungerData;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Hunger Spots',
                  style: TextStyle(
                    color: Color.fromARGB(255, 26, 26, 26),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(HungerSpotDonate.routeName),
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ]),
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: 300,
          child: data.isNotEmpty ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10.0),
                width: 260.0,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      bottom: 15.0,
                      child: Container(
                        height: 120.0,
                        width: 260.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                data[index].hungerSpotName,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 26, 26, 26),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.0),
                              ),
                              Text(
                                'Population: ${data[index].population}',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                data[index].address,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          height: 180.0,
                          width: 240.0,
                          image: NetworkImage(data[index].images[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ) : Text('No hunger spot'),
        )
      ],
    );
  }
}
