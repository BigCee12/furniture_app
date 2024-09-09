import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_app/home_screen.dart';
import 'package:furniture_app/models/store_item_model.dart';
import 'package:furniture_app/utilities/app_textstyle.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreDetails extends HookConsumerWidget {
  final StoreItemModel storeItem;
  final int index;
  StoreDetails(this.storeItem, this.index, {super.key});

  final List<Color> colors = [
    Colors.pink[50]!,
    Colors.amber[100]!,
    Colors.cyan[100]!,
    Colors.purple[200]!,
    Colors.blue[900]!,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColorIndex = useState(0);
    final isFavorite = ref.watch(isFavoriteNotifierProvider)[index] ?? false;
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    final screenSize = MediaQuery.of(context).size;

    // Define animations for different widgets
    final imageScaleAnimation =
        Tween<double>(begin: -0.4, end: 1.0).animate(animationController);
    final fadeAnimation =
        Tween<double>(begin: -2.4, end: 1.0).animate(animationController);
    final slideAnimation =
        Tween<Offset>(begin: const Offset(0.3, 1.5), end: Offset.zero)
            .animate(animationController);

    // Start the animation on widget build
    useEffect(() {
      animationController.forward();
      return null;
    }, []);

    // State variables to track rotation on the X and Y axes
    final rotationX = useState(0.0);
    final rotationY = useState(0.0);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.grey[200],
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop(_createReturnRoute());
              },
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Product Image with Rotation
              // Product Image with Rotation and Shadow Effect
              GestureDetector(
                onPanUpdate: (details) {
                  // Allow rotation only on the Y-axis (left/right), limit rotation on X-axis (up/down)
                  rotationY.value +=
                      details.delta.dx * 0.005; // Adjust rotation speed
                  // Clamp X-axis rotation to a small range to avoid flipping
                  rotationX.value = (rotationX.value + details.delta.dy * 0.005)
                      .clamp(-0.1, 0.1);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Shadow behind the image, follows the tilt
                    SlideTransition(
                      position: slideAnimation,
                      child: Positioned(
                        top: 20,
                        bottom: 0,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.005)
                            ..rotateX(rotationX.value)
                            ..rotateY(rotationY.value),
                          child: Container(
                            width:
                                260, // Slightly larger than image for shadow effect
                            height: 260,
                            decoration: BoxDecoration(
                              color: Colors.black
                                  .withOpacity(0.04), // Semi-transparent shadow
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: Offset(rotationY.value * 20,
                                      rotationX.value * 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Product Image with Rotation
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // Perspective effect
                        ..rotateX(rotationX.value) // Controlled tilt (up/down)
                        ..rotateY(rotationY
                            .value), // Controlled rotation (left/right)
                      child: SlideTransition(
                        position: slideAnimation,
                        child: Hero(
                          tag: 'image-${storeItem.name}',
                          child: Image.asset(
                            storeItem.imagePath,
                            filterQuality: FilterQuality.high,
                            height: 250, // Image size
                            width: 250,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Product Details Card
              ScaleTransition(
                scale: imageScaleAnimation,
                child: SizedBox(
                  width: screenSize.width * 0.9,
                  child: Card(
                    margin: const EdgeInsets.all(16.0),
                    color: Colors.grey[100],
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(storeItem.name, style: medium14(context)),
                              const Spacer(),
                              Icon(
                                Icons.share,
                                size: 30,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "${storeItem.price.toString()}\$",
                                style: medium18(context).copyWith(
                                  fontSize: 24, // Reduced font size
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${storeItem.slashedPrice.toString()}\$",
                                style: medium11(context).copyWith(
                                  fontSize: 12, // Reduced font size
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const Spacer(),
                              Icon(Icons.star_half_outlined,
                                  color: Colors.amber[400]),
                              const SizedBox(width: 3),
                              Text(
                                storeItem.starRating,
                                style: medium11(context).copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Color Picker
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              ScaleTransition(
                scale: imageScaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("COLOR", style: medium16(context))),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: [
                          for (int i = 0; i < colors.length; i++)
                            GestureDetector(
                              onTap: () {
                                selectedColorIndex.value = i;
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors[i],
                                  border: Border.all(
                                    color: selectedColorIndex.value == i
                                        ? Colors.black.withOpacity(0.7)
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: selectedColorIndex.value == i
                                    ? const Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              // Product Description
              FadeTransition(
                opacity: fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("DETAILS", style: medium16(context)),
                      const SizedBox(height: 10),
                      Text(
                        storeItem.description ?? "No description available",
                        style: medium15(context).copyWith(
                          color: Colors.grey[900]!.withOpacity(0.67),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.07),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(isFavoriteNotifierProvider.notifier)
                            .toggleFavorite(index);
                      },
                      child: SlideTransition(
                        position: slideAnimation,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: isFavorite
                              ? Icon(Icons.favorite,
                                  color: Colors.black.withOpacity(0.7))
                              : const Icon(Icons.favorite_border),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ScaleTransition(
                        scale: imageScaleAnimation,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.5),
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "ADD TO MY CART",
                            style: medium16(context).copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Route _createReturnRoute() {
    return PageRouteBuilder(
      transitionDuration:
          const Duration(seconds: 4), // Increase transition duration
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeIn; // Smooth easing both ways

        // var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        //   CurvedAnimation(parent: animation, curve: curve),
        // );

        var scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: curve),
        );

        // var rotationAnimation = Tween(begin: 0.0, end: 0.05)
        //     .chain(CurveTween(curve: Curves.easeOut))
        //     .animate(animation);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }
}
