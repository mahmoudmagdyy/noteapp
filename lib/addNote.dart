import 'package:flutter/material.dart';
import 'package:use_sqflite/homePage.dart';
import 'package:use_sqflite/sqldb.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Note"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),

                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.title_outlined),
                      hintText: 'title',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.note),
                      hintText: 'note',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.color_lens_outlined),
                      hintText: 'color',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      // int response = await sqlDb.insertData('''
                      //
                      //
                      // INSERT INTO notes (note , title , color )
                      // VALUES ("${note.text}" , "${title.text}" , "${color.text}")
                      //
                      //
                      // ''');
                      int response =await sqlDb.insert("notes", {
                        "note" : "${note.text}",
                        "title" : "${title.text}" ,
                        "color" : "${color.text}" ,
                      });
                      print("response==================");
                      print(response);
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),(route) => false);
                      }
                    },
                    color: Colors.deepOrangeAccent,
                    child: const Text("Add note"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
