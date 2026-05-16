import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/avatar_frame_type.dart';
import 'package:twinfix/core/enums/avatar_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';

class UserAvatar extends StatelessWidget {
  final AvatarType avatarType;
  final AvatarFrameType frameType;
  final double size;
  final double borderWidth;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    required this.avatarType,
    required this.frameType,
    this.size = 96,
    this.borderWidth = 4,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final frameColor = frameType.color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: frameType == AvatarFrameType.none
                ? Colors.white.withValues(alpha: 0.5)
                : frameColor,
            width: borderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  (frameType == AvatarFrameType.none
                          ? theme.colorScheme.primary
                          : frameColor)
                      .withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: (borderWidth / 2).paddingAll,
          child: CircleAvatar(
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            backgroundImage: avatarType.path.isNotEmpty
                ? (avatarType.path.startsWith('assets')
                      ? AssetImage(avatarType.path)
                      : NetworkImage(avatarType.path) as ImageProvider)
                : null,
            child: avatarType.path.isEmpty
                ? Icon(Icons.person, size: size * 0.5)
                : null,
          ),
        ),
      ),
    );
  }
}
