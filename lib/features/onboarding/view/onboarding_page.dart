import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guruh2/core/constants/app_colors.dart';
import 'package:guruh2/features/home/view/home_page.dart';
import 'package:guruh2/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:guruh2/widgets/my_buttons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<_Details> details = [
    const _Details(
      image: Colors.red,
      title: 'Now reading books will be easier',
      description:
          'Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.',
    ),
    const _Details(
      image: Colors.blue,
      title: 'Your Bookish Soulmate Awaits',
      description:
          'Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.',
    ),
    const _Details(
      image: Colors.amber,
      title: 'Start Your Adventure',
      description:
          'Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let\'s go!',
    ),
  ];
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final lastPage = details.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<OnboardingCubit, int>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      if (state != lastPage) {
                        controller.animateToPage(
                          lastPage,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary500,
                    ),
                    child: const Text('Skip'),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: controller,
                      itemCount: details.length,
                      onPageChanged:
                          context.read<OnboardingCubit>().onPageChanged,
                      itemBuilder: (context, index) {
                        final detail = details[index];
                        return Column(
                          children: [
                            Container(
                              height: 320,
                              width: double.infinity,
                              color: detail.image,
                            ),
                            const SizedBox(height: 30.0),
                            SizedBox(
                              width: 243,
                              child: Text(
                                detail.title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                              width: 292,
                              child: Text(
                                detail.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.grey500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: details.length,
                      effect: const JumpingDotEffect(
                        dotHeight: 10.0,
                        dotWidth: 10.0,
                        verticalOffset: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  PrimaryButton(
                    title: state == lastPage ? 'Get Started' : 'Continue',
                    onPressed: () {
                      if (state < lastPage) {
                        controller.nextPage(
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    },
                  ),
                  SecondaryButton(
                    title: 'Sign In',
                    onPressed: () {
                      print('Skip');
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Details {
  final Color image;
  final String title;
  final String description;

  const _Details({
    required this.image,
    required this.title,
    required this.description,
  });
}
