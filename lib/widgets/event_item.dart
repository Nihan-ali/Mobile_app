import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int seen;
  final String icon;
  final String groupImage;

  const EventItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.seen,
    required this.icon,
    required this.groupImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon, height: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                "$seen seen",
                style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
              const Spacer(),
              Image.asset(
                groupImage,
                height: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
