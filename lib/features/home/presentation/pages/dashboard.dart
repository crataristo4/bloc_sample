/// File: dashboard.dart
/// Project: mobile
/// Created Date: Wednesday, May 26th 2021, 6:56:40 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Friday, June 11th 2021 8:20:17 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

part of 'home.dart';

/// dashboard UI
class DashboardTab extends StatefulWidget {
  @override
  _DashboardTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  final _videoCubit = FeaturedVideoCubit();
  final _metricCubit = MetricCubit(localStorage: Injector.get());

  @override
  void dispose() {
    _videoCubit.close();
    _metricCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0))
        .then((_) => _videoCubit.loadVideos(context));
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    return BlocBuilder<FeaturedVideoCubit, BlocState>(
      bloc: _videoCubit,
      builder: (context, videoState) {
        return BlocBuilder<MetricCubit, BlocState>(
          bloc: _metricCubit..getLastMetrics(),
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // metric
                      'Fitness Calculators'
                          .button(
                            context,
                            alignment: TextAlign.start,
                            color: kColorScheme.secondary,
                          )
                          .top(kSpacingX4)
                          .bottom(kSpacingX16)
                          .align(Alignment.centerLeft),
                    ],
                  ),
                ),

                // metric section
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var feature = BaseFeature.kFeatures[index];
                      var stats = '';
                      var statsDesc = 'Tap for more details';
                      if (state is SuccessState<Metric>) {
                        var metric = state.data;
                        if (feature.type == metric.bmi.type) {
                          if (metric.bmi.reading > 0) {
                            stats = metric.bmi.reading.toString();
                            statsDesc = feature.fullName;
                          }
                        }

                        if (feature.type == metric.bmr.type) {
                          if (metric.bmr.reading > 0) {
                            stats = metric.bmr.reading.toString();
                            statsDesc = feature.fullName;
                          }
                        }

                        if (feature.type == metric.waterIntake.type) {
                          if (metric.waterIntake.reading > 0) {
                            stats = metric.waterIntake.reading.toString();
                            statsDesc = 'litres per day';
                          }
                        }

                        if (feature.type == metric.bodyFat.type) {
                          stats = metric.bodyFat.reading.toString();
                          statsDesc = 'calories needed';
                        }
                      }
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: Duration(milliseconds: 150),
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: FeatureTile(
                              feature: feature,
                              stats: stats,
                              statsDesc: statsDesc,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: BaseFeature.kFeatures.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: kSpacingX12,
                    mainAxisSpacing: kSpacingX12,
                    childAspectRatio: 4 / 3,
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // healthy videos section
                      'Healthy Videos'
                          .button(
                            context,
                            alignment: TextAlign.start,
                            color: kColorScheme.secondary,
                          )
                          .top(kSpacingX24)
                          .bottom(kSpacingX16)
                          .align(Alignment.centerLeft),

                      if (videoState
                          is SuccessState<List<BaseFeaturedVideo>>) ...[
                        for (int index = 0;
                            index < videoState.data.length;
                            index++) ...{
                          AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              horizontalOffset: kSpacingX56,
                              duration: Duration(milliseconds: 550),
                              child: FadeInAnimation(
                                child: FeaturedVideoTile(
                                    featuredVideo: videoState.data[index]).bottom(kSpacingX16),
                              ),
                            ),
                          ),
                        },
                      ],

                      if (videoState is ErrorState) ...{
                        'No healthy videos available'
                            .h6(
                              context,
                              color: kColorScheme.secondary,
                              emphasis: kEmphasisMedium,
                            )
                            .centered(),
                      },

                      if (videoState is LoadingState) ...{
                        CircularProgressIndicator.adaptive().centered(),
                      },

                      RoundedButton(
                        label: 'Sign out',
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content:
                                        'Do you wish to sign out of this session? (You will not lose any personal data)'
                                            .bodyText1(context),
                                    title: 'Sign out'.h6(context),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await AuthCubit(
                                                    localStorage:
                                                        Injector.get())
                                                .logOut();
                                            context.router.pushAndPopUntil(
                                                WelcomeRoute(),
                                                predicate: (_) => false);
                                          },
                                          child: 'Yes'.button(context)),
                                      TextButton(
                                          onPressed: () => context.router.pop(),
                                          child: 'Cancel'.button(context)),
                                    ],
                                  ));
                        },
                      ).vertical(kSpacingX24).horizontal(kSpacingX40),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
