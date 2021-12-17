import 'package:flutter/material.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';

class Headlines extends StatelessWidget {
  const Headlines(
      {Key? key,
      required this.news,
      required this.size,
      required this.onPressed})
      : super(key: key);

  final List<News> news;
  final Size size;
  final Function(News news) onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: news.length,
      itemBuilder: (context, index) {
        final newsSingle = news[index];
        final dateDifference =
            DateTime.now().difference(newsSingle.publishedDate).inHours;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () => onPressed(newsSingle),
            child: SizedBox(
              width: size.width / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: size.height / 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: newsSingle.urlToImage != null
                                ? NetworkImage(newsSingle.urlToImage!)
                                : const AssetImage(
                                        'assets/images/breaking_news.png')
                                    as ImageProvider)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    newsSingle.title,
                    style: Theme.of(context).textTheme.headline2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${dateDifference.toString()} hours ago",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Source: ${newsSingle.source.name}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
