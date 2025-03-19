import 'package:book_app/book.dart';
import 'package:flutter/material.dart';

class Book{
  String name;
  String image;
  String description;
  double rate;
  int page;
  String categoryBook;
  String language;

  Book({
    required this.name,
    required this.image,
    required this.description,
    required this.rate,
    required this.page,
    required this.categoryBook,
    required this.language,
  });
}

List<Book> listBook = [
  Book(
    name: 'The Alpha Girls Guide',
    image: 'images/buku_alpha.png',
    description:
      'Alpha Girls Guide adalah buku karya Hanny Kusumawati yang membahas panduan bagi perempuan untuk menjadi versi terbaik dari diri mereka sendiri. Dengan gaya santai namun tajam, buku ini memberikan wawasan tentang kemandirian, percaya diri, dan cara menghadapi berbagai tantangan dalam kehidupan, karier, serta hubungan sosial. Ditulis dengan pendekatan yang relevan dan inspiratif, Alpha Girls Guide cocok untuk perempuan yang ingin lebih berani, cerdas, dan tangguh dalam menjalani hidup.',
    rate: 4.3,
    page: 216,
    categoryBook: 'Self Development',
    language: 'IDN'
  ),
  Book(
      name: 'Atomic Habits',
      image: 'images/buku_atomic.png',
      description:
      'Atomic Habits adalah buku karya James Clear yang membahas bagaimana kebiasaan kecil dapat membawa perubahan besar dalam hidup. Dengan pendekatan berbasis sains, buku ini menjelaskan cara membangun kebiasaan baik, menghilangkan kebiasaan buruk, dan menciptakan sistem yang mendukung pertumbuhan diri secara konsisten. Clear menggunakan konsep 1% improvement—perbaikan kecil yang dilakukan setiap hari dapat menghasilkan hasil luar biasa dalam jangka panjang. **Atomic Habits** cocok bagi siapa saja yang ingin meningkatkan produktivitas, disiplin, dan kualitas hidup melalui perubahan bertahap namun efektif.',
      rate: 4.4,
      page: 320,
      categoryBook: 'Self Development',
      language: 'IDN'
  ),
  Book(
      name: 'Berani Tidak Disukai',
      image: 'images/buku_berani.png',
      description:
      'Berani Tidak Disukai (The Courage to Be Disliked) adalah buku karya Ichiro Kishimi dan Fumitake Koga yang mengupas filosofi Alfred Adler tentang kebebasan, kebahagiaan, dan makna kehidupan. Buku ini disajikan dalam bentuk dialog antara seorang filsuf dan seorang pemuda yang mempertanyakan hidupnya. Melalui percakapan ini, pembaca diajak memahami bahwa kebahagiaan sejati didapat dengan melepaskan diri dari ekspektasi orang lain dan berani menjalani hidup sesuai dengan nilai-nilai sendiri. Buku ini cocok bagi mereka yang ingin lebih percaya diri, mandiri, dan hidup tanpa beban opini orang lain.',
      rate: 4.3,
      page: 288,
      categoryBook: 'Self Development',
      language: 'IDN'
  ),
  Book(
      name: 'Bicara Itu Ada Seninya',
      image: 'images/buku_bicara.png',
      description:
      'Bicara Itu Ada Seninya adalah buku karya Oh Su Hyang yang membahas keterampilan komunikasi efektif dalam berbagai situasi. Buku ini memberikan tips dan strategi untuk berbicara dengan percaya diri, menarik perhatian lawan bicara, serta menyampaikan pendapat dengan jelas dan persuasif. Dengan gaya bahasa yang ringan dan mudah dipahami, buku ini cocok bagi siapa saja yang ingin meningkatkan kemampuan berbicara, baik dalam kehidupan pribadi maupun profesional.',
      rate: 4.2,
      page: 276,
      categoryBook: 'Self Development',
      language: 'IDN'
  ),
  Book(
      name: 'Filosofi Teras',
      image: 'images/buku_filosofi.png',
      description:
      'Filosofi Teras adalah buku karya Henry Manampiring yang memperkenalkan filsafat Stoisisme dalam kehidupan modern. Buku ini menjelaskan bagaimana ajaran para filsuf Stoik seperti Marcus Aurelius, Epictetus, dan Seneca dapat membantu kita menghadapi berbagai tantangan hidup dengan lebih tenang, rasional, dan bijaksana. Dengan gaya bahasa yang santai dan relatable, Filosofi Teras mengajarkan cara mengendalikan emosi, menerima hal-hal yang di luar kendali, serta fokus pada tindakan yang bisa kita lakukan. Cocok bagi siapa saja yang ingin menjalani hidup dengan lebih tenang, kuat, dan penuh makna.',
      rate: 4.5,
      page: 346,
      categoryBook: 'Self Development',
      language: 'IDN'
  ),
  Book(
      name: 'Hujan',
      image: 'images/buku_hujan.png',
      description:
      'Hujan adalah novel karya Tere Liye yang mengangkat tema cinta, kehilangan, dan ketabahan dalam latar dunia yang mengalami bencana besar. Cerita ini mengikuti perjalanan Lail, seorang gadis yang harus menghadapi kehilangan dan trauma setelah bencana dahsyat melanda. Dengan nuansa futuristik dan emosional, novel ini menggambarkan bagaimana manusia bertahan, merelakan masa lalu, dan menemukan makna baru dalam hidup. Hujan menawarkan kisah yang menyentuh hati dengan gaya khas Tere Liye yang penuh refleksi dan makna mendalam.',
      rate: 4.3,
      page: 320,
      categoryBook: 'Fiksi',
      language: 'IDN'
  ),
  Book(
      name: 'Janji',
      image: 'images/buku_janji.png',
      description:
      'Janji adalah novel karya Tere Liye yang mengisahkan perjalanan hidup seorang pengacara bernama Genta, yang harus menghadapi dilema besar dalam karier dan kehidupannya. Novel ini menyajikan intrik hukum, moralitas, dan makna janji yang harus ditepati, bahkan ketika menghadapi situasi sulit. Dengan gaya penceritaan yang khas dan penuh emosi, Janji mengajak pembaca untuk merenungkan tentang kejujuran, pengorbanan, dan nilai-nilai kehidupan yang mendalam.',
      rate: 4.4,
      page: 400,
      categoryBook: 'Fiksi',
      language: 'IDN'
  ),
  Book(
      name: 'Laut Bercerita',
      image: 'images/buku_laut.png',
      description:
      'Laut Bercerita adalah novel karya Leila S. Chudori yang mengangkat kisah tentang aktivisme, penculikan, dan perjuangan mencari keadilan di era Orde Baru. Buku ini mengikuti perjalanan Biru Laut, seorang mahasiswa aktivis yang berjuang melawan ketidakadilan, namun harus menghadapi penyiksaan dan penghilangan paksa oleh rezim. Dengan narasi yang emosional dan menggugah, novel ini tidak hanya menceritakan penderitaan para korban, tetapi juga bagaimana keluarga mereka mencari kebenaran dan keadilan. Laut Bercerita adalah kisah yang menyentuh, mengingatkan pada sejarah kelam Indonesia, sekaligus menjadi suara bagi mereka yang tak bisa lagi berbicara.',
      rate: 4.7,
      page: 379,
      categoryBook: 'Fiksi',
      language: 'IDN'
  ),
  Book(
      name: 'Psychology of Money',
      image: 'images/buku_psychology.png',
      description:
      'The Psychology of Money adalah buku karya Morgan Housel yang membahas bagaimana perilaku, emosi, dan psikologi memengaruhi cara seseorang mengelola uang. Buku ini menekankan bahwa kesuksesan finansial tidak hanya ditentukan oleh pengetahuan atau kecerdasan, tetapi juga oleh kebiasaan dan pola pikir. Melalui berbagai kisah nyata dan perspektif unik, Housel menjelaskan konsep seperti kekuatan kesabaran, pentingnya keputusan jangka panjang, dan bagaimana manusia sering kali tidak rasional dalam mengambil keputusan keuangan. Buku ini cocok bagi siapa saja yang ingin memahami hubungan antara psikologi dan keuangan untuk mencapai kebebasan finansial.',
      rate: 4.4,
      page: 256,
      categoryBook: 'Psikologi',
      language: 'IDN'
  ),
];

