import 'package:flutter/material.dart';
import 'timer.dart';
import 'settings.dart';
import 'stats.dart';
import 'locations.dart';
import 'globals.dart';


void main() {
  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    home: Sojourn(),

  ));
}

class Sojourn extends StatefulWidget {
  @override
  _SojournState createState() => _SojournState();

}

class _SojournState extends State<Sojourn> with SingleTickerProviderStateMixin {

  Future<Null> minusTime(StateSetter updateState) async{
    updateState(() {
      if(Globals.mins - 5 == 0) {
        Globals.mins = 5;
      } else {
        Globals.mins -= 5;
      }
    });
  }

  Future<Null> addTime(StateSetter updateState) async{
    updateState(() {
      if(Globals.mins + 5 == 65) {
        Globals.mins = 60;
      } else {
        Globals.mins += 5;
      }
    });
  }

  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
              child: Container (
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffffffff), Color.fromARGB(220, 56, 192, 255)],
                        begin: FractionalOffset(1,0.8)
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RotationTransition(
                            turns: _animation,
                            child: Image(image: AssetImage('assets/theme_boat/images/sun.png'), width: 300, height: 300,)
                        ),
                      ],
                    ),

                    SizedBox(height: 89),

                    Stack(
                        children: <Widget>[
                          Image(image: AssetImage('assets/theme_boat/images/waveboat.png'), height: 302.9, width: double.infinity, fit: BoxFit.fill,),

                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 165),
                              child: ElevatedButton(
                                child: const Text(
                                    "SET A COURSE",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlueAccent
                                    )
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.white,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                ),


                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.elliptical(150, 50)
                                          )
                                      ),
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(builder: (context, state) {
                                          return Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: const <Widget>[
                                                      Text(
                                                        "SET YOUR COURSE",
                                                        style: TextStyle(
                                                            fontSize: 40,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.lightBlue ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      FloatingActionButton(
                                                        child: const Icon(Icons.remove),
                                                        onPressed: () { minusTime(state);},
                                                        backgroundColor: Colors.lightBlue,
                                                      ),
                                                      Text(
                                                        "${Globals.mins}",
                                                        style: const TextStyle(
                                                            fontSize: 100,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.lightBlue ),
                                                      ),
                                                      FloatingActionButton(
                                                        child: const Icon(Icons.add),
                                                        onPressed: () { addTime(state);},
                                                        backgroundColor: Colors.lightBlue,
                                                      ),
                                                    ],
                                                  ),
                                                  Row (
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: const <Widget>[
                                                      Text(
                                                        "Minutes",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.lightBlue ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      ElevatedButton(
                                                        child: const Text(
                                                            "EMBARK",
                                                            style: TextStyle(
                                                              fontSize: 60,
                                                              fontWeight: FontWeight.bold,
                                                            )
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => TimerPage()),
                                                          );
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              )
                                                          ),
                                                        ),

                                                      )
                                                    ],

                                                  )
                                                ],
                                              )
                                          );
                                        });
                                      }
                                  );
                                },
                              )
                          )
                        ]
                    )

                  ],
                ),

              ),
            ),
    );
  }
}

