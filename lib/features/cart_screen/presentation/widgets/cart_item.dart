import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/cart_screen/data/models/FetchCartModel.dart';
import 'package:taswaq_app/features/cart_screen/presentation/manager/cart_bloc.dart';
import '../../../../core/utils/app_colors.dart';

class AddToCartItem extends StatelessWidget {
 Products? product;
  AddToCartItem({required this.product,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              ClipRRect( borderRadius: BorderRadius.all(Radius.circular(16)),child: Image.network(product?.product?.imageCover??"",width: 120,height: 113,fit: BoxFit.cover,)),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${product?.product?.title?.substring(0,11)??""}",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16 ,color: Color(0xff06004F)),),
                  Row(
                    children: [
                      Icon(Icons.circle,size: 15,),
                      Text("Orange |",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Color(
                          0x9906004f)),),
                      Text(" size:40",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0x9906004F)),),
                    ],
                  ),
                  Text("${product?.price??0}",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18 ,color: Color(0xff06004F)),),
                ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){
                    int count=product?.count??0;
                    count=0;
                    BlocProvider.of<CartBloc>(context).add(UpdateCartQuantityEvent(count:count,productId: product?.product?.id??""));
                  }, icon: Icon(CupertinoIcons.trash)),
                  Container(
                    width: 115,
                    height: 42,
                    decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){
                          int count=product?.count??0;
                          if(count>0){count-=1;}
                          BlocProvider.of<CartBloc>(context).add(UpdateCartQuantityEvent(count:count , productId: product?.product?.id??""));
                        }, icon: Icon(CupertinoIcons.minus_circle,color: Colors.white,size: 20,)),
                        Text("${product?.count??0}",style: GoogleFonts.poppins(fontSize: 18,fontWeight:FontWeight.w500,color: Colors.white ),),
                        IconButton(onPressed: (){
                          int count=product?.count??0;
                          count+=1;
                          BlocProvider.of<CartBloc>(context).add(UpdateCartQuantityEvent(count:count,productId: product?.product?.id??""));
                        }, icon: Icon(CupertinoIcons.add_circled,color: Colors.white,size: 20,)),
                      ],
                    ),
                  )
                ],),
            ],
          ),
        )
      ],
    );
  }
}