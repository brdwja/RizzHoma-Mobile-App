import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<Map<String, String>> newsData = [
    {
      "title": "Is Utility-Scale Solar Stealing Our Food? Think Again.",
      "subtitle":
          "Net Emissions From Converting Agricultural Land to Solar are Variable, but Fears That Expanding Solar Will Threaten U.S. Food Security are Largely Overblown",
      "imageUrl":
          "https://thebreakthrough.imgix.net/bassutilitysolar.jpeg?auto=format&dpr=1&crop=faces%2Ccenter&fit=clip&w=1200&ixlib=react-7.2.0",
      "source": "The Breakthrough Instituted",
      "url":
          "https://thebreakthrough.org/issues/food-agriculture-environment/is-utility-scale-solar-stealing-our-food-think-again",
    },
    {
      "title": "Waste bin lorries to be powered by vegetable oil",
      "subtitle":
          "Gravesham Borough Council's vehicle fleet is to be converted to run on low-emission renewable fuel",
      "imageUrl":
          "https://ichef.bbci.co.uk/news/1024/cpsprodpb/e630/live/79685310-c9d2-11ef-9ab9-ab804f6bc155.jpg.webp",
      "source": "BBC News",
      "url": "https://www.bbc.com/news/articles/czxdz4npznjo",
    },
    {
      "title":
          "Longsor Terjadi di 5 Titik Jalur Ende-Nangaba, Lalu Lintas Tersendat",
      "subtitle":
          "Longsor di Kabupaten Ende, NTT, terjadi di 5 titik akibat hujan deras, mengganggu lalu lintas. Warga dihhimbau berhati-hati karena risiko longsor susulan",
      "imageUrl":
          "https://akcdn.detik.net.id/community/media/visual/2025/01/04/longsor-di-ende_169.jpeg?w=700&q=90",
      "source": "DetiK Bali",
      "url":
          "https://www.detik.com/bali/nusra/d-7717678/longsor-terjadi-di-5-titik-jalur-ende-nangaba-lalu-lintas-tersendat",
    },
    {
      "title":
          "Hutan adalah 'ibu': Pengabdian Mama Nela selamatkan mangrove di Hutan Perempuan Papua",
      "subtitle":
          "Pembangunan infrastruktur di Papua menyisakan kerusakan lingkungan. Mama Nela kemudian menggerakkan masyarakat untuk memperbaiki hutan mangrove, sekaligus menciptakan peluang ekonomi dari olahan hutan.",
      "imageUrl":
          "https://dam.mediacorp.sg/image/upload/s---cdKaTs6--/c_fill,g_auto,h_468,w_830/f_auto,q_auto/v1/mediacorp/cnabahasa/images/2024-12/468644636_604628605254379_7713112098904488099_n.jpg?itok=f7dxmgUA",
      "source": "CNA",
      "url":
          "https://www.cna.id/indonesia/hutan-adalah-ibu-pengabdian-mama-nela-selamatkan-mangrove-di-hutan-perempuan-papua-26216",
    }
  ];

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6096B4)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Today's Article",
          style: TextStyle(
            color: Color(0xFF6096B4),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (newsData[index]["url"]!.isNotEmpty) {
                launchURL(newsData[index]["url"]!);
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (newsData[index]["imageUrl"]!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          newsData[index]["imageUrl"]!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      newsData[index]["title"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      newsData[index]["subtitle"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Click Here To Read",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          newsData[index]["source"]!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
