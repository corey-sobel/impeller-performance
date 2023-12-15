import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

enum SvgChoice { chestBoth, chestClosedOnly, twemojis }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImpellerExampleScreen(),
    );
  }
}

// testing minimal screen
class ImpellerExampleScreen extends StatefulWidget {
  const ImpellerExampleScreen({
    super.key,
  });

  @override
  State<ImpellerExampleScreen> createState() => _ImpellerExampleScreenState();
}

class _ImpellerExampleScreenState extends State<ImpellerExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return const SeasonalEventScreenContent();
  }
}

class SeasonalEventScreenContent extends StatelessWidget {
  final int initFocusedTier;

  const SeasonalEventScreenContent({
    super.key,
    this.initFocusedTier = 0,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: no_media_query_width
    final double width = MediaQuery.of(context).size.width;
    final double sparklesWidth = width / 3;
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        buildSparkles(sparklesWidth, width),
        buildFakeTiers(),
      ],
    );
  }

  Widget buildBanner() {
    const double width = 400;
    const double height = 250;
    const String bgAssetPath = "assets/svgs/deck.svg";
    return buildSvg(bgAssetPath, width: width, height: height);
  }

  Widget buildFakeTiers() {
    const String chestClosedPath = "assets/svgs/chest-closed.svg";
    const String chestOpenPath = "assets/svgs/chest-open.svg";
    const String sunrisePath = "assets/svgs/sunrise.svg";
    const String trollyPath = "assets/svgs/trolly.svg";
    final String leftSvg, rightSvg;
    // You can toggle this variable to see perf impact of each svg combo.
    // testing with iPhone 15 sim showed impeller perf to be:
    // chestBoth: TODO
    // chestClosedOnly: TODO
    // twemojis: TODO
    const SvgChoice svgChoice = SvgChoice.chestBoth;
    switch (svgChoice) {
      case SvgChoice.chestBoth:
        leftSvg = chestClosedPath;
        rightSvg = chestOpenPath;
        break;
      case SvgChoice.chestClosedOnly:
        leftSvg = chestClosedPath;
        rightSvg = chestClosedPath;
        break;
      case SvgChoice.twemojis:
        leftSvg = sunrisePath;
        rightSvg = trollyPath;
        break;
    }
    final List<Widget> rows = List.generate(
      31,
      (_) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildSvg(leftSvg),
          buildSvg(rightSvg),
        ],
      ),
    );
    return SingleChildScrollView(
      child: Column(
        children: [buildBanner(), ...rows],
      ),
    );
  }

  Widget buildSparkles(double sparklesWidth, double width) {
    return Positioned(
        bottom: 24,
        right: width * 0.1,
        child: Lottie.asset(
          'assets/lottie/sparkles.json',
          width: sparklesWidth,
        ));
  }
}

Widget buildSvg(String path, {double? width, double? height}) {
  final double imageWidth = width ?? 40;
  final double imageHeight = height ?? 40;
  return SizedBox(
    width: imageWidth,
    height: imageHeight,
    child: SvgPicture.asset(
      path,
      placeholderBuilder: (context) {
        return SizedBox(
          height: imageHeight,
          width: imageWidth,
        );
      },
      height: imageHeight,
      width: imageWidth,
      clipBehavior: Clip.none,
    ),
  );
}
