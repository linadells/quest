import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/location.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';

class EditLocation extends StatefulWidget {
  LocationModel locationModel;

  EditLocation(this.locationModel, {super.key});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();

    _locationController =
        TextEditingController(text: widget.locationModel.location);
  }

  @override
  void dispose() {
     _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            margin: const EdgeInsets.all(3),
            child: TextField(
              controller: _locationController,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).pop();
              LocationModel newLocationModel =
                  LocationModel(location: _locationController.text);
              BlocProvider.of<CreateQuestBloc>(context).add(
                  FinishEditLocationEvent(
                      oldLocationModel: widget.locationModel,
                      locationModel: newLocationModel));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                'Submit',
                style: AppThemes.lightTheme.textTheme.bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
