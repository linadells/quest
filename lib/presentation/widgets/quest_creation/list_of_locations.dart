import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/location.dart';
import 'package:quest/domain/entities/location.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';
import 'package:quest/presentation/widgets/quest_creation/display_question.dart';

class ListOfLocations extends StatelessWidget {
  List<LocationModel>? locations;
  ListOfLocations({super.key, this.locations});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'Route:',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      Expanded(
        child: locations?.length != 0
            ? ListView.builder(
                itemCount: locations != null ? locations!.length : 1,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        BlocProvider.of<CreateQuestBloc>(context)
                            .add(EditLocationEvent(locations![index]));
                      },
                      child: Dismissible(
                        key: Key(locations![index].location!),
                        onDismissed: (direction) {
                          locations!.removeAt(index);
                        },
                        background: Container(
                          color: Colors.redAccent,
                          child: Icon(Icons.delete),
                        ),
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: kStyleForQuestionContainer,
                            child: Text(locations![index].location!)),
                      ),
                    ))
            : const Center(child: Text('There aren`t any locations')),
      ),
      Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                BlocProvider.of<CreateQuestBloc>(context)
                    .add(AddLocationEvent());
              },
              style: Theme.of(context).textButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return kAccent.withOpacity(0.6);
                    } else if (states.contains(WidgetState.hovered)) {
                      return kAccent.withOpacity(0.8);
                    }
                    return kAccent;
                  },
                ),
              ),
              child: Text('Add locations'),
            )
          ],
        ),
      ),
    ]);
  }
}
