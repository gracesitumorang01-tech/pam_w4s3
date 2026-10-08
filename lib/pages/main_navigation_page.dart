import 'package:flutter/material.dart';
import '../models/produk.dart';
import 'produk_list_page.dart';
import 'produk_detail_page.dart';
import 'tambah_produk_page.dart';
import 'profil_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _tabTerpilih = 0;
  int _jumlahKeranjang = 0;

  final List<Produk> _produk = [
    const Produk(nama: 'Kursi Minimalis', harga: 350000, icon: Icons.chair),
    const Produk(nama: 'Meja Kerja Kayu', harga: 750000, icon: Icons.table_restaurant),
    const Produk(nama: 'Lampu Meja LED', harga: 120000, icon: Icons.lightbulb),
    const Produk(nama: 'Rak Buku', harga: 450000, icon: Icons.menu_book),
    const Produk(nama: 'Sofa Santai', harga: 2500000, icon: Icons.weekend),
  ];

  // setState untuk menambah jumlah keranjang (Bagian 1)
  void _tambahKeranjang() {
    setState(() {
      _jumlahKeranjang++;
    });
  }

  // Navigasi ke detail (Bagian 4)
  void _bukaDetail(Produk produk) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdukDetailPage(
          produk: produk,
          onTambahKeranjang: _tambahKeranjang,
        ),
      ),
    );
  }

  // Ambil data balik dari form (Bagian 4.2)
  Future<void> _bukaFormTambah() async {
    final Produk? produkBaru = await Navigator.push<Produk>(
      context,
      MaterialPageRoute(builder: (context) => const TambahProdukPage()),
    );
    if (produkBaru != null) {
      setState(() {
        _produk.add(produkBaru);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${produkBaru.nama} berhasil ditambahkan')),
      );
    }
  }

  // AlertDialog konfirmasi hapus (Bagian 5)
  Future<void> _konfirmasiHapus(int index) async {
    final nama = _produk[index].nama;
    final yakin = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Produk?'),
        content: Text('"$nama" akan dihapus dari daftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (yakin == true) {
      setState(() {
        _produk.removeAt(index);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$nama telah dihapus')),
      );
    }
  }

  // Ikon keranjang dengan badge (Stack + Positioned)
  Widget _ikonKeranjang() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Isi keranjang: $_jumlahKeranjang item')),
              );
            },
          ),
          if (_jumlahKeranjang > 0)
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$_jumlahKeranjang',
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final halaman = [
      ProdukListPage(
        produk: _produk,
        onTapProduk: _bukaDetail,
        onHapusProduk: _konfirmasiHapus,
      ),
      const ProfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTerpilih == 0 ? 'Katalog Produk' : 'Profil'),
        actions: [_ikonKeranjang()],
      ),
      body: halaman[_tabTerpilih],
      floatingActionButton: _tabTerpilih == 0
          ? FloatingActionButton(
              onPressed: _bukaFormTambah,
              child: const Icon(Icons.add),
            )
          : null,
      // Navigasi tab (Bagian 6)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabTerpilih,
        onTap: (index) {
          setState(() {
            _tabTerpilih = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Produk'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}