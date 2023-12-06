import 'package:flutter/material.dart';
import 'package:use_sqflite/homePage.dart';
import 'package:use_sqflite/sqldb.dart';

class EditeNote extends StatefulWidget {

  final note;
  final title;
  final color;
  final id;

  const EditeNote({super.key, this.note, this.title, this.id, this.color});

  @override
  State<EditeNote> createState() => _EditeNoteState();
}

class _EditeNoteState extends State<EditeNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edite Note"),
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
                      // int response = await sqlDb.updateData('''
                      //     UPDATE notes SET
                      //      note = "${note.text}" ,
                      //      title = "${title.text}" ,
                      //      color = "${color.text} " 
                      //      WHERE id = ${widget.id}                                           
                      // ''');

                      int response = await sqlDb.update("notes", {
                        "note": "${note.text}",
                        "title": "${title.text}",
                        "color": "${color.text} "
                      },"id = ${widget.id}"  );
                      print("response==================");
                      print(response);
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) =>
                                HomePage()), (route) => false);
                      }
                    },
                    color: Colors.deepOrangeAccent,
                    child: const Text("Update note"),
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
