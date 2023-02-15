import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase/database.dart';
import '../utils/constants.dart';
import '../models/newsletter.dart';
import '../utils/user/user_provider.dart';
import 'cached_image.dart';
import '../utils/snake_bar.dart';

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
  final DatabaseService _db = DatabaseService();
  bool isBookmarked = false;

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
    final User? user = getUser(context);

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
                      widget.newsletter.title.length >= 20
                          ? "${widget.newsletter.title.substring(0, 20)}..."
                          : widget.newsletter.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // PDFViewer(
                    //   pdfLink: widget.newsletter.pdfLink,
                    // ),
                    Text(
                      widget.newsletter.description.length >= 40
                          ? "${widget.newsletter.description.substring(0, 40)}..."
                          : widget.newsletter.description,
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
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.newsletter.writer.length >= 15
                                  ? "${widget.newsletter.writer.substring(0, 10)}..."
                                  : widget.newsletter.writer,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
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
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              _updateBookmarkState(
                                user?.uid,
                                widget.newsletter,
                              );
                            },
                            child: Icon(
                              widget.newsletter.isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 22,
                              color: widget.newsletter.isBookmarked
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
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

  _updateBookmarkState(String? userId, Newsletter newsletter) async {
    if (userId == null) {
      return showSnakeBar(
        context: context,
        content: 'Yay! Try to login first!',
        label: 'Login',
        onPressed: _handleSnakeBarOnPressed,
      );
    }

    final isMarked = await _db.updateUserBookmark(
      context,
      userId,
      newsletter,
    );
    setState(() {
      isBookmarked = isMarked;
    });
  }

  _handleSnakeBarOnPressed() {
    Navigator.pushNamed(context, Routes.login);
  }
}
