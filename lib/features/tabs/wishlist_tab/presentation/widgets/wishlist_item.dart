import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/GetWhishlistModel.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../home_tab/presentation/manager/home_bloc.dart';

class WishlistItem extends StatelessWidget {
  bool fav = false;
  final Data? data;
   WishlistItem({required this.data,required this.fav,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 398,
      height: 113,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColors.blueColor.withAlpha(30),
        ),
        borderRadius:BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect( borderRadius: BorderRadius.all(Radius.circular(16)),child: Image.network(data?.imageCover?? "",width: 120,height: 113,fit: BoxFit.cover,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data?.title?.substring(0,11)??"",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14 ,color: Color(0xff06004F)),),
              Row(
                children: [
                  Icon(Icons.circle,size: 15,),
                  Text("Orange",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff06004F)),),
                  Text(" color",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff06004F)),),
                ],
              ),
              Row(
                children: [
                  Text(data?.price.toString()??"",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14 ,color: Color(0xff06004F)),),
                  Text(data?.price.toString()??"",style: GoogleFonts.poppins(decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w400,fontSize: 12 ,color: Color(0xff004182)),),
                ],
              ),
            ],),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(backgroundColor: Colors.white,child: IconButton(onPressed: (){
                BlocProvider.of<HomeBloc>(context).add(RemoveProductFromWhishlistEvent(productId: data?.id??""));
              }, icon: Icon(CupertinoIcons.heart_fill,color: AppColors.blueColor,size: 24,))),
              Container(
                width: 100,
                height: 36,
                decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.circular(20)
                ),
                child:InkWell(onTap: (){
                  BlocProvider.of<HomeBloc>(context).add(AddToCartEvent(productId: data?.id??""));
                  BlocProvider.of<HomeBloc>(context).add(RemoveProductFromWhishlistEvent(productId: data?.id??""));
                },child: Center(child: Text("Add To Cart",style: GoogleFonts.poppins(fontSize: 14,fontWeight:FontWeight.w500,color: Colors.white ),))),
              )
            ],),

        ],
      ),
    );
  }
}
