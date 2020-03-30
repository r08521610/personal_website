import 'package:flutter/material.dart';
import 'package:personal_website/components/projectCard.dart';
import 'package:personal_website/layouts/default.dart';
import 'package:personal_website/models/project.dart';
import 'package:personal_website/responsive.dart';
import 'package:personal_website/routes/routes.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final routesNotifier = Provider.of<Routes>(context);
    return DefaultLayout(
      appBar: AppBar(
        title: Text(
          'Projects'
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveHelper().columns(context, 1, 1, 3, 4, 5),
            mainAxisSpacing: 30,
            crossAxisSpacing: 30
          ), 
          itemCount: projects.length,
          itemBuilder: (_, index) => ProjectCard(project: projects[index])
        ),
      )
    );
  }
}