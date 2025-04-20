import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/classes/database.dart';
import 'package:journal_app/pages/edit_entry.dart';
import 'colors.dart'; // Import the colors.dart file

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Database _database = Database([]);

  Future<List<Journal>> _loadJournals() async {
    List<Journal> _journals = await DatabaseFileRoutines().readJournals().then((journalList) {
      _database = DatabaseFileRoutines().databaseFromJson(journalList);
      return _database.journal;
    });
    return _journals;
  }

  Widget _buildListViewSeparated(AsyncSnapshot<List<Journal>> snapshot) {
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      return Center(child: Text('No journals found.', style: TextStyle(color: AppColors.textColor)));
    }

    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final journalEntry = snapshot.data![index];
        String _titleDate = DateFormat.yMMMEd().format(DateTime.parse(journalEntry.date));
        String _subtitle = journalEntry.mood + "\n" + journalEntry.note;
        return Dismissible(
          key: Key(journalEntry.id),
          direction: DismissDirection.horizontal,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm"),
                  content: Text("Are you sure you want to delete this journal entry?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Delete"),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) {
            setState(() {
              _database.journal.removeAt(index);
              DatabaseFileRoutines().writeJournals(DatabaseFileRoutines().dataToJson(_database));
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: Colors.black26, // Set background color of the Card
              elevation: 2.0,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                title: Text(
                  _titleDate,
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),
                ),
                subtitle: Text(_subtitle, style: TextStyle(color: AppColors.textColor)),
                onTap: () {
                  _addOrEditJournal(add: false, index: index, journal: journalEntry);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _addOrEditJournal({required bool add, int? index, required Journal journal}) async {
    JournalEdit _journalEdit = JournalEdit('Cancel', journal);
    _journalEdit = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEntry(add: add, index: index, journalEdit: _journalEdit),
        fullscreenDialog: true,
      ),
    );
    if (_journalEdit.action == 'Save') {
      setState(() {
        if (add) {
          _database.journal.add(_journalEdit.journal);
        } else if (index != null) {
          _database.journal[index] = _journalEdit.journal;
        }
        DatabaseFileRoutines().writeJournals(DatabaseFileRoutines().dataToJson(_database));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heartistry', style: TextStyle(color: AppColors.textColor)),
        backgroundColor: AppColors.appBarColor,
        iconTheme: IconThemeData(
          color: AppColors.textColor, // Change the arrow color here
        ),
      ),
      body: Container(
        color: AppColors.backgroundColor, // Set background color of the body
        child: FutureBuilder<List<Journal>>(
          future: _loadJournals(),
          builder: (BuildContext context, AsyncSnapshot<List<Journal>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: AppColors.textColor)));
            } else {
              return _buildListViewSeparated(snapshot);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.backgroundColor, // Set background color of the BottomAppBar
        shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: kBottomNavigationBarHeight, // Set the height to the default BottomAppBar height
          child: Padding(
            padding: EdgeInsets.zero, // Remove any padding if causing extra space
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Journal Entry',
        child: Icon(Icons.add),
        backgroundColor: AppColors.btnColor, // Set background color of the FloatingActionButton
        onPressed: () {
          _addOrEditJournal(add: true, index: null, journal: Journal('', '', '', ''));
        },
      ),
    );
  }
}
