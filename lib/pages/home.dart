import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_website/components/SocialBar.dart';
import 'package:personal_website/components/bulletList.dart';
import 'package:personal_website/components/skillCard.dart';
import 'package:personal_website/components/timeline.dart';
import 'package:personal_website/layouts/default.dart';
import 'package:personal_website/models/event.dart';
import 'package:personal_website/models/skill.dart';
import 'package:personal_website/responsive.dart';
import 'package:personal_website/routes/route_handlers.dart';
import 'package:personal_website/routes/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? controller;
  ScrollController? horizontalScrollController;
  ScrollController? verticalScrollController;

  bool isEdge = false;

  @override
  Widget build(BuildContext context) {
    final routesNotifier = Provider.of<Routes>(context);
    controller = PageController(initialPage: 0, keepPage: true);
    horizontalScrollController = ScrollController();
    verticalScrollController = ScrollController();
    // horizontalScrollController.addListener(_handleHorizontalScroll);
    // verticalScrollController.addListener(_handleVerticalScroll);

    final _getProfileWidget = (MainAxisAlignment mainAxisAlignment,
            CrossAxisAlignment crossAxisAlignment) =>
        Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            Hero(
              tag: 'profile_name',
              child: Text('鄭羽霖',
                  style: Theme.of(context).textTheme.headline2?.apply(
                        color: Theme.of(context).primaryColor,
                      )),
            ),
            Hero(
              tag: 'profile_job_title',
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('研究生＠台大土木電腦輔助工程組\nSpecialize in ML/DL, Frontend',
                    style: Theme.of(context).textTheme.subtitle1?.apply(
                        color: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .color!
                            .withAlpha(150))),
              ),
            ),
            Hero(
              tag: 'profile_description',
              child: BulletList(
                texts: [
                  '熱衷學習、使用各種前端框架開發',
                  '注重良好 UI/UX',
                  '質感、美感偏執，希望能參與各種酷炫視覺效果之應用開發'
                ],
                textStyle: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        );

    final profileImage = Hero(
      tag: 'profileImage',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child: Image(
          image: AssetImage('assets/images/profile.JPG'),
          fit: BoxFit.cover,
        ),
      ),
    );

    return DefaultLayout(
        appBar: AppBar(
          title: Text(
            'Rainforest',
            // style: Theme.of(context).textTheme.headline6,
          ),
          actions: <Widget>[
            Flexible(
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.userCircle),
                  onPressed: () => routesNotifier.router.navigateTo(
                      context, '/resume',
                      transition: TransitionType.custom,
                      transitionDuration: Duration(milliseconds: 800),
                      transitionBuilder: route_handlers
                          .firstWhere((route_handler) =>
                              route_handler.path == '/resume')
                          .transitionBuilder)),
            ),
            Flexible(child: Hero(tag: 'socialLinks', child: new SocialBar()))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 20),
          child: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 20),
                child: ResponsiveHelper().isXsmall(context)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipOval(child: profileImage),
                            ),
                          ),
                          Flexible(
                              child: _getProfileWidget(MainAxisAlignment.start,
                                  CrossAxisAlignment.start))
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(child: profileImage),
                          Flexible(
                              child: Transform.translate(
                                  offset: Offset(-100, 0),
                                  child: _getProfileWidget(
                                      MainAxisAlignment.center,
                                      CrossAxisAlignment.start)))
                        ],
                      ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      flex: 2,
                      child: Hero(
                        tag: 'experience',
                        child: Text('經歷',
                            style: Theme.of(context).textTheme.headline3),
                      )),
                  Flexible(
                      child: FractionallySizedBox(
                    heightFactor: 0.2,
                  )),
                  Flexible(
                    flex: 2,
                    child: new Timeline(
                      events: events,
                      controller: horizontalScrollController!,
                      timestampStyle: Theme.of(context).textTheme.subtitle2!,
                      nameStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .apply(color: Theme.of(context).primaryColor),
                      descriptionStyle: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                ],
              ),
              NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    if (scrollNotification.metrics.atEdge &&
                        scrollNotification.metrics.extentBefore.floor() == 0)
                      isEdge = true;
                  } else if (scrollNotification is UserScrollNotification) {
                    if (isEdge &&
                        scrollNotification.direction == ScrollDirection.forward)
                      controller?.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceInOut);
                  } else {
                    isEdge = false;
                  }
                  return false;
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width / 20),
                  child: GridView.builder(
                    controller: verticalScrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper()
                          .valueGiver<int>(context, 1, 1, 3, 4, 5)!,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                    ),
                    itemCount: skills.length,
                    itemBuilder: (_, int index) => SkillCard(
                      skill: skills[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
