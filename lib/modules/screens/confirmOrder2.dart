import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopping_buyer_app/cubit/OrderCubit.dart';
import 'package:shopping_buyer_app/modules/models/order.dart';
import 'package:shopping_buyer_app/modules/models/product_description.dart';
import 'package:shopping_buyer_app/modules/widgets/address_card.dart';
import 'package:shopping_buyer_app/modules/widgets/cart_card.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
String address = "";
String ZONE = "DELHI";
final String STATUS = "PENDING";
final String DELIVERY_BY = "GAURAV";
final String USER_EMAIL = "abc@gmail.com";
double PRICE = 0;
late Order order;

class ConfirmOrder extends StatefulWidget {
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  static const platform = const MethodChannel("razorpay_flutter");
  late Razorpay _razorpay;

  // Order order = Order();
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<OrderCubit, Order>(
          builder: (context, state) {
            address = state.delivery_address;
            ZONE = state.delivery_zone;
            PRICE = state.price;
            return Container(
              color: Colors.white54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    // padding: const EdgeInsets.all(40),
                    // margin: const EdgeInsets.all(20),
                    // decoration: BoxDecoration(
                    //     color: Colors.yellow,
                    //     shape: BoxShape.rectangle,
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: Colors.black, width: 2)),
                    child: AddressCard(
                      address: state.delivery_address,
                    ),
                    /*Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Address",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(state.delivery_address),

                      ],
                    ),
  */
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return CartCard(
                          url: state.products[index]['url'],
                          name: state.products[index]['name'],
                          desc: state.products[index]['desc'],
                          price: state.products[index]['price'].toString(),
                        )
                            /*ListTile(
                          leading: Image.network(state.products[index].url),
                          title: Text(state.products[index].name),
                          subtitle: Text(state.products[index].desc),
                          trailing: Text(
                            state.products[index].price.toString(),
                          ),
                        )
                        */
                            ;
                      },
                    ),
                  ),
                  Container(
                    child: Text("Total Amount: ${state.price}"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        order = state;
                        openCheckout();
                      },
                      child: Text('Confirm Order')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': orderCubit.amount * 100,
      'name': 'Acme Corp.',
      'description': 'Order',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    addOrderToFirebase();
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response.paymentId');
    Fluttertoast.showToast(
        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
        msg: "Payment was successfull");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');

    Fluttertoast.showToast(
        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
        msg: "Payment was not successfull");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
        msg: "Some error occured");
  }

  void addOrderToFirebase() {
    List<Map<String, dynamic>> map = [];

    for (int i = 0; i < order.products.length; i++) {
      map.add(ProductDescription(
        order.products[i]['product_id'].toString(),
        order.products[i]['qty'],
      ).toJSON());
    }

    Order arr = Order.takeOrder(map, USER_EMAIL, PRICE, STATUS, address, ZONE,
        DELIVERY_BY, DateTime.now());

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    try {
      Future<DocumentReference> fu =
          firebaseFirestore.collection("order").add(arr.toJSON());
      print(fu);
    } catch (e) {
      print(e);
    }
    subtractAmountFromDatabase(arr);
  }

  void subtractAmountFromDatabase(Order order) async {
    // order= order
    for (int i = 0; i < order.products.length; i++) {
      String id = order.products[i]['product_id'].toString();
      double num = order.products[i]['quantity'];
      print('num is $num');
      DocumentReference querySnapshot =
          await firebaseFirestore.collection("products").doc(id);

      querySnapshot.get().then(
        (DocumentSnapshot doc) {
          double valueToUpdate = double.parse(doc.get('qty').toString()) - num;
          updateQuantityToFirebase(valueToUpdate, id);
        },
      );
    }
  }

  void updateQuantityToFirebase(double valueToUpdate, String id) {
    firebaseFirestore
        .collection("products")
        .doc(id)
        .update({'qty': valueToUpdate}).then((_) {
      print("Updated");
    });
  }
}
