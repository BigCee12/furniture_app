import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_app/models/store_item_model.dart';
import 'package:furniture_app/store_details.dart';
import 'package:furniture_app/utilities/app_textstyle.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 9 / 14,
        crossAxisCount: 2,
        crossAxisSpacing: 13,
        mainAxisSpacing: 13,
      ),
      itemBuilder: (context, index) {
        final storeItem = itemsList[index];
        return StoreItemCard(
          index,
          storeItem: storeItem,
        );
      },
    );
  }
}

final isFavoriteNotifierProvider =
    StateNotifierProvider<IsFavoriteNotifier, Map<int, bool>>((ref) {
  return IsFavoriteNotifier();
});

class IsFavoriteNotifier extends StateNotifier<Map<int, bool>> {
  IsFavoriteNotifier() : super({});

  void toggleFavorite(int itemId) {
    state = {
      ...state,
      itemId: !(state[itemId] ?? false), // Toggle the favorite status
    };
  }
}

class StoreItemCard extends ConsumerWidget {
  final StoreItemModel storeItem;
  final int index;

  const StoreItemCard(this.index, {super.key, required this.storeItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteNotifierProvider)[index] ?? false;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_createImageRoute(index, storeItem));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: const Offset(0, 6),
              color: Colors.grey[100]!.withOpacity(0.9),
              blurStyle: BlurStyle.outer,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        height: 240,
        width: 200,
        padding: const EdgeInsets.fromLTRB(8, 8, 14, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    ref
                        .read(isFavoriteNotifierProvider.notifier)
                        .toggleFavorite(index);
                  },
                  child: isFavorite
                      ? Icon(Icons.favorite,
                          color: Colors.grey.withOpacity(0.9))
                      : const Icon(Icons.favorite_border),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Hero(
              tag: 'image-${storeItem.name}',
              child: Image.asset(
                storeItem.imagePath,
                filterQuality: FilterQuality.high,
                height: 140,
                width: 140,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              storeItem.name,
              style: medium13(context),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${storeItem.price}\$",
                    style: medium18(context).copyWith(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    storeItem.slashedPrice,
                    style: medium11(context).copyWith(
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star_half_outlined,
                    color: Colors.amber[400],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    storeItem.starRating,
                    style: medium11(context).copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Create a custom route for the page transition
Route _createImageRoute(int index, StoreItemModel storeItem) {
  return PageRouteBuilder(
    transitionDuration: const Duration(seconds: 1), // Slow down the transition
    pageBuilder: (context, animation, secondaryAnimation) => StoreDetails(
      storeItem,
      index,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Define the animation curve for rotation and slowing down
      // const begin = 0.0;
      // const end = 1.0;
      const curve = Curves.easeInOut; // Smooth slow transition

      // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      // var rotationAnimation = animation.drive(tween);
      var scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: curve),
      );
      return ScaleTransition(
        scale: scaleAnimation, // Apply the rotation effect
        child: child,
      );
    },
  );
}
