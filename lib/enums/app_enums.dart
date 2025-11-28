

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
