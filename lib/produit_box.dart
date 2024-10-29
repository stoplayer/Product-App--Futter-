import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProduitBox extends StatelessWidget {
  final String nomProduit;
  final bool selProduit;
  final Function(String, bool?) onChanged;
  final Function(String) delProduit;

  const ProduitBox({
    super.key,
    required this.nomProduit,
    required this.selProduit,
    required this.onChanged,
    required this.delProduit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => delProduit(nomProduit),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Supprimer',
            ),
          ],
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Row(
            children: [
              Checkbox(
                value: selProduit,
                onChanged: (bool? value) => onChanged(nomProduit, value),
              ),
              Text(nomProduit),
            ],
          ),
        ),
      ),
    );
  }
}