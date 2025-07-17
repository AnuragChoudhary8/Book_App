import 'package:bookstoreapp/Models/Book.dart';
import 'package:bookstoreapp/Screens/BookUpdateScreen.dart';
import 'package:bookstoreapp/Services/BookRemoteServices.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {
  final int bookId;

  BookDetailScreen({super.key, required this.bookId});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  Book? book;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    getBookById(widget.bookId);
  }

  getBookById(int id) async {
    book = await BookRemoteServices().getBookById(id);
    if (book != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookUpdateScreen(book: book!),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: Text(isLoaded ? book!.title : 'loading'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              deleteBook();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Visibility(
        visible: isLoaded,
        child: ShowBook(),
        replacement: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  deleteBook() async {
    bool isDeleted = await BookRemoteServices().deleteBook(widget.bookId);
    if (isDeleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Book deleted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delet book!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget ShowBook() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Cover Image with Hero and shadow
          Hero(
            tag: book!.id ?? book!.title,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  book!.coverPageUrl,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Card with Details
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Author
                Text(
                  book!.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "by ${book!.author}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const Divider(height: 30),

                // Description
                const Text(
                  "📖 Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(book!.desc),

                const SizedBox(height: 20),

                // Info section
                const Text(
                  "📌 Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _detail("Genre", book!.genre),
                _detail("Language", book!.language),
                _detail("Year", book!.year.toString()),
                _detail("Pages", book!.pages.toString()),
                _detail("Publisher", book!.publisher),
                _detail("Added By", book!.addedBy),
                _detail("⭐ Rating", book!.rating.toStringAsFixed(1)),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
