import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quest/core/style.dart';
import 'package:quest/domain/entities/location.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';
import 'package:quest/presentation/widgets/quest_creation/display_question.dart';

class ListOfLocations extends StatelessWidget {
  List<LocationEntity>? locations;
  ListOfLocations({this.locations});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'Route:',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      Expanded(
        child: locations?.length!=0
            ? ListView.builder(
                itemCount: locations != null ? locations!.length : 1,
                itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: kStyleForQuestionContainer,
                    child: Text(locations![index].location!)))
            : Center(child: Text('There aren`t any locations')),
      ),
      Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                BlocProvider.of<CreateQuestBloc>(context).add(AddLocationEvent());
              },
              child: Text('Add locations'),
              style: Theme.of(context).textButtonTheme.style?.copyWith(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return kAccent.withOpacity(0.6);
                    } else if (states.contains(MaterialState.hovered)) {
                      return kAccent.withOpacity(0.8);
                    }
                    return kAccent;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
