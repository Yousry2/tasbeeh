class Helper {
  static Future<bool> setValueAfterDelay(
      dynamic value1, dynamic value2, int delay) async {
    await Future.delayed(Duration(milliseconds: delay));

    value1 = value2;
    return value1;
  }
}
