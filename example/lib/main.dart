import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: public_member_api_docs
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Page Indicator Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                height: 280,
                child: Center(
                    child: Text(
                  "Page $index",
                  style: TextStyle(color: Colors.indigo),
                )),
              ),
            ));

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            SmoothPageIndicator(
              controller: controller,
              count: 6,
              axisDirection: Axis.horizontal,
              /* effect: SlideEffect(
                spacing: 4.0,
                radius: 10.0,
                dotWidth: 40.0,
                dotHeight: 4.0,
                paintStyle: PaintingStyle.fill,
                strokeWidth: 1.5,
                dotColor: Color(0xFFD2D7DE),
                activeDotColor: Color(0xFF0149DC),
              ), */
              effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                  width: 40,
                  height: 4,
                  color: Color(0xFF0149DC),
                  borderRadius: BorderRadius.circular(10),
                ),
                dotDecoration: DotDecoration(
                  width: 40,
                  height: 4,
                  color: Color(0xFFD2D7DE),
                  borderRadius: BorderRadius.circular(10),
                ),
                spacing: 4.0,
                inActiveColorOverride: (index) => index > (controller.page ?? 0)
                    ? Color(0xFFD2D7DE)
                    : Color(0xFF0149DC),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
                pageSnapping: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
