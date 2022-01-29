// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/screens/dashboard/chart.dart';
import 'package:me_medical_app/screens/profile_pages/view_profile.dart';
import 'package:me_medical_app/screens/inventory/inventory.dart';
import 'package:me_medical_app/screens/checkup_pages/patient_checkup.dart';
import 'package:me_medical_app/screens/patients_info/patient_list.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:me_medical_app/services/database.dart';
import 'package:me_medical_app/services/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final CollectionReference fireData =
      FirebaseFirestore.instance.collection('income');
  @override
  // void initState() {
  // _chartData = Provider.of<List<ChartData>?>(context) ?? [];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dashboard'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewProfilePage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Wrapper();
                      },
                    ),
                    (_) => false,
                  ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<List<ChartData>>(
            stream: DatabaseService(uid: AuthService().getCurrentUID()).profits,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'income info'),
                    primaryXAxis: DateTimeAxis(dateFormat: DateFormat.MMMMd()),
                    series: <ChartSeries<ChartData, dynamic>>[
                      LineSeries<ChartData, dynamic>(
                          dataSource: snapshot.data,
                          xValueMapper: (ChartData data, _) => data.month,
                          yValueMapper: (ChartData data, _) => data.income,
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                    ],
                  ),
                );

              return Text("No data");
            },
          ),
          // StreamBuilder<void>(
          //   stream: fireData.snapshots(),
          //               builder: (BuildContext context, AsyncSnapshot snapshot) {
          //                 Widget widget;
          //     if (snapshot.hasData) { List<ChartData> chartData = <ChartData>[];
          //      for (int index = 0; index < snapshot.data.documents.length; index++) {
          //       DocumentSnapshot documentSnapshot =
          //           snapshot.data.documents[index];
          //           chartData.add({month:documentSnapshot.date,});
          //     }
          //     widget = Container(
          //         child: SfCartesianChart(
          //       primaryXAxis: DateTimeAxis(),
          //       series: <ChartSeries<ChartData, dynamic>>[
          //         ColumnSeries<ChartData, dynamic>(
          //             dataSource: chartData,
          //             xValueMapper: (ChartData data, _) => data.month,
          //             yValueMapper: (ChartData data, _) => data.income)
          //       ],
          //     ));
          //     return widget;
          //   }
          //   return Text('no data');
          // },
          // ),

          // Padding(
          //           padding: const EdgeInsets.all(5.0),
          //           child: SfCartesianChart(
          //             title: ChartTitle(text: 'income info'),
          //             primaryXAxis: NumericAxis(
          //                 edgeLabelPlacement: EdgeLabelPlacement.shift),
          //             primaryYAxis: NumericAxis(
          //                 numberFormat:
          //                     NumberFormat.simpleCurrency(decimalDigits: 0)),
          //             series: <ChartSeries>[
          //               LineSeries<ChartData, int>(
          //                   dataSource: snapshot.data,
          //                   xValueMapper: (ChartData charts, _) => charts.month,
          //                   yValueMapper: (ChartData charts, _) => charts.income,
          //                   dataLabelSettings:
          //                       DataLabelSettings(isVisible: true)),
          //             ],
          //           ),
          //         );
          //       }
          //       return Text("No data");
          //     },
          //   ),
          Center(
              child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250.0,
            child: ListView(
              padding: EdgeInsets.all(50.0),
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Patient Check Up',
                      style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                  ),
                  //later implement the jump page function
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientCheckUp()));
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),

                // Handle your callback

                TextButton.icon(
                  icon: Icon(Icons.list_alt),
                  label: Text('Patient Information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      )),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                  ),
                  //later implement the jump page function
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientListPage()));
                  },
                ),

                SizedBox(
                  height: 20.0,
                ),
                TextButton.icon(
                  icon: Icon(Icons.medication),
                  label: Text('Medical Inventory',
                      style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                  ),
                  //later implement the jump page function
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InventoryPage()));
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // List<ChartData> getChartData() {
  //   final List<ChartData> chartData = profits()
  //   ];
  //   return chartData;
  // }
}
