import 'package:flutter/material.dart';
import 'package:use_sqflite/editNotes.dart';
import 'package:use_sqflite/sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;

  List notes = [];

  Future readDta() async {
    List<Map> response = await sqlDb.read("notes");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    readDta();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  /*MaterialButton(
                    onPressed: () async {
                      await sqlDb.deleteDataBase();
                    },
                    child: Text("delete dataBase"),
                  ),*/
                  ListView.builder(
                    itemCount: notes.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          title: Text("${notes[i]['title']}"),
                          subtitle: Text("${notes[i]['note']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit_note_outlined),
                                color: Colors.teal,
                                onPressed: () {
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditeNote(
                                       color: notes[i]['color'],
                                       title: notes[i]['title'],
                                       note: notes[i]['note'],
                                       id: notes[i]['id'],
                                     )));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () async {
                                  // var response = await sqlDb.deleteData(
                                  //     "DELETE FROM notes WHERE id = ${notes![i]['id']}");
                                  int response = await sqlDb.delete("notes", "id = ${notes![i]['id']}");
                                  if (response > 0) {
                                    notes.removeWhere((element) =>
                                    element['id'] == notes![i]['id']);
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}
