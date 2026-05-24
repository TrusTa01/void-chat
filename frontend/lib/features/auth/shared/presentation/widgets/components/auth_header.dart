import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String mainText;
  final String description;
  final String? imageAssetPath;
  final ({double alpha, double blurRadius, double spreadRadius}) imageBoxShadow;

  const AuthHeader({
    super.key,
    required this.mainText,
    required this.description,
    this.imageAssetPath,
    this.imageBoxShadow = (alpha: 0.3, blurRadius: 10, spreadRadius: 1),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imageAssetPath != null) ...[
            // Image
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withValues(
                      alpha: imageBoxShadow.alpha,
                    ),
                    blurRadius: imageBoxShadow.blurRadius,
                    spreadRadius: imageBoxShadow.spreadRadius,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  imageAssetPath!,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Main text
          Text(
            mainText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5),

          // Description under a main text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
