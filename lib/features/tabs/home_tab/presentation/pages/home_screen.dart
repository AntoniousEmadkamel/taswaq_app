// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:taswaq_app/config/routes/app_route.dart';
// import 'package:taswaq_app/core/utils/app_colors.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:taswaq_app/features/tabs/home_tab/presentation/manager/home_bloc.dart';
//
// import '../../../products_tab/presentation/pages/products_list_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//    HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//    int current=0;
//   List<Image> carouselItems = [
//     Image.asset('assets/images/property1_default.png'),
//     Image.asset('assets/images/group12.png'),
//     Image.asset('assets/images/group13.png'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     var bloc=BlocProvider.of<HomeBloc>(context);
//     return BlocConsumer<HomeBloc, HomeState>(
//   listener: (context, state) {
//
//   },
//   builder: (context, state) {
//     return Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              SizedBox(height:25 ,),
//              Image.asset("assets/images/route_logo.png",width: 66,height: 22),
//              SizedBox(height:10 ,),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                SizedBox(
//                  width: 320,
//                  height: 50,
//                  child: TextFormField(
//                    decoration: InputDecoration(
//                      prefixIcon: Icon(CupertinoIcons.search,size: 24,color: AppColors.blueColor,),
//                      filled: true,
//                      fillColor: Colors.transparent,
//                      hintText: "what do you search for?",
//                      hintStyle: GoogleFonts.poppins(
//                          fontWeight: FontWeight.w300,
//                          fontSize: 18,
//                          color: Color.fromRGBO(6,0, 79, 0.6)
//                      ),
//                      enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color:Color(0xff004182),width: 1 ),
//                          borderRadius: BorderRadius.circular(25)
//                      ),
//                      focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color:Color(0xff004182),width: 1 ),
//                          borderRadius: BorderRadius.circular(25)
//                      ),
//                    ),
//                  ),
//                ),
//                 IconButton(onPressed: (){
//                   Navigator.pushNamed(context, AppRoutes.cart);
//                 } ,icon: Icon(CupertinoIcons.shopping_cart,size: 24,color: AppColors.blueColor)),
//              ],),
//              SizedBox(height:16,),
//              Stack(
//                 alignment: Alignment.bottomCenter,
//                children: [
//                  SizedBox(
//                    width: 398,
//                    height: 200,
//                    child: CarouselSlider(
//                      items: carouselItems,
//                      options: CarouselOptions(
//                        viewportFraction: 1.0,
//                        onPageChanged: (index, reason) {
//                          setState(() {
//                            current = index;
//                          }); },
//                        height: 200, // Customize the height of the carousel
//                        autoPlay: true, // Enable auto-play
//                        enlargeCenterPage: true, // Increase the size of the center item
//                        enableInfiniteScroll: true, // Enable infinite scroll
//                      ),
//                    ),
//                  ),
//                  Positioned(
//                    bottom:4,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: carouselItems.asMap().entries.map((entry) {
//                        return GestureDetector(
//                          onTap: (){},
//                          child: Container(
//                            width: 10.0,
//                            height: 10.0,
//                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                            decoration: BoxDecoration(
//                                shape: BoxShape.circle,
//                                color: entry.key == current ?AppColors.blueColor : Colors.white
//                                   ),
//                          ),
//                        );
//                      }).toList(),
//                    ),
//                  ),
//                ],
//              ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                 Text("Categories",style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: AppColors.blueColor
//                 ),),
//                 InkWell(
//                   onTap: (){
//                     final ValueNotifier<int>? index =
//                         context.findAncestorStateOfType<_HomeLayoutState>()?.index;
//                     if (index != null) {
//                       index.value = 1; // Change to Page2
//                     }
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsListScreen()),);
//                   },
//                   child: Text("view all",style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12,
//                       color: AppColors.blueColor
//                   ),),
//                 ),
//
//               ],),
//              Expanded(
//                flex: 4,
//                child: GridView.builder(
//                  scrollDirection: Axis.horizontal, // Set horizontal scrolling
//                  itemCount:state.categoriesModel?.data?.length??0,
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 2),
//                  itemBuilder: (context, index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(backgroundImage: NetworkImage(state.categoriesModel?.data?[index].image??""),radius: 50,backgroundColor: Colors.red,),
//                     Text(state.categoriesModel?.data?[index].name??"",textAlign: TextAlign.center,style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: AppColors.blueColor
//                     )),
//                   ],
//                 );
//                },),
//              ),
//              Text("Home Appliance",style: GoogleFonts.poppins(
//                  fontWeight: FontWeight.w500,
//                  fontSize: 18,
//                  color: AppColors.blueColor
//              ),),
//              Expanded(
//                flex: 2,
//                child: GridView.builder(
//                  scrollDirection: Axis.horizontal, // Set horizontal scrolling
//                  itemCount: 4,
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  mainAxisSpacing: 16,
//                  crossAxisCount: 1),
//                  itemBuilder: (context, index) {
//                    return Stack(
//                        alignment: Alignment.topRight,
//                        children: [
//                          SizedBox(
//                            width:158,
//                            height: 115,
//                            child: Image(fit: BoxFit.fill,image: NetworkImage(state.categoriesModel?.data?[5].image??"")),
//                          ),
//                          Container(
//                            margin: EdgeInsets.all(8),
//                              height: 24,
//                              width: 24,
//                              decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  borderRadius: BorderRadius.circular(12)
//                              ), child:Icon(size: 16,Icons.favorite_border_outlined,color: AppColors.blueColor,)),
//                        ]
//                    );
//                  },),
//              ),
//            ],
//          ),
//        );
//   },
// );
//   }
// }




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import 'package:taswaq_app/core/utils/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:taswaq_app/features/tabs/home_tab/presentation/manager/home_bloc.dart';

import '../../../home_layout.dart';
import '../../../products_tab/presentation/pages/products_list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  List<Image> carouselItems = [
    Image.asset('assets/images/property1_default.png'),
    Image.asset('assets/images/group12.png'),
    Image.asset('assets/images/group13.png'),
  ];

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HomeBloc>(context);
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Image.asset("assets/images/route_logo.png", width: 66, height: 22),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 320,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          size: 24,
                          color: AppColors.blueColor,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "what do you search for?",
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color.fromRGBO(6, 0, 79, 0.6)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff004182), width: 1),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff004182), width: 1),
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.cart);
                      },
                      icon: Icon(CupertinoIcons.shopping_cart,
                          size: 24, color: AppColors.blueColor)),
                ],
              ),
              SizedBox(height: 16),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: 398,
                    height: 200,
                    child: CarouselSlider(
                      items: carouselItems,
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            current = index;
                          });
                        },
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: carouselItems.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 10.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: entry.key == current
                                    ? AppColors.blueColor
                                    : Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.blueColor),
                  ),
                  InkWell(
                    onTap: () {
                      // Fix: Properly access and update the ValueNotifier
                      final homeLayoutState = context.findAncestorStateOfType<HomeLayoutState>();
                      if (homeLayoutState != null) {
                        homeLayoutState.index.value = 1; // Change to products tab
                      }
                    },
                    child: Text(
                      "view all",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.blueColor),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 4,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categoriesModel?.data?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              state.categoriesModel?.data?[index].image ?? ""),
                          radius: 50,
                          backgroundColor: Colors.red,
                        ),
                        Text(state.categoriesModel?.data?[index].name ?? "",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.blueColor)),
                      ],
                    );
                  },
                ),
              ),
              Text(
                "Home Appliance",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.blueColor),
              ),
              Expanded(
                flex: 2,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 16, crossAxisCount: 1),
                  itemBuilder: (context, index) {
                    return Stack(alignment: Alignment.topRight, children: [
                      SizedBox(
                        width: 158,
                        height: 115,
                        child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                state.categoriesModel?.data?[5].image ?? "")),
                      ),
                      Container(
                          margin: EdgeInsets.all(8),
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            size: 16,
                            Icons.favorite_border_outlined,
                            color: AppColors.blueColor,
                          )),
                    ]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}