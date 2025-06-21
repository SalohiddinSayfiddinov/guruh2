import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
            ),
            const SizedBox(width: 12.0)
          ],
        ),
        body: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {},
                height: 146.0,
                autoPlay: false,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                autoPlayInterval: const Duration(milliseconds: 1000),
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
              ),
              items: [1, 2, 3, 4, 5].map(
                (e) {
                  return Container(
                    width: 327,
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: Text(
                      e.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTab extends StatelessWidget {
  final String text;
  const MyTab({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    print('Build ishladi');
    return Center(
      child: Text(text),
    );
  }
}
