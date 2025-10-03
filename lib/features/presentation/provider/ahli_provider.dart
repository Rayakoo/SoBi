import 'package:flutter/material.dart';
import '../../domain/entities/ahli_entity.dart';
import '../../domain/usecases/chat-ahli/get_ahli.dart';

class AhliProvider extends ChangeNotifier {
  final GetAhli getAhliUsecase;

  List<AhliEntity> ahliList = [];
  bool isLoading = false;
  String? error;

  AhliProvider({required this.getAhliUsecase});

  Future<void> fetchAhli() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      ahliList = await getAhliUsecase();
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
