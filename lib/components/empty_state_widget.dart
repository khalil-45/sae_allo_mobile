import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? description;

  const EmptyStateWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (icon != null) icon!,
              if (title != null)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              if (description != null)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                  child: Text(
                    description!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}