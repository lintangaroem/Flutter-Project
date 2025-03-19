import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:book_app/book.dart';

class DetailPage extends StatelessWidget {
  final Book book;
  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        children: [
          // Gambar dengan efek blur
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    book.image,
                    width: 130,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 130, color: Colors.grey);
                    },
                  ),
                ),
              ),
            ),
          ),

          // Judul Buku
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                book.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Info Buku
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bookInfo(book.rate.toString(), "Rating"),
              bookInfo(book.page.toString(), "Page"),
              bookInfo(book.language, "Language"),
            ],
          ),

          // Deskripsi
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: bookDesc(book.description),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan informasi buku
  Widget bookInfo(String value, String info) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          info,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ],
    );
  }

  // Widget untuk menampilkan deskripsi buku dengan rapi
  Widget bookDesc(String desc) {
    return Text(
      desc,
      textAlign: TextAlign.justify,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }
}
