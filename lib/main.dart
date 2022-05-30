import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_buyer_app/cubit/OrderCubit.dart';
import 'package:shopping_buyer_app/modules/models/order.dart';
import 'package:shopping_buyer_app/modules/screens/dashboard.dart';
import 'package:shopping_buyer_app/modules/screens/dropdown.dart';

import 'cubit/AddressCubit.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    child: MaterialApp(
      title: "Buyer App",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => dropdown(),
        "/dashboard": (context) => Dashboard(),
      }, //once initial route defined no need to mention home
      // initialRoute: RouteConstants.DASHBOARD, //inital or base route
      // routes: getRoutes(), //all routes are loaded here
    ),
    providers: [
      BlocProvider(create: (context) => OrderCubit(Order())),
      BlocProvider(create: (context) => AddressCubit("")),
    ],
  ));
}
