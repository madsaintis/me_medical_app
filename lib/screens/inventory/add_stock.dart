import 'package:flutter/material.dart';
import 'stockList.dart';
import 'package:me_medical_app/services/database.dart';
import 'package:provider/provider.dart';

class AddStockPage extends StatefulWidget {
  const AddStockPage({Key? key}) : super(key: key);

  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Stock>?>.value(
      initialData: null,
      value: DatabaseService(uid: '').stocks,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Add Stock'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
        ),
        body: StockList(),
      ),
    );
  }
}
