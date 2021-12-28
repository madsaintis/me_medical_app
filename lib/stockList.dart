import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/editStock.dart';
import 'package:me_medical_app/inventory.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:me_medical_app/services/database.dart';
import 'package:provider/provider.dart';

class Stock {
  final String name;
  final int inStock;
  final int buyPrice;

  Stock({required this.name, required this.inStock, required this.buyPrice});
}

class addForm extends StatefulWidget {
  const addForm({Key? key}) : super(key: key);

  @override
  _addFormState createState() => _addFormState();
}

class _addFormState extends State<addForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class StockCards extends StatefulWidget {
  // const StockCards({Key? key}) : super(key: key);
  final Stock stock;
  StockCards({required this.stock});

  @override
  _StockCardsState createState() => _StockCardsState();
}

class _StockCardsState extends State<StockCards> {
  final _formKey = GlobalKey<FormState>();

  int? _currentStock;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${widget.stock.name}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'in stock:',
                      style: TextStyle(fontSize: 12),
                    ),
                    TextFormField(
                      initialValue:
                          (_currentStock ?? widget.stock.inStock).toString(),
                      validator: (val) =>
                          val!.isEmpty ? 'no stock added!' : null,
                      onChanged: (val) => setState(() {
                        if (val.isNotEmpty) {
                          _currentStock = int.parse(val);
                        }
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.brown[400],
                            child: Text(
                              'update',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await DatabaseService(
                                        uid: AuthService().getCurrentUID())
                                    .updateStock(
                                        widget.stock.name,
                                        widget.stock.buyPrice,
                                        _currentStock ?? widget.stock.inStock);
                                Navigator.pop(context);
                              }
                            }),
                        SizedBox(
                          width: 8,
                        ),
                        RaisedButton(
                            color: Colors.brown[400],
                            child: Text(
                              'delete',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              await DatabaseService(
                                      uid: AuthService().getCurrentUID())
                                  .deleteStock();
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: InkWell(
          onTap: () {
            _showSettingsPanel();
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: (Text(
                  '\t\t${widget.stock.inStock}\npiece',
                  style: TextStyle(fontSize: 17),
                )),
                title: Text(
                  widget.stock.name,
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text(
                  'RM${widget.stock.buyPrice * widget.stock.inStock}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                      child: const Text(
                        'add',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        // _showEditStock();
                      }),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text(
                      'delete',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Delete'),
                        content: const Text(
                            'do you want to procced deleting the item?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Yes'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StockList extends StatefulWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    final stocks = Provider.of<List<Stock>?>(context) ?? [];

    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        return StockCards(stock: stocks[index]);
      },
    );
  }
}