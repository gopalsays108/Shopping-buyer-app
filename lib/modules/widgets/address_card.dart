import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  // const AddressCard({Key? key}) : super(key: key);
  String address;
  AddressCard({required this.address});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              // gradient: widget.isGradient ? bgColor[randomColor] : null,
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            height: size.height / 5,
            width: size.width - 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: (size.height / 5) / 3,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Address",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.5 * (size.height / 5) / 3,
                  width: size.width - 50 * 2,
                  child: Text(
                    address,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
        //
      ],
    );
  }
}
