import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';

class AvatarSelectionDialog extends StatelessWidget {
  final String currentAvatarUrl;
  final Function(String) onAvatarSelected;

  const AvatarSelectionDialog({
    super.key,
    required this.currentAvatarUrl,
    required this.onAvatarSelected,
  });

  static const List<String> avatars = [
    'assets/images/mascot/ic_crocodile_0.png',
    'assets/images/mascot/ic_crocodile_1.png',
    'assets/images/mascot/ic_crocodile_2.png',
    'assets/images/mascot/ic_crocodile_3.png',
    'assets/images/mascot/ic_crocodile_4.png',
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: 20.borderRadius),
      child: Padding(
        padding: 20.paddingAll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.selectAvatar,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            20.height,
            SizedBox(
              width: double.maxFinite,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  final avatar = avatars[index];
                  final isSelected = currentAvatarUrl == avatar;
                  return GestureDetector(
                    onTap: () {
                      onAvatarSelected(avatar);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(avatar),
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                      ),
                    ),
                  );
                },
              ),
            ),
            20.height,
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
          ],
        ),
      ),
    );
  }
}
