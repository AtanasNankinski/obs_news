import 'package:flutter/material.dart';

import 'package:obs_news/components/base_layout.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      hasPadding: true,
      title: Text(
        "News",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      body: const Center(
        child: Text("News Page"),
      ),
    );
  }
}
