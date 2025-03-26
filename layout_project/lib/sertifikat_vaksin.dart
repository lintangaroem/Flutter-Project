import 'package:flutter/material.dart';

class SertifikatVaksinPage extends StatelessWidget{
  const SertifikatVaksinPage({Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Sertifikat Vaksin & Imunisasi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            VaksinCard(
              title: "Vaksin & Imunisasi Rutin",
              description: "Imunisasi bayi, BADUTA, BIAS, WUS",
              imagePath: "assets/icons/vaccine.jpeg",
            ),
            SizedBox(height: 10),
            VaksinCard(
              title: "Vaksin & Imunisasi Lainnya",
              description: "Covid-19, Meningitis, dll",
              imagePath: "assets/icons/vaccine.jpeg",
            ),
            SizedBox(height: 10),
            VaksinCard(
              title: "Sertifikat Perjalanan Luar Negeri",
              description: "Ubah sertifikat Anda menjadi format WHO atau EU.",
              imagePath: "assets/icons/vaccine.jpeg",
            ),
          ],
        ),
      ),
    );
  }
}

class VaksinCard extends StatelessWidget{
  final String title;
  final String description;
  final String imagePath;

  const VaksinCard({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius:8,
              offset: Offset(0, 2)
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
      ),
    );
  }
}