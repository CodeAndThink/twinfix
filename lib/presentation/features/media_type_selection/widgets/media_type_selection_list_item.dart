import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

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
      borderRadius: 24.borderRadius,
      child: AppTransparentContainer(
        // borderColor: mediaType.color,
        child: Row(
          children: [
            Container(
              padding: 12.paddingAll,
              decoration: BoxDecoration(
                color: mediaType.color.withValues(alpha: 0.14),
                borderRadius: 16.borderRadius,
              ),
              child: Icon(mediaType.icon, color: mediaType.color),
            ),
            8.width,
            Expanded(
              child: Text(
                mediaType.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: mediaType.color, size: 18),
          ],
        ),
      ),
    );
  }
}
