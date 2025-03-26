import 'package:flutter/material.dart';
import 'package:layout_project/home.dart';
import 'package:layout_project/profile.dart';
import 'package:layout_project/sertifikat_vaksin.dart';

class FiturPage extends StatelessWidget {
  const FiturPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Fitur",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Cari Fitur",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.black45),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // List Fitur
            Expanded(
              child: ListView(
                children: [
                  FeatureCategory(
                    title: "Vaksin dan Imunisasi",
                    features: [
                      FeatureItem(
                        icon: "assets/icons/vaccine.jpeg",
                        label: "Sertifikat\nVaksin",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SertifikatVaksinPage()),
                          );
                        },
                      ),
                      FeatureItem(
                        icon: "assets/icons/registration_vaccine.jpeg",
                        label: "Daftar\nVaksin",
                      ),
                    ],
                  ),
                  FeatureCategory(
                    title: "COVID-19",
                    features: [
                      FeatureItem(
                        icon: "assets/icons/vaccine_covid.jpeg",
                        label: "Sertifikat\nVaksin",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SertifikatVaksinPage()),
                          );
                        },
                      ),
                      FeatureItem(
                        icon: "assets/icons/test_covid.jpeg",
                        label: "Hasil Tes\nCOVID-19",
                      ),
                      FeatureItem(
                        icon: "assets/icons/registration_covid.jpeg",
                        label: "Daftar Vaksin\nCOVID-19",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Fitur",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

class FeatureCategory extends StatelessWidget {
  final String title;
  final List<FeatureItem> features;

  const FeatureCategory({required this.title, required this.features, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: feature,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// Widget untuk Setiap Fitur
class FeatureItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback? onTap;

  const FeatureItem({required this.icon, required this.label, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(icon, width: 50, height: 50),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
