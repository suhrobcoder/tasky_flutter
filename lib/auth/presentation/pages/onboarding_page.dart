import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/constants/colors.dart';
import 'package:tasky/core/routes/routes.dart';
import 'package:tasky/global_widgets/buttons.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _controller;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(
      () => setState(() {
        progress = _controller.page ?? 0;
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.65,
            child: PageView(
              controller: _controller,
              children: onboardingModels
                  .map(
                    (model) => OnboardingItem(
                        model.image, model.title, model.body, model.color),
                  )
                  .toList(),
              onPageChanged: (index) {},
            ),
          ),
          Container(
            height: height * 0.35,
            child: Column(
              children: [
                PageIndicator(onboardingModels.length, progress),
                const SizedBox(height: 36),
                const Spacer(),
                PrimaryButton(
                  "Get Started",
                  onboardingModels[progress.round()].color,
                  () {
                    if (_controller.page == onboardingModels.length - 1) {
                      Navigator.popAndPushNamed(context, signInPage);
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
                const Spacer(),
                SecondaryButton(
                  "Skip",
                  () => Navigator.popAndPushNamed(context, signInPage),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem extends StatelessWidget {
  final String image;
  final String titleText;
  final String bodyText;
  final Color color;
  const OnboardingItem(this.image, this.titleText, this.bodyText, this.color,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height * 0.5,
          child: Center(
            child: Image.asset("assets/images/$image.png"),
          ),
        ),
        Text(
          titleText,
          style: TextStyle(color: color, fontSize: 26.0),
        ),
        const SizedBox(height: 8.0),
        Text(
          bodyText,
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OnboardingModel {
  final String image;
  final String title;
  final String body;
  final Color color;

  OnboardingModel(this.image, this.title, this.body, this.color);
}

final onboardingModels = [
  OnboardingModel("onboarding1", "Welcome to Tasky",
      "“The secret of getting ahead\nis getting started.”", onboardingColor1),
  OnboardingModel("onboarding2", "Job done",
      "get notified when tasks are\nfinished", onboardingColor2),
  OnboardingModel("onboarding3", "Tasks assignement", "Check work progress",
      onboardingColor3),
];

class PageIndicatorItem extends StatelessWidget {
  final double progress;
  const PageIndicatorItem(this.progress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0 * (1 + progress),
      height: 8.0,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: progress <= 1
            ? indicatorColor.withAlpha((76 + 179 * progress).round())
            : indicatorColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int count;
  final double progress;
  const PageIndicator(this.count, this.progress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        var itemProgress = (i - progress).abs();
        if (itemProgress > 1) {
          itemProgress = 0;
        } else {
          itemProgress = 1 - itemProgress;
        }
        return PageIndicatorItem(itemProgress);
      }),
    );
  }
}
