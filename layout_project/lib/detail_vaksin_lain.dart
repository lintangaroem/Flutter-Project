import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:layout_project/vaccine.dart';

class DetailVaksinLainPage extends StatefulWidget {
  const DetailVaksinLainPage({Key? key}) : super(key: key);

  @override
  _DetailVaksinLainPageState createState() => _DetailVaksinLainPageState();
}

class _DetailVaksinLainPageState extends State<DetailVaksinLainPage> {
  bool isCovidSelected = true; // Default tab: COVID-19

  final List<Map<String, String>> covidVaccines = [
    {
      "date": "04 April 2023",
      "place": "RS ISLAM MALANG UNISMA",
      "dose": "Booster Pertama",
    },
    {
      "date": "09 September 2021",
      "place": "KLINIK RAWAT JALAN RAMPAL",
      "dose": "Dosis Kedua",
    },
    {
      "date": "07 Agustus 2021",
      "place": "KLINIK PRATAMA DR IDRIS P SIREGAR 2",
      "dose": "Dosis Pertama",
    },
  ];

  final List<Map<String, String>> nonCovidVaccines = [
    {
      "date": "12 Juli 2020",
      "place": "PUSKESMAS SUMBERSARI",
      "dose": "Hepatitis B",
    },
    {
      "date": "05 Mei 2018",
      "place": "RUMAH SAKIT BHAYANGKARA",
      "dose": "MMR (Campak, Gondongan, Rubella)",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedVaccines =
    isCovidSelected ? covidVaccines : nonCovidVaccines;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vaksin & Imunisasi Lainnya",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButton(
                  title: "COVID-19",
                  isSelected: isCovidSelected,
                  onTap: () {
                    setState(() {
                      isCovidSelected = true;
                    });
                  },
                ),
                SizedBox(width: 12),
                ToggleButton(
                  title: "Non COVID-19",
                  isSelected: !isCovidSelected,
                  onTap: () {
                    setState(() {
                      isCovidSelected = false;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: displayedVaccines.length,
              itemBuilder: (context, index) {
                return VaccineCard(
                  date: displayedVaccines[index]["date"]!,
                  place: displayedVaccines[index]["place"]!,
                  dose: displayedVaccines[index]["dose"]!,
                  isLastItem: index == displayedVaccines.length - 1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VaccineDetailPage(
                          vaccineName: "COVID-19",
                          vaccineCode: displayedVaccines[index]["dose"]!,
                          dateGiven: displayedVaccines[index]["date"]!,
                          placeGiven: displayedVaccines[index]["place"]!,
                          recipient: "LINTANG ARUM SARI",
                          nik: "3573055607404003",
                          birthDate: "16 Juli 2004",
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

// WIDGET TOGGLE BUTTON
class ToggleButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ToggleButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class VaccineCard extends StatelessWidget {
  final String date;
  final String place;
  final String dose;
  final bool isLastItem;
  final VoidCallback onTap;

  const VaccineCard({
    required this.date,
    required this.place,
    required this.dose,
    required this.isLastItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 36, bottom: 4),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.tealAccent.shade400,
                ),
                if (!isLastItem)
                  Dash(
                    direction: Axis.vertical,
                    length: 130,
                    dashLength: 10,
                    dashThickness: 2,
                    dashColor: Colors.grey.shade300,
                  ),
              ],
            ),
            SizedBox(width: 12),

            Expanded(
              child: GestureDetector(
              onTap: onTap,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                elevation: 3,
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                        Text(
                          "COVID-19",
                          style: TextStyle(
                            color: Colors.red.shade900,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 18, color: Colors.blue),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              place,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),

                      Row(
                        children: [
                          Image.asset("assets/icons/suntik.jpeg", width: 40),
                          SizedBox(width: 6),
                          Text(
                            dose,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              ),
            ),
          ],
        ),
      ],
    );
  }
}
