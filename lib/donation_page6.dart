import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'donation_page7.dart';

class DonationPage6 extends StatelessWidget {
  final String metodePembayaran;
  final int nominal;
  final String nomorPengguna;
  final String dukungan;

  const DonationPage6({
    Key? key,
    required this.metodePembayaran,
    required this.nominal,
    required this.nomorPengguna,
    this.dukungan = '',
  }) : super(key: key);

  String getBatasWaktu() {
    final now = DateTime.now().add(const Duration(days: 1));
    return DateFormat('EEEE, d MMMM y HH:mm', 'id_ID').format(now) + ' WIB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EED9),
      appBar: AppBar(
        title: const Text('Instruksi Pembayaran'),
        backgroundColor: const Color(0xFF6D93B0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBox('Batas Waktu Pembayaran', getBatasWaktu()),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Image.asset('asset/ikonqris.png', width: 80),
                const SizedBox(height: 16),
                Image.asset(
                  'asset/QR_code_donation.png',
                  width: 220,
                  height: 220,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                _buildBox(
                  'Nominal Donasi',
                  'Rp. ${NumberFormat.decimalPattern('id_ID').format(nominal)}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildSupportBox(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => DonationPage7(
                      metodePembayaran: metodePembayaran,
                      nominal: nominal,
                    ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6D93B0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Cek Status',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildBox(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const TextField(
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Sertakan dukungan (Opsional)',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
