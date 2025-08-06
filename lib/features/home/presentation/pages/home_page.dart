import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/core/theme/app_text_styles.dart';
import 'package:guruh2/core/theme/theme_provider.dart';
import 'package:guruh2/features/home/data/planet_model.dart';
import 'package:guruh2/features/home/presentation/cubit/home_cubit.dart';
import 'package:guruh2/services/notification_service.dart';
import 'package:shimmer_ai/shimmer_ai.dart';

class HomePage extends StatefulWidget {
  final bool title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await NotificationService().initialize(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      context.read<HomeCubit>().loadHomeData(userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

            // print(await _firebaseMessaging.getToken());
          },
          child: context.watch<ThemeProvider>().isDark
              ? const Icon(
                  Icons.sunny,
                  color: Colors.yellow,
                )
              : const Icon(
                  Icons.star,
                  color: Colors.white,
                )),
      appBar: AppBar(
        title: Text(widget.title.toString()),
      ),
      body: userId == null
          ? const Center(
              child: Text(
                'User not found',
                style: TextStyle(fontSize: 40.0),
              ),
            )
          : BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Container(height: 200, width: 400, color: Colors.red)
                      .withShimmerAi(
                    loading: true,
                  );
                }
                if (state is HomeLoaded) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 24.0);
                    },
                    itemCount: state.planets.length,
                    itemBuilder: (context, index) {
                      final planet = state.planets[index];
                      return PlanetCard(
                        planet: planet,
                        userId: userId!,
                        isLiked:
                            state.favorites.any((fav) => fav.id == planet.id),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
    );
  }
}

class PlanetCard extends StatelessWidget {
  const PlanetCard({
    super.key,
    required this.planet,
    required this.userId,
    required this.isLiked,
  });

  final String userId;
  final PlanetModel planet;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                planet.image,
                height: 60,
                width: 60,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          planet.name,
                          style: AppTextStyles.h3.copyWith(
                            color: const Color(0xFF11DCE8),
                          ),
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            final isLoading = state is HomeLoaded &&
                                state.loadingPlanetId == planet.id;
                            return IconButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      context
                                          .read<HomeCubit>()
                                          .toggleFavorite(userId, planet);
                                    },
                              icon: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: isLiked
                                          ? Colors.redAccent
                                          : Colors.grey,
                                    ),
                            );
                          },
                        )
                      ],
                    ),
                    Text(planet.bio, style: AppTextStyles.whiteLabel)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const CustomContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: .2),
        ),
      ),
      padding: padding ??
          const EdgeInsets.only(
            left: 26.0,
            top: 23.0,
            right: 23.0,
            bottom: 19.0,
          ),
      child: child,
    );
  }
}
