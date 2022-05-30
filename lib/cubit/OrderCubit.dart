import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_buyer_app/cubit/AddressCubit.dart';
import 'package:shopping_buyer_app/modules/models/address.dart';
import 'package:shopping_buyer_app/modules/models/order.dart';

import '../modules/models/product.dart';

class OrderCubit extends Cubit<Order> {
  OrderCubit(Order myOrder) : super(myOrder);

  late double amount;

  void addData(Order order) {
    // const String address =
    //     "Near Rotary Public School Cartarpuri Alias, Huda, Sector 23A, Gurugram, Haryana 122017";
    List<Map<String, dynamic>> arr = [
      Product.takeProduct(
              id: "1Q44IuO6BAIcUheD7DCM",
              name: "IPhone1",
              desc: "description",
              price: 100,
              qty: 5,
              url:
                  "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-family-hero?wid=940&hei=1112&fmt=png-alpha&.v=1644969385433")
          .toJSON(),
      Product.takeProduct(
              id: "1gxgRmugdxxm9d8ow49a",
              name: "IPhone2",
              desc: "description",
              price: 100,
              qty: 5,
              url:
                  "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-family-hero?wid=940&hei=1112&fmt=png-alpha&.v=1644969385433")
          .toJSON(),
      Product.takeProduct(
              id: "a5kvSYHKQ4PlZQ7fU9lE",
              name: "IPhone2",
              desc: "description",
              price: 100,
              qty: 10,
              url:
                  "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-family-hero?wid=940&hei=1112&fmt=png-alpha&.v=1644969385433")
          .toJSON(),
    ];

    double amount = arr
        .map((prodcut) => prodcut['price'])
        .reduce((value, current) => value + current);

    // Order order = Order();
    order.user_id = "1";
    order.price = amount;
    // order.delivery_zone =
    this.amount = amount;
    order.products = arr;
    emit(order);
  }
}
