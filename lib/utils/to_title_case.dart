import 'package:collection/collection.dart';

extension ToTitleCase on String {
  static const List<String> lowercaseWords = [
    "a",
    "an",
    "the",
    "and",
    "but",
    "or",
    "for",
    "nor",
    "on",
    "at",
    "to",
    "by",
    "of",
    "in",
    "with",
    "your",
  ];

  String toTitleCase() {
    return toLowerCase().split(RegExp(r'\s+|-|_+')).mapIndexed((index, word) {
      final firstLetter = word[0].toUpperCase();
      final rest = word.substring(1);

      return (index != 0 && lowercaseWords.contains(word))
          ? word
          : '$firstLetter$rest';
    }).join(" ");
  }
}
