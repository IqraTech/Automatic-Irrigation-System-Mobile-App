import 'package:automatic_irrigation/graph_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion\_flutter\_gauges/gauges.dart';
import 'networking.dart';

// class SensorData extends StatelessWidget {
//
// }

class SensorData extends StatefulWidget {
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  int currentSensorData = 0;

  void getCurrentData() async {
    setState(() {});
    var url =
        Uri.parse("https://api.waziup.io/api/v2/devices/0242ac1200025604");
    Networker data = Networker(url);

    var sensorData = await data.getData();
    if (sensorData == null) {
      currentSensorData = 0;
    } else {
      currentSensorData = sensorData['sensors'][0]['value']['value'];
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentData();
    return Scaffold(
      appBar: AppBar(
          title: Text('irriGate',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCC2B5E)))),
      body: Center(
        child: Container(
          width: 280,
          height: 350,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
              color: Color(0xFF212121),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      angle: 90,
                      axisValue: 5,
                      positionFactor: 0.2,
                      widget: Text('$currentSensorData%',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFCC2B5E)))),
                  GaugeAnnotation(
                      angle: 90,
                      axisValue: 5,
                      positionFactor: 1.3,
                      widget: Text('Moisture Content',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFCC2B5E))))
                ],
                pointers: <GaugePointer>[
                  RangePointer(
                      value: currentSensorData.toDouble(),
                      cornerStyle: CornerStyle.bothCurve,
                      width: 25,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      gradient: const SweepGradient(
                          colors: <Color>[Color(0xFFCC2B5E), Color(0xFF753A88)],
                          stops: <double>[0.25, 0.75])),
                  MarkerPointer(
                      value: currentSensorData.toDouble(),
                      enableDragging: true,
                      markerHeight: 34,
                      markerWidth: 34,
                      markerType: MarkerType.circle,
                      color: Color(0xFF753A88),
                      borderWidth: 2,
                      borderColor: Colors.white54)
                ],
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                    cornerStyle: CornerStyle.bothCurve,
                    color: Colors.white30,
                    thickness: 25),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GraphPage();
              },
            ),
          );
        },
        label: Text('Show Graph'),
        icon: const Icon(Icons.analytics_outlined),
        backgroundColor: Color(0xFF212121),
        foregroundColor: Color(0xFFCC2B5E),
      ),
    );
  }
}
