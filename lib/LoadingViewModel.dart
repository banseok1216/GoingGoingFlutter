import 'package:flutter/cupertino.dart';

class LoadingViewModel with ChangeNotifier{
  bool _loading = false;
  bool get isLoading => _loading;
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}