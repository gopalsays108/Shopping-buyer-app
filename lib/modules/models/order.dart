

class Order {
  late List<Map<String, dynamic>> products;
  late double price;
  late String user_id;
  late String order_status;
  late String delivery_address;
  late String delivery_zone;
  late String delivered_by;
  late DateTime date;

  // Order();
  Order();

  Order.takeOrder(
      this.products,
      this.user_id,
      this.price,
      this.order_status,
      this.delivery_address,
      this.delivery_zone,
      this.delivered_by,
      this.date);

  Map<String, dynamic> toJSON() {
    return {
      "products": products,
      "user_id": user_id,
      "price": price,
      "order_status": order_status,
      "delivery_address": delivery_address,
      "delivery_zone": delivery_zone,
      "date": date,
    };
  }

  @override
  String toString() {
    return 'Order{product: $products, user_emailid: $user_id, price: $price, order_status: $order_status, delivery_address: $delivery_address, delivery_zone: $delivery_zone, delivered_by: $delivered_by, date: $date}';
  }
}
