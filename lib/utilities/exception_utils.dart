
class ExceptionUtils {

  ExceptionUtils() {
    throwCanNotCreateObjectSingletonInstance();
  }

  static final instance = ExceptionUtils();

  void throwCanNotCreateObjectSingletonInstance() {
    Exception('Can not create object of singleton class');
  }
}
