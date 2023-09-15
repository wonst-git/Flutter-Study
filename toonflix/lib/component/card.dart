import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/webtoon_detail_screen.dart';

class WebtoonCard extends StatelessWidget {
  final String title, thumb, id;

  const WebtoonCard({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => {
        Navigator.of(context).pushNamed(
          WebtoonDetail.screenId,
          arguments: WebtoonModel(title: title, thumb: thumb, id: id),
        )
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black45,
                  offset: Offset(2, 2),
                ),
              ]),
              child: Hero(
                tag: 'thumbnail$id',
                child: Image.network(
                  thumb,
                  headers: const {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Whale/3.22.205.18 Safari/537.36"},
                ),
              ),
            ),
            const SizedBox(height: 10),
            Hero(
              tag: 'title$id',
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
