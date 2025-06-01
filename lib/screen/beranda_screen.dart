import 'package:flutter/material.dart';
import 'package:whazlansaja/models/dosen_model.dart';
import 'package:whazlansaja/screen/pesan_screen.dart';
import 'package:whazlansaja/utils/load_dosen_data.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  List<Dosen> daftarDosen = [];

  @override
  void initState() {
    super.initState();
    loadDosen().then((value) {
      setState(() {
        daftarDosen = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhAzlansaja'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SearchAnchor.bar(
              barHintText: 'Cari dosen dan mulai chat',
              suggestionsBuilder: (context, controller) => [
                const Text('Belum ada pencarian'),
              ],
            ),
          ),
        ),
      ),
      body: daftarDosen.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: daftarDosen.length,
              itemBuilder: (context, index) {
                final dosen = daftarDosen[index];
                final bool isAzlan = dosen.nama.contains('Azlan');

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PesanScreen(dosen: dosen),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(dosen.gambar),
                  ),
                  title: Text(dosen.nama),
                  subtitle: Text(
                    dosen.historiChat.isEmpty
                        ? 'Belum ada pesan'
                        : dosen.historiChat.last.pesan,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: isAzlan
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '2 menit yang lalu',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          'Kemarin',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                );
              },
            ),
    );
  }
}
