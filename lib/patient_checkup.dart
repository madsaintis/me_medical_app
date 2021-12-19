import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/dashboard.dart';

class Quantity extends StatefulWidget {
  CartItem? cartItem;

  Quantity({this.cartItem});
  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  String? _value = "Flavor 1";

  @override
  void initState() {
    super.initState();
    _value = widget.cartItem!.quantity;
  }

  @override
  void didUpdateWidget(Quantity oldWidget) {
    if (oldWidget.cartItem!.quantity != widget.cartItem!.quantity) {
      _value = widget.cartItem!.quantity!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(onChanged: (String? value) {
        setState(() {
          _value = value;
          widget.cartItem!.quantity = value as String?;
        });
      }),
    );
  }
}

class Pizza extends StatefulWidget {
  CartItem? cartItem;

  Pizza({this.cartItem});
  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  String? _value = "";

  @override
  void initState() {
    super.initState();
    _value = widget.cartItem!.itemName!;
  }

  @override
  void didUpdateWidget(Pizza oldWidget) {
    if (oldWidget.cartItem!.itemName != widget.cartItem!.itemName) {
      _value = widget.cartItem!.itemName!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
          value: _value,
          items: [
            DropdownMenuItem(
              child: Text("Pizza 1"),
              value: "Pizza 1",
            ),
            DropdownMenuItem(
              child: Text("Pizza 2"),
              value: "Pizza 2",
            ),
            DropdownMenuItem(child: Text("Pizza 3"), value: "Pizza 3"),
            DropdownMenuItem(child: Text("Pizza 4"), value: "Pizza 4")
          ],
          onChanged: (String? value) {
            setState(() {
              _value = value;
              widget.cartItem!.itemName = value as String?;
            });
          }),
    );
  }
}

class CartItem {
  String? productType;
  String? itemName;
  String? quantity;
  CartItem({this.productType, this.itemName, this.quantity});
}

class CartWidget extends StatefulWidget {
  List<CartItem>? cart;
  int? index;
  VoidCallback? callback;

  CartWidget({this.cart, this.index, this.callback});
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Pizza(cartItem: widget.cart![widget.index!])),
        Expanded(child: Quantity(cartItem: widget.cart![widget.index!])),
        Expanded(
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                print(widget.index);
                widget.cart!.removeAt(widget.index!);
                widget.callback!();
              });
            },
          ),
        )
      ],
    );
  }
}

class PatientCheckUp extends StatefulWidget {
  PatientCheckUp({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _PatientCheckUpState createState() => _PatientCheckUpState();
}

class _PatientCheckUpState extends State<PatientCheckUp> {
  List<CartItem> cart = [];

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Patient Checkup"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  key: UniqueKey(),
                  itemCount: cart.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return CartWidget(
                        cart: cart, index: index, callback: refresh);
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cart.add(CartItem(
                        productType: "pizza",
                        itemName: "Pizza 1",
                        quantity: "Flavor 1"));
                    setState(() {});
                  },
                  child: Text("add Pizza"),
                ),
                ElevatedButton(
                  onPressed: () {
                    for (int i = 0; i < cart.length; i++) {
                      print(cart[i].itemName);
                      print(cart[i].quantity);
                    }
                  },
                  child: Text("Print Pizza"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
