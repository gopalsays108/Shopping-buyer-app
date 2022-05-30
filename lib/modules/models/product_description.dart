class ProductDescription{
  late String product_id;
  late double quantity;

  ProductDescription(this.product_id, this.quantity);

  Map<String, dynamic> toJSON() {
    return { "product_id": product_id,
      "quantity": quantity,
    };
  }
}