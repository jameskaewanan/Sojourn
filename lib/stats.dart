import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'store.dart';
import 'globals.dart';

class HomePage extends StatefulWidget {

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffffffff), Color.fromARGB(
                  220, 56, 192, 255)
              ],
              begin: FractionalOffset(1, 0.8)
          )
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(120, 56, 192, 255),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear_rounded),
          ),
          title: Text(
            "STATISTICS",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              TotalNumbers(),
              SizedBox(height: 12),
              CoinShop(),
              SizedBox(height: 12),
              LineGraph(),
              //SizedBox(height: 12),
              //WorkDistribution(),
            ],
          )
        ),

      ),
    );
  }

}

class TotalNumbers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
        ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("${Globals.completedHours}", style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue ),),
                  Text("Total Hours Ventured", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),
                  SizedBox(height: 7),
                ],
              ),
              VerticalDivider(thickness: 0.75, ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("${Globals.completedCount}", style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue ),),
                  Text("Voyages Completed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),
                  SizedBox(height: 7),
                ],
              ),

            ],
          ),

      ),
    );
  }
}

class CoinShop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: InkWell(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Store", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StorePage()));
        },
      )
    );
  }
}

class LineGraph extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Daily Study Time (mins)", style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue)),
                ],
              ),
            ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: BarChart(
                  BarChartData(
                    barTouchData: barTouchData,
                    titlesData: titlesData,
                    borderData: borderData,
                    barGroups: barGroups,
                    gridData: FlGridData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: Globals.maxY,
                  ),
                ),
              ),

          ],
        ),




      )
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: const EdgeInsets.all(0),
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );


  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    leftTitles: AxisTitles(),
    rightTitles: AxisTitles(),
    topTitles: AxisTitles(),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: bottomTitles,
        reservedSize: 42,
      ),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: Globals.daysMins[0].toDouble(),
          gradient: _barsGradient,
          width: 16,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: Globals.daysMins[1].toDouble(),
          gradient: _barsGradient,
          width: 16,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: Globals.daysMins[2].toDouble(),
          gradient: _barsGradient,
          width: 16,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: Globals.daysMins[3].toDouble(),
          gradient: _barsGradient,
          width: 16,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: Globals.daysMins[4].toDouble(),
          gradient: _barsGradient,
          width: 16,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(
          toY: Globals.daysMins[5].toDouble(),
          gradient: _barsGradient,
          width: 16,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 6,
      barRods: [
        BarChartRodData(
          toY: Globals.daysMins[6].toDouble(),
          gradient: _barsGradient,
          width: 16,
        )
      ],
      showingTooltipIndicators: [0],
    ),
  ];

}

class WorkDistribution extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Work Distribution", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          ],
        ),
      ),
    );
  }
}

