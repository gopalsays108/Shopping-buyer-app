import 'package:flutter/material.dart';
import 'package:shopping_buyer_app/modules/widgets/view_product.dart';
import "./confirmOrder2.dart";

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.only(top: 10),
              // child: ViewProduct(),//You can try this widget first to confirm firebase integration
              child: ConfirmOrder())),
    );
  }
}
