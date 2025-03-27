import 'package:flutter/material.dart';

class VaccineDetailPage extends StatelessWidget {
  final String vaccineName;
  final String vaccineCode;
  final String dateGiven;
  final String placeGiven;
  final String recipient;
  final String nik;
  final String birthDate;

  const VaccineDetailPage({
    required this.vaccineName,
    required this.vaccineCode,
    required this.dateGiven,
    required this.placeGiven,
    required this.recipient,
    required this.nik,
    required this.birthDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$vaccineName Vaksin Dosis Pertama'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: ListTile(
                title: Text("Jenis Vaksinasi"),
                subtitle: Text("COVID-19 Vaksin Dosis Pertama", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 16),

            Card(
              color: Colors.pink.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.vaccines, color: Colors.red, size: 24),
                        SizedBox(width: 8),
                        Text("COVID-19\nVaksin Dosis Pertama",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Icon(Icons.qr_code, size: 32),
                      ],
                    ),
                    SizedBox(height: 8),

                    Text(vaccineName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(vaccineCode, style: TextStyle(color: Colors.grey)),

                    Divider(),

                    _buildInfoRow("Tanggal Pemberian", dateGiven),
                    _buildInfoRow("Tempat Pemberian", placeGiven),
                    _buildInfoRow("Diberikan kepada", recipient),
                    _buildInfoRow("NIK", nik),
                    _buildInfoRow("Tanggal Lahir", birthDate),

                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset("assets/images/kemenkes.png", width: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 310),

            ElevatedButton.icon(
              icon: Icon(Icons.download, color: Colors.white),
              label: Text(
                  "Unduh Sertifikat",
                  style: TextStyle(color: Colors.white)
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
