import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:math';
import 'main.dart';
import 'settings.dart';
import 'stats.dart';
import 'locations.dart';
import 'globals.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() {
    return _TimerPageState();
  }
}

class _TimerPageState extends State<TimerPage> {

  cardGenerator() {
    setState(() {
      if (Globals.location == 0) {
        print("None");
      }
      else if (Globals.inList.contains(Globals.location) == false) {
        Globals.inList.add(Globals.location);
      }
    });
  }

  weekDataHandler () {

    // Increase maximum Y of graph if bar is approaching limit
    for (var i = 0; i < Globals.daysMins.length; i++) {
      if (Globals.daysMins[i] >= Globals.maxY - 60) {
        Globals.maxY += 60;
      }
    }

    // Reset at start of new week
    if (DateTime.now().weekday == 1 && Globals.daysMins[6] != 0) {
      Globals.daysMins.setAll(0, [0, 0, 0, 0, 0, 0, 0]);
    }

    if (DateTime.now().weekday == 1) { // Monday
      Globals.daysMins[0] += Globals.mins;
    }
    if (DateTime.now().weekday == 2) { // Tuesday
      Globals.daysMins[1] += Globals.mins;
    }
    if (DateTime.now().weekday == 3) { // Wednesday
      Globals.daysMins[2] += Globals.mins;
    }
    if (DateTime.now().weekday == 4) { // Thursday
      Globals.daysMins[3] += Globals.mins;
    }
    if (DateTime.now().weekday == 5) { // Friday
      Globals.daysMins[4] += Globals.mins;
    }
    if (DateTime.now().weekday == 6) { // Saturday
      Globals.daysMins[5] += Globals.mins;
    }
    if (DateTime.now().weekday == 7) { // Sunday
      Globals.daysMins[6] += Globals.mins;
    }
  }

  locationDisplayer () {
    var rng = Random();
    Globals.location = (1 + (rng.nextInt(7 - 1)));

    Globals.displayIMG = 'assets/${Globals.theme}/locations/${Globals.location}.png';
    Globals.returnText = "RETURN HOME";
  }

  updatebasicStats () {
    Globals.completedHours += (Globals.mins/60).round();
    Globals.completedCount += 1;
  }

  coinGenerator () {
    var rng = Random();
    if (Globals.mins <= 25) {
      Globals.coinsEarned = (50 + (rng.nextInt(100 - 50)));
      Globals.coins = Globals.coinsEarned;
      print(Globals.coinsEarned);
    } else if (Globals.mins >= 30) {
      Globals.coinsEarned = (100 + (rng.nextInt(200 - 100)));
      Globals.coins = Globals.coinsEarned;
      print(Globals.coinsEarned);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffffffff), Color.fromARGB(
                          220, 56, 192, 255)
                      ],
                      begin: FractionalOffset(1, 0.8)
                  )
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  SizedBox(height: 25),

                  Row(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: FloatingActionButton(
                          elevation: 0,
                          child: const Icon(Icons.home_rounded, size: 50, color: Colors.lightBlueAccent,),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          backgroundColor: Colors.white,
                        ),
                      ),

                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: FloatingActionButton(
                          elevation: 0,
                          child: const Icon(Icons.pin_drop_rounded, size: 50, color: Colors.lightBlueAccent,),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => LocationsPage()));
                          },
                          backgroundColor: Colors.white,
                        ),
                      ),

                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: FloatingActionButton(
                          elevation: 0,
                          child: const Icon(Icons.settings, size: 50, color: Colors.lightBlueAccent,),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SettingsPage()),);
                          },
                          backgroundColor: Colors.white,
                        ),
                      ),

                    ],
                  ),

                  Spacer(),

                  CircularCountDownTimer(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: MediaQuery.of(context).size.width / 1.4,
                    duration: Globals.mins*60,
                    ringColor: Colors.white38,
                    fillColor: Color.fromARGB(255, 255, 222, 89),
                    backgroundColor: Color.fromARGB(255, 255, 222, 89),
                    strokeWidth: 20.0,
                    isReverse: true,
                    isReverseAnimation: false,
                    textStyle: TextStyle(
                        fontSize: 70, color: Colors.white, fontWeight: FontWeight.bold),
                    textFormat: CountdownTextFormat.MM_SS,
                    onComplete: () {
                      setState(() {
                        weekDataHandler();
                        updatebasicStats();
                        locationDisplayer();
                        cardGenerator();
                      });
                      coinGenerator();
                      showDialog(
                          context: context,
                          builder:(context) {
                            return ButtonBarTheme(
                                data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                  title: Center(child: Text("VOYAGE COMPLETE!")),

                                  actions: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[

                                        Column(
                                          children: <Widget>[

                                            Row(
                                              children: <Widget>[
                                                Text("Congratulations, You've earned:"),
                                              ],
                                            ),

                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "${Globals.coinsEarned}",
                                                  style: const TextStyle(
                                                      fontSize: 100,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.yellow ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "Coins",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.yellow ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 20,),

                                            Row(
                                              children: <Widget>[
                                                Text("You can spend these coins in the coin shop!"),
                                              ],
                                            ),

                                            SizedBox(height: 20,),

                                            Container(

                                              width: MediaQuery.of(context).size.width * 0.20,
                                              child: RaisedButton(
                                                child: new Text(
                                                  'OK',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                color: Colors.lightBlue,
                                                shape: new RoundedRectangleBorder(
                                                  borderRadius: new BorderRadius.circular(30.0),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                  ],

                                  content: Text("You deserve a rest, dock your vessel and reflect on your journey.", textAlign: TextAlign.center),
                                )
                            );
                          });
                    },
                  ),

                  SizedBox(height: 69),

                  Stack(
                      children: <Widget>[

                        Image(image: AssetImage(Globals.displayIMG), height: 302.9, width: double.infinity, fit: BoxFit.fill,),

                        Container(
                          padding: EdgeInsets.only(top: 175),
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            child: Text("${Globals.returnText}",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent,
                                )),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.white,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                            onPressed: () {
                              Globals.returnText = "CANCEL VOYAGE";
                              Globals.displayIMG = Globals.defaultDisplayIMG;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Sojourn()));
                            },
                          ),
                        ),

                      ]
                  ),

                ],
              ),
            ),
          ),

    );
  }
}