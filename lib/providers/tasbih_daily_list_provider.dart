import 'package:flutter/material.dart';
import '../models/tasbih.dart';

class TasbihDailyListProvider with ChangeNotifier {
  TasbihDailyListProvider() {
    if (_choosenTasbih == null) {
      _choosenTasbih = getFirstElementInTasbihList();
      notifyListeners();
    }
    // if (_choosenTasbihId == 0) {
    //   _choosenTasbihId = getFirstElementInTasbihList()?.id;
    //   notifyListeners();
    // }
  }
  Tasbih getTasbihById(int id) {
    if (id == null || id == 0) {
      return getFirstElementInTasbihList();
    }
    Tasbih tas = _userTasbihList.firstWhere((element) => element.id == id);
    return tas != null ? tas : getFirstElementInTasbihList();
  }

  getFirstElementInTasbihList() {
    return _userTasbihList.length > 0 ? _userTasbihList[0] : Tasbih.empty();
  }

  removeTasbih(Tasbih deletedTasbih) {
    _userTasbihList.removeWhere((r) => deletedTasbih.id == r.id);
    notifyListeners();
    return true;
  }

  reorder(int n, int m) {
    Tasbih tmp = _userTasbihList[n];
    _userTasbihList.removeAt(n);
    if (n < m) {
      _userTasbihList.insert(m - 1, tmp);
      tmp.tOrder = m - 1;
    } else {
      _userTasbihList.insert(m, tmp);
    }
    correctTasbihListOrder();
    notifyListeners();
  }

  correctTasbihListOrder() {
    _userTasbihList.asMap().forEach((i, element) {
      element.tOrder = i;
    });
  }

  List<Tasbih> get userTasbihList {
    return _userTasbihList;
  }

  get choosenTasbihId {
    return _choosenTasbihId;
  }

  Tasbih get choosenTasbih {
    return _choosenTasbih;
  }

  get countingStarted {
    return _countingStarted;
  }

  void selectTasbih(Tasbih tasbih) {
    _choosenTasbih = tasbih;
    _choosenTasbihId = _choosenTasbih.id;
    notifyListeners();
  }

  void setCountingSpeed(int countingSpeed) {
    _choosenTasbih.countingSpeed = countingSpeed;
    notifyListeners();
  }

  startCounting() {
    _countingStarted = true;
    notifyListeners();
  }

  stopCounting() {
    _countingStarted = false;
    notifyListeners();
  }

  void resetCurrentTasbih() {
    stopCounting();
    if (_choosenTasbih.numberOfLastCountValue ==
        _choosenTasbih.numberOfTasbihPerGroup) {
      _choosenTasbih.numberOfGroupsDoneToday--;
    }

    _choosenTasbih.numberOfLastCountValue = 0;
    notifyListeners();
  }

  void newTasbihGroup() {
    stopCounting();
    _choosenTasbih.numberOfLastCountValue = 0;
    notifyListeners();
  }

  bool isLastElement() {
    return _userTasbihList.last.id == _choosenTasbih.id;
  }

  bool isFirstElement() {
    return _userTasbihList.first.id == _choosenTasbih.id;
  }

  void increaseTasbihDoneToday() {
    _choosenTasbih.numberOfGroupsDoneToday++;
  }

  goToNextTasbih() {
    if (!isLastElement()) {
      stopCounting();
      _choosenTasbih = _userTasbihList.elementAt(_userTasbihList
              .indexWhere((element) => element.id == _choosenTasbihId) +
          1);
      _choosenTasbihId = _choosenTasbih.id;
    }
    notifyListeners();
  }

  goToPreviousTasbih() {
    if (!isFirstElement()) {
      stopCounting();
      _choosenTasbih = _userTasbihList.elementAt(_userTasbihList
              .indexWhere((element) => element.id == _choosenTasbihId) -
          1);
      _choosenTasbihId = _choosenTasbih.id;
    }
    notifyListeners();
  }

  setCountSpeed(int speed) {}

  increaseCurrentTasbihCount() {
    _choosenTasbih.numberOfLastCountValue++;
    notifyListeners();
  }

  void swap(int index1, int index2) {
    var length = _userTasbihList.length;
    RangeError.checkValidIndex(index1, this, "index1", length);
    RangeError.checkValidIndex(index2, this, "index2", length);
    if (index1 != index2) {
      var tmp1 = _userTasbihList[index1];
      _userTasbihList[index1] = _userTasbihList[index2];
      _userTasbihList[index2] = tmp1;
    }
    notifyListeners();
  }

  bool addTasbih(Tasbih tasbih) {
    tasbih.id = new DateTime.now().millisecondsSinceEpoch;
    int index = _userTasbihList.length;
    tasbih.tOrder = index;
    _userTasbihList.add(tasbih);
    notifyListeners();
    return true;
  }

  updateTasbihList(List<Tasbih> tasbihList) {
    _userTasbihList = tasbihList;
    Tasbih tempTasbih;
    if (tasbihList != null) {
      tempTasbih = tasbihList.firstWhere((element) {
        return element.id == _choosenTasbih.id;
      }, orElse: () => getFirstElementInTasbihList());
      if (tempTasbih == null)
        getFirstElementInTasbihList();
      else
        _choosenTasbih = tempTasbih;
    }
    notifyListeners();
  }

  bool updateTasbih(Tasbih tasbih) {
    //tasbih.id = new DateTime.now().millisecondsSinceEpoch;
    Tasbih foundTasbih =
        _userTasbihList.firstWhere((element) => element.id == tasbih.id);
    if (foundTasbih != null) {
      foundTasbih.name = tasbih.name;
      foundTasbih.numberOfDailyGroups = tasbih.numberOfDailyGroups;
      foundTasbih.numberOfTasbihPerGroup = tasbih.numberOfTasbihPerGroup;
      if (foundTasbih.numberOfLastCountValue >
          foundTasbih.numberOfTasbihPerGroup) {
        foundTasbih.numberOfLastCountValue = foundTasbih.numberOfTasbihPerGroup;
      }
    }
    notifyListeners();
    return true;
  }

  int _choosenTasbihId = 0;
  Tasbih _choosenTasbih;
  var _countingStarted = false;
  List<Tasbih> _userTasbihList = [];
}
