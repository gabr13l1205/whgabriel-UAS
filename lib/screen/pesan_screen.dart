import 'package:flutter/material.dart';
import 'package:whazlansaja/models/dosen_model.dart';
import 'package:whazlansaja/data_saya.dart';

class PesanScreen extends StatefulWidget {
  final Dosen dosen;
  const PesanScreen({super.key, required this.dosen});

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  final TextEditingController _pesanController = TextEditingController();

  void kirimPesan() {
    final isiPesan = _pesanController.text.trim();
    if (isiPesan.isEmpty) return;

    setState(() {
      widget.dosen.historiChat.add(HistoriChat(alur: 1, pesan: isiPesan));
      _pesanController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 29,
        elevation: 2,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: AssetImage(widget.dosen.gambar),
            radius: 16,
          ),
          title:
              Text(widget.dosen.nama, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: const Text('Online'),
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.video_call)),
          IconButton(onPressed: null, icon: Icon(Icons.call)),
          IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.dosen.historiChat.length,
              itemBuilder: (context, index) {
                final chat = widget.dosen.historiChat[index];
                final isDosen = chat.alur == 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment:
                        isDosen ? MainAxisAlignment.start : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isDosen)
                        CircleAvatar(
                          backgroundImage: AssetImage(widget.dosen.gambar),
                          radius: 14,
                        ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.65,
                          ),
                          decoration: BoxDecoration(
                            color: isDosen
                                ? colorScheme.tertiary
                                : colorScheme.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft:
                                  Radius.circular(isDosen ? 0 : 12),
                              bottomRight:
                                  Radius.circular(isDosen ? 12 : 0),
                            ),
                          ),
                          child: Text(
                            chat.pesan,
                            style: TextStyle(
                              fontSize: 15,
                              color: isDosen
                                  ? colorScheme.onTertiary
                                  : colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      if (!isDosen)
                        CircleAvatar(
                          backgroundImage: AssetImage(DataSaya.gambar),
                          radius: 14,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _pesanController,
                    minLines: 1,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.emoji_emotions),
                      hintText: 'Ketikkan pesan',
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: kirimPesan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
