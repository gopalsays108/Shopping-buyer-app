import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCubit extends Cubit<String> {
  AddressCubit(String initialState) : super(initialState);

  // late String address;

  void setAddress(String address) {
    emit(address);
  }
}
