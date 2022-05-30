class Address {
  late String zone;
  late String State;
  late String city;
  late String street;
  late String houseNumber;

  Address() {}
// [String zone, String state, String city, String street, String houseNumber]
  Address.takeAddress({
    required this.zone,
    required this.State,
    required this.city,
    required this.street,
    required this.houseNumber,
  });
}
