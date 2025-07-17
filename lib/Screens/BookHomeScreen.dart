import 'package:bookstoreapp/Models/Book.dart';
import 'package:bookstoreapp/Screens/BookAddScreen.dart';
import 'package:bookstoreapp/Services/BookRemoteServices.dart';
import 'package:bookstoreapp/Widgets/BookItemCard.dart';
import 'package:flutter/material.dart';

class BookHomeScreen extends StatefulWidget {
  const BookHomeScreen({super.key});

  @override
  State<BookHomeScreen> createState() => _BookHomeScreenState();
}

class _BookHomeScreenState extends State<BookHomeScreen> {
  List<Book> allBooks = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    allBooks = (await BookRemoteServices().getAllBooks())!;
    if (allBooks.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BOOK STORE')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => BookAddScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: allBooks.length,
          itemBuilder: (context, index) => BookItemCard(book: allBooks[index]),
        ),
      ),
    );
  }
}
