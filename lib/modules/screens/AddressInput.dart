// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../cubit/OrderCubit.dart';

// class MyAddress extends StatelessWidget {
//   const MyAddress({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);
//     return Container(
//       child: ElevatedButton(
//           child: Text("Press it"),
//           onPressed: () {
//             orderCubit.addData();
//             Navigator.pushNamed(context, "/dashboard");
//           }),
//     );
//   }
// }
