import 'package:flutter/material.dart';
import 'globals.dart';

class StorePage extends StatefulWidget {
  @override
  _StoreState createState() {
    return _StoreState();
  }
}

class _StoreState extends State<StorePage> {

  @override
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
              title: Text('STORE'),
              centerTitle: true,
              backgroundColor: Colors.lightBlueAccent,
              shadowColor: Colors.transparent,
            ),
            body: TabBarView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                BoatStore(),
                CarStore(),

              ],
            ),
          ),
        ),
      );
  }

  static List<Tab> _tabs = [
    Tab(icon: Icon(Icons.sailing_rounded)),
    Tab(icon: Icon(Icons.directions_bus_filled_rounded)),
    //Tab(icon: Icon(Icons.rocket)),
    //Tab(icon: Icon(Icons.water_drop_rounded)),
  ];

}

class BoatStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Feature coming soon :)"));
  }
}

class CarStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Feature coming soon :)"));
  }
}