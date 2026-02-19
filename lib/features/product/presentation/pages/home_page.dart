import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecomerce/features/product/presentation/widgets/product_card.dart';
import 'package:ecomerce/features/home/presentation/widgets/home_banner.dart';
import 'package:ecomerce/features/home/presentation/widgets/categories_rail.dart';
import 'package:ecomerce/features/home/presentation/widgets/popular_brands_section.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<ProductBloc>()..add(GetProductsEvent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(GetProductsEvent());
                },
                child: CustomScrollView(
                  slivers: [
                    // 1. App Bar with User Profile & Cart
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      elevation: 0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
                      title: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: ClipOval(
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                "Alex's Garage",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).textTheme.titleLarge?.color,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.grey[700],
                                  size: 20,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // 2. Search Bar
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search parts, brands, VIN...',
                              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.qr_code_scanner, size: 18, color: Colors.grey[600]),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 3. Categories Rail
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: CategoriesRail(),
                      ),
                    ),

                    // 4. Promo Banner
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: HomeBanner(),
                      ),
                    ),

                    // 5. Featured Products Header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Featured Products',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                            Text(
                              'See all',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 6. Featured Products Grid
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = state.products[index];
                            return ProductCard(product: product);
                          },
                          childCount: state.products.length,
                        ),
                      ),
                    ),

                    // 7. Popular Brands
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: PopularBrandsSection(),
                      ),
                    ),
                    
                    // Bottom spacing
                    const SliverToBoxAdapter(child: SizedBox(height: 80)),
                  ],
                ),
              );
            } else if (state is ProductError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<ProductBloc>().add(GetProductsEvent()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
