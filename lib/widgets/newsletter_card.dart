import 'package:flutter/material.dart';

import '../models/newsletter.dart';
import 'cached_image.dart';

class NewsletterCard extends StatefulWidget {
  final Newsletter newsletter;

  const NewsletterCard({Key? key, required this.newsletter}) : super(key: key);

  @override
  State<NewsletterCard> createState() => _NewsletterCardState();
}

class _NewsletterCardState extends State<NewsletterCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Hero(
                tag: widget.newsletter.imageUrl,
                child: CachedNetworkImageWidget(
                  imageUrl: widget.newsletter.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const SizedBox(
                    height: 80,
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.newsletter.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${widget.newsletter.description.substring(0, 40)}...",
                      // style: const TextStyle(overflow: TextOverflow.visible),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.newsletter.readTime,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.newsletter.writer,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.thumb_up,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          const Icon(
                            Icons.bookmark_border,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          const Icon(
                            Icons.share,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Container(
                              // alignment: Alignment.topLeft,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.newsletter.topic,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
