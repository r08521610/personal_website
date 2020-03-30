import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:personal_website/models/project.dart';
import 'package:personal_website/util.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key key,
    this.project
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              project.name,
              style: Theme.of(context).textTheme.headline6.apply(
                color: Theme.of(context).primaryColor
              )
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              project.description,
              style: Theme.of(context).textTheme.bodyText1
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Tooltip(
                message: project.url != null ? project.url : 'Private Project',
                child: FlatButton.icon(
                  label: Text('前往專案'),
                  icon: Icon(_getIcon()),
                  
                  onPressed: project.url != null ? () => launchURL(project.url) : null
                ),
              ),
              if (project is FrontendProject) () {
                final frontendProject = project as FrontendProject;
                final deployUrl = frontendProject.deployUrl;
                if (deployUrl != null) return FlatButton.icon(
                  icon: Icon(Icons.web), 
                  label: Text('Demo'),
                  onPressed: deployUrl != null ? () => launchURL(deployUrl) : null
                );
              }()
            ],
          ),
        ]
      ),
    )
  );

  IconData _getIcon() {
    if (project is CodepenProject) return BrandIcons.codepen;
    return Icons.code;
  }
}