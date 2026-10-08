import 'package:flutter/material.dart';

// Reusable widget (Bagian 7)
class ProductCard extends StatelessWidget {
  final String nama;
  final int harga;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback? onHapus;

  const ProductCard({
    super.key,
    required this.nama,
    required this.harga,
    required this.onTap,
    this.icon = Icons.inventory_2,
    this.onHapus,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 36, color: Colors.indigo),
                if (onHapus != null)
                  InkWell(
                    onTap: onHapus,
                    child: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
              ],
            ),
            const Spacer(),
            Text(
              nama,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text('Rp $harga', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}