import 'package:flutter/material.dart';
import 'package:flutter_news/core/clippers/oval_bottom_clipper.dart';
import 'package:flutter_news/core/colors.dart';
import 'package:flutter_news/features/news/domain/entities/news.dart';

class NewsOfTheDay extends StatelessWidget {
  const NewsOfTheDay({
    Key? key,
    required this.newsOfTheDay,
    required this.onPressed,
  }) : super(key: key);

  final News newsOfTheDay;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomClipper(),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.multiply),
                fit: BoxFit.cover,
                image: newsOfTheDay.urlToImage != null
                    ? NetworkImage(newsOfTheDay.urlToImage!)
                    : const AssetImage('assets/images/breaking_news.png')
                        as ImageProvider)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey.withOpacity(0.5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    'News of the day',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colours.kTextColorOnDark),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                newsOfTheDay.title,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colours.kTextColorOnDark),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: onPressed,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Learn more',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colours.kTextColorOnDark),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colours.kTextColorOnDark,
                      size: 24,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
