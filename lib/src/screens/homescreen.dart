import 'package:flutter/material.dart';
import 'package:todos_application/src/screens/screens.dart';
import 'package:todos_application/src/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO-DO APPLICATION"),
      ),
      backgroundColor: Colors.white,
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        backgroundColor: Color(0xffe6e7ff),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            title: Text("All"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_email_unread),
            title: Text("Incomplete"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_email_read),
            title: Text("Complete"),
          )
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
      floatingActionButton:
          (this.selectedIndex != 2) ? FloatingActionButtonCustom() : null,
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return AllScreen();
    } else if (this.selectedIndex == 1) {
      return CompleteScreen();
    } else {
      return IncompleteScreen();
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}
