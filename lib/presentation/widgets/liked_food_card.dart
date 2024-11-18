import 'package:flutter/material.dart';

class FavoriteCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final double distance;
  final int minute;
  final List<String> tags;
  final VoidCallback onFavoriteChanged;

  const FavoriteCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.distance,
    required this.minute,
    required this.tags,
    required this.onFavoriteChanged,
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited; 
    });
    widget.onFavoriteChanged(); 
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0,left: 8.0,right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 16),
                          const SizedBox(width: 2),
                          Text(widget.rating.toString()),
                          Text(
                            " | ",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                            ),
                          ),
                          Text("${widget.distance}km"),
                          Text(
                            " | ",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                            ),
                          ),
                          Text("${widget.minute} phút"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: widget.tags
                            .map(
                              (tag) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.amber, width: 1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.amber[700],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  _isFavorited
                      ? Icons.favorite
                      : Icons.favorite_border, 
                  color: _isFavorited ? Colors.red : Colors.grey,
                ),
                onPressed: _toggleFavorite, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
