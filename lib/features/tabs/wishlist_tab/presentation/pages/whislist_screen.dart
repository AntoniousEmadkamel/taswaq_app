import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/tabs/wishlist_tab/presentation/widgets/wishlist_item.dart';
import '../../../../../config/routes/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../home_tab/presentation/manager/home_bloc.dart';

class WhishListScreen extends StatelessWidget {
  const WhishListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeBloc, HomeState>(
   listener: (context, state) {
        if (state.homeState== HomeStates.loading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder:
                (context) => const AlertDialog(
              title: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        }
        else if (state.homeState == HomeStates.success) {
          Navigator.pop(context);
          Navigator.pushNamed(context,AppRoutes.home);
        }
        else if (state.homeState == HomeStates.error) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder:
                (context) => AlertDialog(
              title: const Text("Error", style: TextStyle(fontSize: 18)),
              elevation: 0,
              content: SizedBox(
                height: 450,
                child: Column(
                  children: [
                    Text(
                      state.productFailure?.message ??
                          "unknown error occurred",
                      style: const TextStyle(color: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:25 ,),
            Image.asset("assets/images/route_logo.png",width: 66,height: 22),
            SizedBox(height:10 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.search,size: 24,color: AppColors.blueColor,),
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "what do you search for?",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: Color.fromRGBO(6,0, 79, 0.6)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Color(0xff004182),width: 1 ),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Color(0xff004182),width: 1 ),
                          borderRadius: BorderRadius.circular(25)
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.cart);
                } ,icon: Icon(CupertinoIcons.shopping_cart,size: 24,color: AppColors.blueColor)),
              ],),
            Expanded(child: ListView.separated(
              itemCount:state.getWhishlistModel?.data?.length??0 ,
              itemBuilder:(context, index) => WishlistItem(data:state.getWhishlistModel?.data?[index], fav:state.iDs?.contains(state.productListModel?.data?[index].id) ?? false,),
              separatorBuilder: (context, index) => SizedBox(height: 15,),
            )
            ),
          ]
      ),
    );
  },
);
  }
}