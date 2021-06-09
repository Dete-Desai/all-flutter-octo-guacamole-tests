class Note {
  late final String title;
  late final String description;
  late final String id;

  Note({
    required this.title, 
    required this.description, 
    required this.id
    });

  Note.fromMap(Map<String,dynamic> data, String id):
    title=data["title"],
    description=data["description"],
    id=id;

  Map<String, dynamic> toMap() {
    return {
      "title" : title,
      "description": description,
    };
  }
}
