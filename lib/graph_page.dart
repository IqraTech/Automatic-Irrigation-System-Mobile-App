import 'package:automatic_irrigation/networking.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'sensor_data.dart';

class GraphPage extends StatefulWidget {
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  static double day1 = 0.0;
  static double day2 = 0;
  static double day3 = 0;
  static double day4 = 0;
  static double day5 = 0;
  static double day6 = 0;
  static double day7 = 0;
  static double day8 = 0;
  static double day9 = 0;
  static double day10 = 0;
  List<SensorData> data = [
    SensorData("Day1", day1),
    SensorData('Day2', day2),
    SensorData('Day3', day3),
    SensorData('Day4', day4),
    SensorData('Day5', day5),
    SensorData('Day6', day6),
    SensorData('Day7', day7),
    SensorData('Day8', day8),
    SensorData('Day9', day9),
    SensorData('Day10', day10),
  ];

  void getGraphData() async {
    setState(() {});
    var url = Uri.parse(
        "https://api.waziup.io/api/v2/devices/0242ac1200025604/sensors/temperatureSensor_1/values");
    Networker data = Networker(url);

    var sensorData = await data.getData();
    if (sensorData == null) {
      // currentSensorData = 0;
    } else {
      day1 = sensorData[0]['value'];
      day2 = sensorData[10]['value'];
      day3 = sensorData[15]['value'];
      day4 = sensorData[20]['value'];
      day5 = sensorData[25]['value'];
      day6 = sensorData[30]['value'];
      day7 = sensorData[35]['value'];
      day8 = sensorData[40]['value'];
      day9 = sensorData[45]['value'];
      day10 = sensorData[50]['value'];
      print(day1);
      // 19.value
      // 0.value
    }
  }
  // sensors[0].value.value

  @override
  Widget build(BuildContext context) {
    getGraphData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Graph',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCC2B5E))),
      ),
      body: Center(
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Soil Sensor Data'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<SensorData, String>>[
              LineSeries<SensorData, String>(
                  dataSource: data,
                  xValueMapper: (SensorData sales, _) => sales.day,
                  yValueMapper: (SensorData sales, _) => sales.values,
                  name: 'Moisture Content',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
      ),
    );
  }
}
