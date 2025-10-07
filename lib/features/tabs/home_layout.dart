// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:taswaq_app/core/api/api_manager.dart';
// import 'package:taswaq_app/features/signup/data/models/user_model.dart';
// import 'package:taswaq_app/features/tabs/home_tab/data/repositories/home_tab_repo_impl.dart';
// import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/add_product_to_whishlist_usecase.dart';
// import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/add_to_cart_usecase.dart';
// import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/categories_usecase.dart';
// import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/get_whishlist_usecase.dart';
// import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/remove_product_from_whishlist_usecase.dart';
// import 'package:taswaq_app/features/tabs/home_tab/presentation/manager/home_bloc.dart';
// import 'package:taswaq_app/features/tabs/products_tab/presentation/pages/products_list_screen.dart';
// import 'package:taswaq_app/core/utils/app_colors.dart';
// import 'package:taswaq_app/features/tabs/home_tab/presentation/pages/home_screen.dart';
// import 'package:taswaq_app/features/tabs/wishlist_tab/presentation/pages/whislist_screen.dart';
// import 'home_tab/data/data_sources/home_tab_remote_ds_impl.dart';
// import 'home_tab/domain/use_cases/products_list_usecase.dart';
// import 'settings_tab/presentation/pages/settings_screen.dart';
//
// class HomeLayout extends StatefulWidget {
//   final UserModel? userData;
//
//   const HomeLayout({required this.userData, required, super.key});
//
//   @override
//   State<HomeLayout> createState() => _HomeLayoutState();
// }
//
// class _HomeLayoutState extends State<HomeLayout> {
//   List<Widget> screens = [];
//   final ValueNotifier<int> index =ValueNotifier<int>(0);
//
//   @override
//   void initState() {
//     super.initState();
//     screens = [
//       HomeScreen(),
//       ProductsListScreen(),
//       WhishListScreen(),
//       SettingsScreen(userData: widget.userData),
//     ];
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create:
//               (context) =>
//                   HomeBloc(
//                       ProductsListUseCase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager())),),
//                       CategoriesUseCase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager())),),
//                       GetWhishlistUsecase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
//                       AddProductToWhishlistUsecase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
//                       RemoveProductFromWhishlistUsecase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
//                       AddToCartUsecase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
//                   )
//                     ..add(FetchProductListEvent())
//                     ..add(FetchCategoriesEvent())
//                     ..add(FetchWhishlistEvent())
//         ),
//       ],
//       child: BlocConsumer<HomeBloc, HomeState>(
//         listener: (context, state) {
//           if (state.homeState== HomeStates.loading) {
//             showDialog(
//               barrierDismissible: false,
//               context: context,
//               builder:
//                   (context) => const AlertDialog(
//                 title: Center(
//                   child: CircularProgressIndicator(
//                     backgroundColor: Colors.grey,
//                   ),
//                 ),
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//               ),
//             );
//           }
//           else if (state.homeState == HomeStates.success) {
//             Navigator.pop(context);
//           }
//           else if (state.homeState == HomeStates.error) {
//             showDialog(
//               barrierDismissible: false,
//               context: context,
//               builder:
//                   (context) => AlertDialog(
//                 title: const Text("Error", style: TextStyle(fontSize: 18)),
//                 elevation: 0,
//                 content: SizedBox(
//                   height: 450,
//                   child: Column(
//                     children: [
//                       Text(
//                         state.productFailure?.message ??
//                             "unknown error occurred",
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                         },
//                         child: const Text("OK"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//
//         builder: (context, state) {
//           return Scaffold(
//             extendBody: true,
//             body: ValueListenableBuilder<int>(valueListenable: index ,builder: (context, index, child) => screens[index]),
//             bottomNavigationBar: ValueListenableBuilder(
//               valueListenable: index,
//               builder: (context, index, child) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30),
//                       topLeft: Radius.circular(30),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black38,
//                         spreadRadius: 0,
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30.0),
//                       topRight: Radius.circular(30.0),
//                     ),
//                     child: BottomNavigationBar(
//                       type: BottomNavigationBarType.shifting,
//                       onTap: (value) {
//                         index = value;
//                         setState(() {});
//                       },
//                       items: [
//                         BottomNavigationBarItem(
//                           backgroundColor: AppColors.blueColor,
//                           label: "",
//                           icon: Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: index == 0 ? Colors.white : Colors.transparent,
//                             ),
//                             child: Icon(
//                               CupertinoIcons.home,
//                               color:
//                               index == 0 ? AppColors.blueColor : Colors.white,
//                             ),
//                           ),
//                         ),
//                         BottomNavigationBarItem(
//                           backgroundColor: AppColors.blueColor,
//                           label: "",
//                           icon: Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: index == 1 ? Colors.white : Colors.transparent,
//                             ),
//                             child: Icon(
//                               CupertinoIcons.rectangle_grid_2x2,
//                               color:
//                               index == 1 ? AppColors.blueColor : Colors.white,
//                             ),
//                           ),
//                         ),
//                         BottomNavigationBarItem(
//                           backgroundColor: AppColors.blueColor,
//                           label: "",
//                           icon: Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: index == 2 ? Colors.white : Colors.transparent,
//                             ),
//                             child: Icon(
//                               CupertinoIcons.heart,
//                               color:
//                               index == 2 ? AppColors.blueColor : Colors.white,
//                             ),
//                           ),
//                         ),
//                         BottomNavigationBarItem(
//                           backgroundColor: AppColors.blueColor,
//                           label: "",
//                           icon: Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: index == 3 ? Colors.white : Colors.transparent,
//                             ),
//                             child: Icon(
//                               CupertinoIcons.person,
//                               color:
//                               index == 3 ? AppColors.blueColor : Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswaq_app/core/api/api_manager.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/repositories/home_tab_repo_impl.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/add_product_to_whishlist_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/add_to_cart_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/categories_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/get_whishlist_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/remove_product_from_whishlist_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/presentation/manager/home_bloc.dart';
import 'package:taswaq_app/features/tabs/products_tab/presentation/pages/products_list_screen.dart';
import 'package:taswaq_app/core/utils/app_colors.dart';
import 'package:taswaq_app/features/tabs/home_tab/presentation/pages/home_screen.dart';
import 'package:taswaq_app/features/tabs/wishlist_tab/presentation/pages/whislist_screen.dart';
import 'home_tab/data/data_sources/home_tab_remote_ds_impl.dart';
import 'home_tab/domain/use_cases/products_list_usecase.dart';
import 'settings_tab/presentation/pages/settings_screen.dart';

class HomeLayout extends StatefulWidget {
  final UserModel? userData;

  const HomeLayout({required this.userData, super.key});

  @override
  State<HomeLayout> createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout> {
  List<Widget> screens = [];
  final ValueNotifier<int> index = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(),
      ProductsListScreen(),
      WhishListScreen(),
      SettingsScreen(userData: widget.userData),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            ProductsListUseCase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
            CategoriesUseCase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
            GetWhishlistUsecase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
            AddProductToWhishlistUsecase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
            RemoveProductFromWhishlistUsecase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
            AddToCartUsecase(HomeTabRepoImp(HomeTabRemoteDsImpl(ApiManager()))),
          )
            ..add(FetchProductListEvent())
            ..add(FetchCategoriesEvent())
            ..add(FetchWhishlistEvent()),
        ),
      ],
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.homeState == HomeStates.loading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const AlertDialog(
                title: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          } else if (state.homeState == HomeStates.success) {
            Navigator.pop(context);
          } else if (state.homeState == HomeStates.error) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Error", style: TextStyle(fontSize: 18)),
                elevation: 0,
                content: SizedBox(
                  height: 450,
                  child: Column(
                    children: [
                      Text(
                        state.productFailure?.message ?? "unknown error occurred",
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
          return Scaffold(
            extendBody: true,
            body: ValueListenableBuilder<int>(
              valueListenable: index,
              builder: (context, currentIndex, child) => screens[currentIndex],
            ),
            bottomNavigationBar: ValueListenableBuilder(
              valueListenable: index,
              builder: (context, currentIndex, child) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 0,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: BottomNavigationBar(
                      currentIndex: currentIndex, // Add this line
                      type: BottomNavigationBarType.shifting,
                      onTap: (value) {
                        // Fix: Update the ValueNotifier properly
                        index.value = value;
                      },
                      items: [
                        BottomNavigationBarItem(
                          backgroundColor: AppColors.blueColor,
                          label: "",
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 0 ? Colors.white : Colors.transparent,
                            ),
                            child: Icon(
                              CupertinoIcons.home,
                              color: currentIndex == 0 ? AppColors.blueColor : Colors.white,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          backgroundColor: AppColors.blueColor,
                          label: "",
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 1 ? Colors.white : Colors.transparent,
                            ),
                            child: Icon(
                              CupertinoIcons.rectangle_grid_2x2,
                              color: currentIndex == 1 ? AppColors.blueColor : Colors.white,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          backgroundColor: AppColors.blueColor,
                          label: "",
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 2 ? Colors.white : Colors.transparent,
                            ),
                            child: Icon(
                              CupertinoIcons.heart,
                              color: currentIndex == 2 ? AppColors.blueColor : Colors.white,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          backgroundColor: AppColors.blueColor,
                          label: "",
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 3 ? Colors.white : Colors.transparent,
                            ),
                            child: Icon(
                              CupertinoIcons.person,
                              color: currentIndex == 3 ? AppColors.blueColor : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}