class AppEnums {}

enum BottomSheetEventOptionsUI { poppins, listTile }

enum Language {
  English(languageCode: 'en', languageName: 'English'),
  Hindi(languageCode: 'hi', languageName: 'Hindi'),
  Kannada(languageCode: 'kn', languageName: 'Kannada');

  const Language({required this.languageCode, required this.languageName});

  final String languageCode;
  final String languageName;
}

enum TodoScreenType { created, joined }

enum ProviderState { initial, loading, success, failure, empty }

enum LoginState { initial, loading, success, failure, codeSent, timeout }

enum OtpVerificationState { initial, loading, success, failure }
