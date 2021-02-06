class Utils {
  static Future<bool> loadingFuture() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return true;
    });
  }
}
