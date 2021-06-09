import 'package:flutter/material.dart';
import 'package:flutter_firebase__test_app/data/model/note.dart';
import 'package:flutter_firebase__test_app/data/firestore_service.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
    _descriptionController = TextEditingController(text: '');
    _descriptionNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_descriptionNode);
                  },
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Title cannot be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  focusNode: _descriptionNode,
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      onPressed: () async{
                        try {
                          await FirestoreService().addNote(
                          Note(title: _titleController.text, 
                          description: _descriptionController.text, id: '',
                          ),
                        );
                        Navigator.pop(context);
                        }catch(e) {
                          print(e);
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
