import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_colors.dart';

class ZupSteppedLoadingStep {
  /// Build an instance for adding a loading step on [ZupSteppedLoading]
  const ZupSteppedLoadingStep({required this.title, this.description, this.icon, this.iconSize = 100.0});

  /// The title of the step to display
  final String title;

  /// An optional description of the step
  final String? description;

  /// An optional icon of the step
  final Widget? icon;

  /// the size of the passed icon, defaults to 100
  final double? iconSize;
}

class ZupSteppedLoading extends StatefulWidget {
  /// Display a loading with a list of steps for the loading (e.g Preparing, Scanning, Fetching)
  /// with title, description, icons, etc... to make the user more comfortable with longer loading times.
  ///
  /// Is very useful if the loading time can be higher than expected for the user, and you want
  /// make the loading more distractive for the user
  const ZupSteppedLoading({
    super.key,
    required this.steps,
    this.stepDuration = const Duration(seconds: 5),
    this.constraints = const BoxConstraints(maxWidth: 400),
  });

  /// List of steps to display while the loading is in progress.
  ///
  /// The last step is the one that will remain active on the screen if the loading is still in progress
  /// but all the step has already been displayed
  final List<ZupSteppedLoadingStep> steps;

  /// The duration that each step should remain on the screen. After this duration, it will
  /// animate to the next step. Defaults to 5 seconds
  final Duration stepDuration;

  /// the constraints of the whole widget. Defaults to a max width of 400
  final BoxConstraints constraints;

  @override
  State<ZupSteppedLoading> createState() => ZupSteppedLoadingState();
}

class ZupSteppedLoadingState extends State<ZupSteppedLoading> {
  late ZupSteppedLoadingStep _currentStep = widget.steps.first;
  late final PageController _pageController = PageController();
  late final ZupPeriodicTask _periodicTask = ZupPeriodicTask(duration: widget.stepDuration);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _periodicTask.register(() async {
        if (_currentStep.equals(widget.steps.last) || !mounted) return _periodicTask.unregister();

        setState(() => _currentStep = widget.steps[_pageController.page!.toInt() + 1]);
        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _periodicTask.unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: widget.constraints,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_currentStep.icon != null) ...[
            SizedBox(
              width: _currentStep.iconSize,
              height: _currentStep.iconSize,
              child: PageView(
                clipBehavior: Clip.none,
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  widget.steps.length,
                  (index) => SizedBox(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: widget.steps[index].icon,
                    ).animate(
                      onComplete: (controller) => controller.repeat(reverse: true),
                      effects: [
                        const MoveEffect(
                          curve: Curves.decelerate,
                          duration: Duration(milliseconds: 500),
                          begin: Offset(0, 10),
                          end: Offset(0, 0),
                        ),
                      ],
                    ).animate(effects: [
                      if (index != widget.steps.length - 1)
                        FadeEffect(
                          delay: widget.stepDuration,
                          curve: Curves.fastOutSlowIn,
                          begin: 1,
                          end: 0,
                        ),
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          Text(_currentStep.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          if (_currentStep.description != null)
            Text(
              _currentStep.description!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: ZupColors.gray),
            ),
        ],
      ),
    );
  }
}
