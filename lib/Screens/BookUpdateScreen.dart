import 'package:bookstoreapp/Models/Book.dart';
import 'package:bookstoreapp/Services/BookRemoteServices.dart';
import 'package:flutter/material.dart';

class BookUpdateScreen extends StatefulWidget {
  final Book book;

  const BookUpdateScreen({super.key, required this.book});

  @override
  State<BookUpdateScreen> createState() => _BookUpdateScreenState();
}

class _BookUpdateScreenState extends State<BookUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _authorController;
  late TextEditingController _titleController;
  late TextEditingController _addedByController;
  late TextEditingController _descController;
  late TextEditingController _coverPageUrlController;
  late TextEditingController _yearController;
  late TextEditingController _genreController;
  late TextEditingController _languageController;
  late TextEditingController _pagesController;
  late TextEditingController _publisherController;
  late TextEditingController _ratingController;

  @override
  void initState() {
    super.initState();
    _authorController = TextEditingController(text: widget.book.author);
    _titleController = TextEditingController(text: widget.book.title);
    _descController = TextEditingController(text: widget.book.desc);
    _addedByController = TextEditingController(text: widget.book.addedBy);
    _coverPageUrlController = TextEditingController(
      text: widget.book.coverPageUrl,
    );
    _yearController = TextEditingController(text: widget.book.year.toString());
    _genreController = TextEditingController(text: widget.book.genre);
    _languageController = TextEditingController(text: widget.book.language);
    _pagesController = TextEditingController(
      text: widget.book.pages.toString(),
    );
    _publisherController = TextEditingController(text: widget.book.publisher);
    _ratingController = TextEditingController(
      text: widget.book.rating.toString(),
    );
  }

  @override
  void dispose() {
    _authorController.dispose();
    _titleController.dispose();
    _descController.dispose();
    _coverPageUrlController.dispose();
    _yearController.dispose();
    _genreController.dispose();
    _languageController.dispose();
    _pagesController.dispose();
    _publisherController.dispose();
    _ratingController.dispose();
    _addedByController.dispose();
    super.dispose();
  }

  void _updateBook() async {
    if (_formKey.currentState!.validate()) {
      final updatedBook = Book(
        id: widget.book.id,
        author: _authorController.text,
        addedBy: _addedByController.text,
        title: _titleController.text,
        desc: _descController.text,
        coverPageUrl: _coverPageUrlController.text,
        year: int.tryParse(_yearController.text) ?? 2025,
        genre: _genreController.text,
        language: _languageController.text,
        pages: int.tryParse(_pagesController.text) ?? 0,
        publisher: _publisherController.text,
        rating: double.tryParse(_ratingController.text) ?? 2.0,
      );

      bool isUpdated = await BookRemoteServices().updateBook(updatedBook);

      if (isUpdated) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Book Updated Successfully')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to Update Book')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Book")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
                validator: _required,
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: "Author"),
                validator: _required,
              ),
              TextFormField(
                controller: _addedByController,
                decoration: InputDecoration(labelText: "Added By"),
                validator: _required,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: "Description"),
                validator: _required,
              ),
              TextFormField(
                controller: _coverPageUrlController,
                decoration: InputDecoration(labelText: "Cover URL"),
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: "Year"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: "Genre"),
              ),
              TextFormField(
                controller: _languageController,
                decoration: InputDecoration(labelText: "Language"),
              ),
              TextFormField(
                controller: _pagesController,
                decoration: InputDecoration(labelText: "Pages"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _publisherController,
                decoration: InputDecoration(labelText: "Publisher"),
              ),
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: "Rating"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateBook,
                child: const Text("Update Book"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }
}
