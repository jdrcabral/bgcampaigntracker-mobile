import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class MetaText extends ConsumerStatefulWidget {
  final Map<String, dynamic> layout;
  final Map<String, dynamic>? options;
  const MetaText({Key? key, required this.layout, this.options})
      : super(key: key);

  @override
  _MetaTextState createState() =>
      _MetaTextState();
}

class _MetaTextState extends ConsumerState<MetaText> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: widget.layout["size"] ?? 20);
    if (widget.layout.containsKey("ref")) {
      // TODO create a ref data fetcher
      return Text(
        widget.layout["ref"],
        style: textStyle,
      );
    }
    return Text(
      widget.layout["label"],
      style: textStyle,
    );
  }
}
