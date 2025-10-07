import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';

class ViewOfTabbar extends StatelessWidget {
  String title;
  final List<Data>? products;
  // final int index;
  ViewOfTabbar({
    required this.products,
    required this.title,
    // required this.index,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${title}",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xff06004F),
          ),
        ),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            products?[0].category?.image??"",
            width: 237,
            height: 94,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 13,
              crossAxisSpacing: 13,
              childAspectRatio: 1 / 1,
            ),
            itemCount: products?.length ?? 0,
            itemBuilder:
                (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    products?[index].imageCover ?? "",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
