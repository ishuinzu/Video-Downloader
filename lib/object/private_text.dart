import 'package:video_downloader/database/database_helper.dart';

class PrivateText {
  late int id;
  late String subject;
  late String description;
  late String category;

  PrivateText();

  PrivateText.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    subject = map[subjectPrivateTextColumn];
    description = map[descriptionPrivateTextColumn];
    category = map[categoryPrivateTextColumn];
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      subjectPrivateTextColumn: subject,
      descriptionPrivateTextColumn: description,
      categoryPrivateTextColumn: category,
    };

    if (id != 9999999999) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Data(id: $id, subject: $subject, description: $description, category: $category)";
  }
}
