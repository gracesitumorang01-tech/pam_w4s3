import 'package:flutter/material.dart';

class Produk {
  final String nama;
  final int harga;
  final IconData icon;

  const Produk({
    required this.nama,
    required this.harga,
    this.icon = Icons.inventory_2,
  });
}