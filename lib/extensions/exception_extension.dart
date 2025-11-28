extension ExceptionExtension on Function {
  void executeSafely() {
    try {
      (this as Function).call();
    } catch (e) {
      print('Exception caught in executeSafely: $e');
    }
  }
}
