import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/widgets/containers/duolingo_style.dart';

class MediaTypeSelectionListItem extends StatelessWidget {
  const MediaTypeSelectionListItem({
    super.key,
    required this.mediaType,
    required this.onTap,
  });

  final MediaType mediaType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DuolingoCard(
        color: mediaType.color,
        child: Row(
          children: [
            Icon(mediaType.icon),
            8.width,
            Text(mediaType.label),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
