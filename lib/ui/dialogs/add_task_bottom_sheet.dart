import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class AddTaskBottomSheet extends HookWidget {
  const AddTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final priority = useState(0);

    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets, // для клавиатуры
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: textController,
                decoration: InputDecoration(hintText: 'Add task'),
              ),
              Gap(16),
              // Приоритет (звёзды)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => IconButton(
                    icon: Icon(
                      i < priority.value ? Icons.star : Icons.star_border,
                      color: Colors.red,
                    ),
                    onPressed: () => priority.value = i + 1,
                  ),
                ),
              ),
              Gap(16),
              // Иконки даты, времени и т.д.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.calendar_today),
                  Icon(Icons.access_time),
                  Icon(Icons.notifications),
                  Icon(Icons.attach_file),
                  Icon(Icons.mic),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
