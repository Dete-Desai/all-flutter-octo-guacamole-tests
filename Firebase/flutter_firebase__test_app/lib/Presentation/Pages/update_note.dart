import 'package:flutter/material.dart';
import 'package:flutter_firebase__test_app/data/firestore_service.dart';
import 'package:flutter_firebase__test_app/data/model/note.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;

  UpdateNotePage({Key? key, required this.note}) : super(key: key);
  @override
  _UpdateNotePageState createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: isEditMote ? widget.note.title : '');
    _descriptionController =
        TextEditingController(text: isEditMote ? widget.note.description : '');
    _descriptionNode = FocusNode();
  }

  get isEditMote => widget.note != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Edit Note' : 'Add Note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(isEditMote ? "Update" : "Save"),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    try {
                      if (isEditMote) {
                        Note note = Note(
                          description: _descriptionController.text,
                          title: _titleController.text,
                          id: widget.note.id,
                        );
                        await FirestoreService().updateNote(note);
                      } else {
                        Note note = Note(
                          description: _descriptionController.text,
                          title: _titleController.text, id: '',
                        );
                        await FirestoreService().updateNote(note);
                      }
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
