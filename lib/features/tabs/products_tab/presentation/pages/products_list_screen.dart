import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/tabs/products_tab/presentation/widgets/view_of_tabbar.dart';
import '../../../../../config/routes/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../home_tab/presentation/manager/home_bloc.dart';
import '../widgets/product_list_item.dart';
import '../widgets/vertical_tab.dart';
import '../widgets/vertical_tab_unselected.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  int selectedindex = 0;
  bool showGridView = false;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        showGridView = false;
      });
    }
  }
  // Method to extract unique categories from the actual product data
  List<String> getUniqueCategories(List<dynamic>? allProducts) {
    if (allProducts == null || allProducts.isEmpty) return [];

    Set<String> uniqueCategories = {};

    for (var product in allProducts) {
      // Extract category name from the product data structure
      String? categoryName = product.category?.name ?? product.category?.title ?? product.category?.toString() ?? product.categoryName; // adjust based on your actual data structure

      if (categoryName != null && categoryName.isNotEmpty) {
        uniqueCategories.add(categoryName);
      }
    }

    return uniqueCategories.toList();
  }

  // Method to get products for a specific category
  List<dynamic>? getProductsForCategory(String category, List<dynamic>? allProducts) {
    if (allProducts == null) return [];

    return allProducts.where((product) {
      String? productCategory = product.category?.name ??
          product.category?.title ??
          product.category?.toString() ??
          product.categoryName; // adjust based on your actual data structure

      return productCategory == category;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
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
          Navigator.pushNamed(context, AppRoutes.home);
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
        // Extract categories dynamically from the actual product data
        final List<String> categories = getUniqueCategories(state.productListModel?.data);

        return DefaultTabController(
          length: categories.length,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Image.asset(
                  "assets/images/route_logo.png",
                  width: 66,
                  height: 22,
                ),
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
                            color: Color.fromRGBO(6, 0, 79, 0.6),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff004182),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff004182),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.cart);
                      },
                      icon: Icon(
                        CupertinoIcons.shopping_cart,
                        size: 24,
                        color: AppColors.blueColor,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 4),
                    child: showGridView
                        ? GridView.builder(
                      itemBuilder: (context, index) => ProductListItem(
                        productData: state.productListModel?.data?[index],
                        index: index,
                      ),
                      itemCount: state.productListModel?.data?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 8 / 11,
                      ),
                    )
                        : Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0x80dbe4ed),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          width: 137,
                          height: 724,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: TabBar(
                                onTap: (index) {
                                  selectedindex = index;
                                  setState(() {});
                                },
                                indicatorColor: Colors.transparent,
                                tabs: categories.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  String category = entry.value;
                                  return selectedindex == index
                                      ? VerticalTab(widgetTitle: category)
                                      : VerticalTabUnselected(widgetTitle: category);
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0, left: 4),
                            child: TabBarView(
                              children: categories.map((category) {
                                final List<Data>? categoryProducts = getProductsForCategory(
                                    category,
                                    state.productListModel?.data
                                )?.cast<Data>();

                                return InkWell(
                                  onTap: (){
                                    showGridView=true;
                                    setState(() {});
                                  },
                                  child: ViewOfTabbar(
                                    title: category,
                                    products: categoryProducts,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
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