import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoned_express/utils/error_util.dart';

import '../models/newsletter.dart';
import '../services/firebase/database.dart';
import '../utils/user/user_provider.dart';
import 'cached_image.dart';

class BookmarkCard extends StatefulWidget {
  final Newsletter bookmark;

  const BookmarkCard({
    Key? key,
    required this.bookmark,
  }) : super(key: key);

  @override
  State<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  final DatabaseService _db = DatabaseService();

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
                tag: widget.bookmark.imageUrl,
                child: CachedNetworkImageWidget(
                  imageUrl: widget.bookmark.imageUrl,
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
                      widget.bookmark.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${widget.bookmark.description.substring(0, 40)}...",
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
                            widget.bookmark.readTime,
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
                            widget.bookmark.writer,
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
                          InkWell(
                            onTap: () async {
                              ErrorUtil.showErrorDialog(
                                  context, "You unset this bookmark :)");
                              await _db.updateUserBookmark(
                                context,
                                user?.uid,
                                widget.bookmark,
                              );
                            },
                            child: const Icon(
                              // _isBookmarked
                              Icons.bookmark,
                              // : Icons.bookmark_border,
                              size: 18,
                              color:
                                  // _isBookmarked
                                  // ? Colors.blue
                                  Colors.black,
                            ),
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
                                widget.bookmark.topic,
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
