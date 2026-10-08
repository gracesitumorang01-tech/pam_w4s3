import 'package:flutter/material.dart';
import '../models/produk.dart';
import '../widget_basic/product_card.dart';

class ProdukListPage extends StatelessWidget {
  final List<Produk> produk;
  final void Function(Produk) onTapProduk;
  final void Function(int) onHapusProduk;

  const ProdukListPage({
    super.key,
    required this.produk,
    required this.onTapProduk,
    required this.onHapusProduk,
  });

  @override
  Widget build(BuildContext context) {
    if (produk.isEmpty) {
      return const Center(child: Text('Belum ada produk. Tekan + untuk menambah.'));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: produk.length,
      itemBuilder: (context, index) {
        final item = produk[index];
        return ProductCard(
          nama: item.nama,
          harga: item.harga,
          icon: item.icon,
          onTap: () => onTapProduk(item),
          onHapus: () => onHapusProduk(index),
        );
      },
    );
  }
}