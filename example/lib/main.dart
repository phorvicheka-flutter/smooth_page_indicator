import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

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

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => _onPopInvoked(didPop),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                axisDirection: Axis.horizontal,
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
                  inActiveColorOverride: (index) =>
                      index > (controller.page ?? 0)
                          ? Color(0xFFD2D7DE)
                          : Color(0xFF0149DC),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index];
                  },
                  pageSnapping: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPopInvoked(bool didPop) async {
    if (didPop) {
      return; // Proceed with default pop behavior if necessary
    }

    // Show bottom sheet when the back button is pressed
    await showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.white, // Set background color here
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => _buildBottomSheetContent(context, () {
        // Handle Confirm action here
        Navigator.of(context).pop(); // Close bottom sheet
        _handleConfirmAction();
      }),
    );
  }

  void _handleConfirmAction() {
    // Add your confirmation logic here
    print('Confirm button pressed');
    // For example, you might navigate to another page or show a dialog
  }

  Widget _buildBottomSheetContent(
      BuildContext context, VoidCallback onConfirm) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width *
            0.9, // Width 90% of screen width
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              height: 96.50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/92x96"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Text(
              '아직 설문이 완료되지 않았어요.\n\n지금 설문을 종료하면\n처음부터 다시 시작해야 해요.\n정말 설문을 나가시겠어요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w400,
                height: 1.5, // Adjusted height for better readability
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Dismiss the bottom sheet
                  // Handle Cancel action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF0149DC),
                  side: BorderSide(width: 1.50, color: Color(0xFF0149DC)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  minimumSize: Size(140, 49),
                ),
                child: Text(
                  '취소',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Dismiss the bottom sheet
                  onConfirm(); // Execute the confirm action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0149DC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  minimumSize: Size(140, 49),
                ),
                child: Text(
                  '확인',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
