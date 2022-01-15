import 'package:flutter/material.dart';

class CheckUpDetail extends StatefulWidget {
  String? patientName;
  String? patientIC;
  String? date;
  List<String> medicine;
  String? description;

  CheckUpDetail(
      {this.patientName,
      this.patientIC,
      this.date,
      required this.medicine,
      this.description});

  @override
  CheckUpDetailState createState() => CheckUpDetailState();
}

class CheckUpDetailState extends State<CheckUpDetail> {
  List<Widget> textWidgetList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    if (textWidgetList.isEmpty) {
      for (int i = 0; i < widget.medicine.length; i++) {
        textWidgetList.add(Text(widget.medicine[i],
            style: const TextStyle(
              fontSize: 16.0,
            )));
      }
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              const Text("Check Up Details", overflow: TextOverflow.ellipsis),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              widget.medicine.clear();
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(
              left: 30.0, right: 20.0, top: 40.0, bottom: 20.0),
          child: Column(
            children: [
              Row(children: [
                const Expanded(
                    flex: 2,
                    child: Text("Patient Name",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text(widget.patientName!,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ))),
              ]),
              const SizedBox(
                height: 40,
              ),
              Row(children: [
                const Expanded(
                    flex: 2,
                    child: Text("Patient IC",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text(widget.patientIC!,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ))),
              ]),
              const SizedBox(
                height: 40,
              ),
              Row(children: [
                const Expanded(
                    flex: 2,
                    child: Text("Check Up Date",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text(widget.date!,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ))),
              ]),
              const SizedBox(
                height: 40,
              ),
              Row(children: [
                const Expanded(
                    flex: 2,
                    child: Text("Medications",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: textWidgetList,
                    )),
              ]),
              const SizedBox(
                height: 40,
              ),
              Row(children: [
                const Expanded(
                    flex: 2,
                    child: Text("Description",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text(widget.description!,
                        style: TextStyle(
                          fontSize: 16.0,
                        ))),
              ]),
            ],
          ),
        ));
  }
}
