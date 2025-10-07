import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../cart_screen/data/data_sources/cart_screen_remote_ds_impl.dart';
import '../../../cart_screen/data/repositories/cart_screen_repo_impl.dart';
import '../../../cart_screen/domain/use_cases/clear_cart_usecase.dart';
import '../../../cart_screen/domain/use_cases/fetch_cart_usecase.dart';
import '../../../cart_screen/domain/use_cases/update_cart_quantity_usecase.dart';
import '../../../cart_screen/presentation/manager/cart_bloc.dart';
import '../../../tabs/home_tab/data/data_sources/home_tab_remote_ds_impl.dart';
import '../../../tabs/home_tab/data/repositories/home_tab_repo_impl.dart';
import '../../../tabs/home_tab/domain/use_cases/add_product_to_whishlist_usecase.dart';
import '../../../tabs/home_tab/domain/use_cases/add_to_cart_usecase.dart';
import '../../../tabs/home_tab/domain/use_cases/categories_usecase.dart';
import '../../../tabs/home_tab/domain/use_cases/get_whishlist_usecase.dart';
import '../../../tabs/home_tab/domain/use_cases/products_list_usecase.dart';
import '../../../tabs/home_tab/domain/use_cases/remove_product_from_whishlist_usecase.dart';
import '../../../tabs/home_tab/presentation/manager/home_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Data? productData;

  ProductDetailsScreen({required this.productData, super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int current = 0;
  int count=1;
  List<String> carouselImagePaths = [];
  bool isSelected = false;
  int? selectedSizeIndex;
  int? selectedColorIndex;
  List<Color> clrs = [
    const Color(0xFF2F2929),
    const Color(0xFFBC3018),
    const Color(0xFF0973DD),
    const Color(0xFF02B935),
    const Color(0xFFFF645A)
  ];
  List<String> size = ["38", "39", "40", "41", "42"];
  @override
  Widget build(BuildContext context) {
    final arguments = widget.productData;
    num price= arguments?.price??0;
    num totalprice= price * count ;
    carouselImagePaths = arguments?.images ?? [];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => HomeBloc(
                ProductsListUseCase(
                  HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager())),
                ),
                CategoriesUseCase(
                  HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager())),
                ),
                GetWhishlistUsecase(
                  HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager())),
                ),
                AddProductToWhishlistUsecase(
                  HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager())),
                ),
                RemoveProductFromWhishlistUsecase(
                  HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager())),
                ),
                AddToCartUsecase(
                  HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager())),
                ),
              )..add(FetchWhishlistEvent()),
        ),
        BlocProvider(
          create:
              (context) => CartBloc(
                FetchCartUsecase(
                  CartScreenRepoImpl(CartScreenRemoteDsImpl(ApiManager())),
                ),
                UpdateCartQuantityUsecase(
                  CartScreenRepoImpl(CartScreenRemoteDsImpl(ApiManager())),
                ),
                  ClearCartUsecase(CartScreenRepoImpl(CartScreenRemoteDsImpl(ApiManager())))
              )..add(FetchCartEvent()),
        ),
      ],
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.homeState == HomeStates.loading) {
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
          bool fav = state.getWhishlistModel?.data?.any((wishlistItem) => wishlistItem.id == widget.productData?.id,) ?? false;
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search, size: 24),),
                IconButton(onPressed: () {Navigator.pushNamed(context, AppRoutes.cart);}, icon: Icon(CupertinoIcons.cart, size: 24),),
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                "Product Details",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff06004f),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CarouselSlider(
                              items:
                                  carouselImagePaths.map((imagePath) {
                                    return Container(
                                      width: 398,
                                      height: 300,
                                      child: Image.network(
                                        imagePath,
                                        width: 398,
                                        height: 300,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }).toList(),
                              options: CarouselOptions(
                                height: 300,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    current = index;
                                  });
                                },
                                autoPlay: true,
                                // Enable auto-play
                                enlargeCenterPage: false,
                                // Disable to maintain exact dimensions
                                enableInfiniteScroll:
                                    true, // Enable infinite scroll
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    carouselImagePaths.asMap().entries.map((
                                      entry,
                                    ) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child:
                                            entry.key == current
                                                ? ClipOval(
                                                  child: Container(
                                                    width: 30.0,
                                                    height: 7.0,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 4.0,
                                                        ),
                                                    decoration: BoxDecoration(

                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
                                                      color:
                                                          AppColors.blueColor,
                                                    ),
                                                  ),
                                                )
                                                : Container(
                                                  width: 7,
                                                  height: 7,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 4.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                // if (fav) {
                                //   BlocProvider.of<HomeBloc>(context).add(RemoveProductFromWhishlistEvent(productId:widget.productData?.id??""));
                                // } else {
                                //   BlocProvider.of<HomeBloc>(context).add(AddProductToWhishlistEvent(productId:widget.productData?.id??""));
                                // }
                              },
                              icon: fav
                                  ? Icon(CupertinoIcons.heart_fill, color: AppColors.blueColor, size: 24)
                                  : Icon(size: 24, CupertinoIcons.heart, color: AppColors.blueColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          arguments?.title?.substring(0, 11) ?? "",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Color(0xff06004F),
                          ),
                        ),
                        Text(
                          'EGP ${arguments?.price.toString() ?? ""} ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Color(0xff06004F),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${arguments?.sold?.toString() ?? ""} sold',
                              style: const TextStyle(color: Color(0xFF06004F)),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.star, color: Colors.amberAccent),
                        Text(
                          "${arguments?.ratingsAverage.toString() ?? " "} ${arguments?.ratingsQuantity.toString() ?? " "} ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff06004F),
                          ),
                        ),
                        Container(
                          width: 115,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if(count>0) {count-=1;}
                                  totalprice= price * count;
                                  setState(() {});
                                },
                                icon: Icon(
                                  CupertinoIcons.minus_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              Text(
                                "${count}",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  count+=1;
                                  totalprice= price * count;
                                  setState(() {});
                                },
                                icon: Icon(
                                  CupertinoIcons.add_circled,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xff06004F),
                      ),
                    ),
                    Text(
                      arguments?.description ?? "",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0x9906004F),
                      ),
                    ),
                    Text(
                      "Size",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xff06004F),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Text(
                    //       "38",
                    //       style: GoogleFonts.poppins(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14,
                    //         color: Color(0xff06004F),
                    //       ),
                    //     ),
                    //     Text(
                    //       "39",
                    //       style: GoogleFonts.poppins(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14,
                    //         color: Color(0xff06004F),
                    //       ),
                    //     ),
                    //     CircleAvatar(
                    //       backgroundColor: AppColors.blueColor,
                    //       child: Text(
                    //         "40",
                    //         style: GoogleFonts.poppins(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //     Text(
                    //       "41",
                    //       style: GoogleFonts.poppins(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14,
                    //         color: Color(0xff06004F),
                    //       ),
                    //     ),
                    //     Text(
                    //       "42",
                    //       style: GoogleFonts.poppins(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14,
                    //         color: Color(0xff06004F),
                    //       ),
                    //     ),
                    //     Text(
                    //       "43",
                    //       style: GoogleFonts.poppins(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14,
                    //         color: Color(0xff06004F),
                    //       ),
                    //     ),
                    //     Text(
                    //       "44",
                    //       style: GoogleFonts.poppins(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14,
                    //         color: Color(0xff06004F),
                    //       ),
                    //     ),
                    //     Text(
                    //       "45",
                    //       style: GoogleFonts.poppins(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14,
                    //         color: Color(0xff06004F),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: size.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSizeIndex=index;

                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: selectedSizeIndex == index
                                          ? const Color(0xFF06004F)
                                          : Colors.white),
                                  child: Center(
                                      child: Text(
                                        size[index],
                                        style: TextStyle(
                                            color:selectedSizeIndex==index
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                ),
                              );
                            })),
                    Text(
                      "Color",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xff06004F),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     CircleAvatar(
                    //       backgroundColor: Colors.brown,
                    //       child: Text(
                    //         "",
                    //         style: GoogleFonts.poppins(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //     CircleAvatar(
                    //       backgroundColor: Colors.red,
                    //       child: Text(
                    //         "",
                    //         style: GoogleFonts.poppins(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //     CircleAvatar(
                    //       backgroundColor: AppColors.blueColor,
                    //       child: Icon(
                    //         CupertinoIcons.check_mark,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     CircleAvatar(
                    //       backgroundColor: Colors.green,
                    //       child: Text(
                    //         "",
                    //         style: GoogleFonts.poppins(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //     CircleAvatar(
                    //       backgroundColor: Colors.orange,
                    //       child: Text(
                    //         "",
                    //         style: GoogleFonts.poppins(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w ),
                      child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: clrs.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColorIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(25),
                                              color: clrs[index]
                                          ),
                                        ),
                                        if( selectedColorIndex==index)Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Total Price",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Color(0x9906004F),
                                ),
                              ),
                              Text(
                                "EGP ${totalprice.toString() ?? ""} ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Color(0xff06004F),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 229,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blueColor,
                                // Set background color
                                foregroundColor: Colors.white,
                                // Set text color
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                ), // Adjust padding
                              ),
                              onPressed: () async {
                                final homeBloc = BlocProvider.of<HomeBloc>(context);
                                final cartBloc = BlocProvider.of<CartBloc>(context);

                                // First check if product is in cart
                                final productExistsInCart = cartBloc.state.cartModel?.data?.products
                                    ?.any((item) => item.product?.id == widget.productData?.id) ?? false;

                                if (productExistsInCart) {
                                  // If already in cart, update quantity
                                  cartBloc.add(UpdateCartQuantityEvent(
                                      count: count,
                                      productId: widget.productData?.id ?? ""
                                  ));
                                } else {
                                  // If not in cart, add it multiple times (based on count)
                                  for (int i = 0; i < count; i++) {
                                    await homeBloc.addToCartUsecase(widget.productData?.id ?? "");
                                    // Small delay between requests to avoid rate limiting
                                    if (i < count-1) await Future.delayed(Duration(milliseconds:171));
                                  }
                                  // Refresh cart after all additions
                                  cartBloc.add(FetchCartEvent());
                                }
                              },                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    CupertinoIcons.cart_badge_plus,
                                    size: 24,
                                  ),
                                  Text(
                                    "Add To Cart",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
