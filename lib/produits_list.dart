import 'package:flutter/material.dart';
import 'produit_box.dart';
import 'add_produit.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  final List<String> _produits = [
    'Produit 1',
    'Produit 2',
    'Produit 3',
    'Produit 4',
  ];
  
  final Map<String, bool> _selected = {};
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var produit in _produits) {
      _selected[produit] = false;
    }
  }

  void _onChanged(String produitName, bool? value) {
    setState(() {
      _selected[produitName] = value ?? false;
    });
  }

  void _addProduit(String nom) {
    setState(() {
      _produits.add(nom);
      _selected[nom] = false;
    });
  }

  void _delProduit(String nom) {
    setState(() {
      _produits.remove(nom);
      _selected.remove(nom);
    });
  }

  void _deleteSelectedProducts() {
    setState(() {
      _selected.forEach((produit, selected) {
        if (selected) {
          _produits.remove(produit);
        }
      });
      _selected.removeWhere((key, value) => value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddProduit(
                    controller: _textController,
                    onAdd: _addProduit,
                  );
                },
              );
            },
            child: const Text('Ajouter un produit'),
          ),
          ElevatedButton(
            onPressed: _deleteSelectedProducts,
            child: const Text('Supprimer la sélection'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _produits.length,
              itemBuilder: (context, index) {
                return ProduitBox(
                  nomProduit: _produits[index],
                  selProduit: _selected[_produits[index]] ?? false,
                  onChanged: _onChanged,
                  delProduit: _delProduit,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}