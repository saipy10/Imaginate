import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginate/feature/prompt/bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();

  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "✨ Generate Images ✨",
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PromptGeneratingImageLoadState:
              return Center(child: CircularProgressIndicator());

            case PromptGeneratingImageErrorState:
              return Center(child: Text("Something went wrong"));
            case PromptGeneratingImageSuccessState:
              final successState = state as PromptGeneratingImageSuccessState;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(successState.uint8list),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 240,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Enter your prompt",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: controller,
                            cursorColor: Colors.blueAccent,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.lightBlueAccent),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 48,
                            width: double.maxFinite,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blueAccent.shade200)),
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    promptBloc.add(PromptEnteredEvent(
                                        prompt: controller.text));
                                  }
                                },
                                icon: Icon(
                                  Icons.generating_tokens,
                                  color: Colors.lightBlueAccent.shade100,
                                  size: 25,
                                ),
                                label: Text(
                                  "Imaginate",
                                  style: TextStyle(
                                    color: Colors.lightBlueAccent.shade100,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
