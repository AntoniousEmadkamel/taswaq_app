import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import 'package:taswaq_app/features/tabs/home_tab/presentation/manager/home_bloc.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';
import '../../../../../core/utils/app_colors.dart';

class ProductListItem extends StatelessWidget {
  final Data? productData;
  int? index;
  ProductListItem({required this.productData,required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool fav = state.getWhishlistModel?.data?.any((wishlistItem) => wishlistItem.id == productData?.id) ?? false;
        return InkWell(
          onTap: () {
            if(productData != null ) {
              Navigator.pushNamed(context, AppRoutes.product, arguments: productData);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColors.blueColor.withAlpha(30),
              ),
              borderRadius:BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)
                        ),
                        child: Image.network(
                          productData?.imageCover??"",
                          width: 191,
                          height: 128,
                          fit: BoxFit.fitWidth,
                        )
                    ),
                    InkWell(
                      onTap: () {
                        // Use the current fav state to decide which action to take
                        if (fav) {
                          BlocProvider.of<HomeBloc>(context).add(
                              RemoveProductFromWhishlistEvent(productId: productData?.id??"")
                          );
                        } else {
                          BlocProvider.of<HomeBloc>(context).add(
                              AddProductToWhishlistEvent(productId: productData?.id??"")
                          );
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.all(11),
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: fav
                              ? Icon(CupertinoIcons.heart_fill, color: AppColors.blueColor, size: 24)
                              : Icon(size: 24, CupertinoIcons.heart, color: AppColors.blueColor)
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productData?.title??"",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff06004F)
                        ),
                      ),
                      Text(
                        productData?.description??"",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff06004F)
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    children: [
                      Text(
                        productData?.price.toString()??"",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff06004F)
                        ),
                      ),
                      SizedBox(width: 8), // Add some space between prices
                      Text(
                        productData?.price.toString()??"", // This should probably be originalPrice or discountedPrice
                        style: GoogleFonts.poppins(
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromRGBO(0,65, 130,0.6)
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Reviews ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff06004F)
                          )
                      ),
                      Text(
                          productData?.ratingsAverage.toString()??"",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff06004F)
                          )
                      ),
                      Icon(Icons.star_outlined, color: Color(0xfff4b400)),
                      IconButton(
                          onPressed: (){
                            // Add your cart functionality here
                          },
                          icon: Icon(
                              Icons.add_circle_outlined,
                              size: 25,
                              color: AppColors.blueColor
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}