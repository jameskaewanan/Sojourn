import 'package:flutter/material.dart';
import 'globals.dart';

class LocationsPage extends StatefulWidget {

  @override
  _LocationsState createState() {
    return _LocationsState();
  }
}

class _LocationsState extends State<LocationsPage> {

  Widget build(BuildContext context) {
    return
      Container(
        child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.clear_rounded),
            ),
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
              overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.focused)) {
                  return Colors.orange;
                } else if (states.contains(MaterialState.hovered)) {
                  return Colors.pinkAccent;
                }

                return Colors.transparent;
              }),
              indicatorWeight: 0,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(5),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              isScrollable: true,
              physics: BouncingScrollPhysics(),
              onTap: (int index) {
                print('Tab $index is tapped');
              },
              enableFeedback: true,
              tabs: _tabs,
            ),
            title: Text('LOCATIONS DISCOVERED'),
            centerTitle: true,
            backgroundColor: Colors.lightBlueAccent,
            shadowColor: Colors.transparent,
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              islandLocations(),
              comingSoonLocations(),

            ],
          ),
        ),
      ),
    );
  }

  static List<Tab> _tabs = [
    Tab(icon: Icon(Icons.sailing_rounded)),
    Tab(icon: Icon(Icons.question_mark_rounded)),
    //Tab(icon: Icon(Icons.rocket)),
    //Tab(icon: Icon(Icons.water_drop_rounded)),
    //Tab(icon: Icon(Icons.directions_bus_filled_rounded)),
  ];

}

class islandLocations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: Globals.inList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          width: 73,
                          height: 73,
                          decoration: BoxDecoration(
                            image:DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/theme_boat/locationIcons/${Globals.inList[index]}.png',),
                            ),
                          ),
                        ),

                        title: Text("${Globals.boatIslandName[Globals.inList[index]-1]}"),
                        subtitle: Text("${Globals.boatIslandDesc[Globals.inList[index]-1]}"),
                        dense: false,
                        isThreeLine: true,
                      ),
                    ],
                  ),
                ),
              );
            })
    );
  }
}

class comingSoonLocations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("More locations and themes are coming soon :)"));
  }
}