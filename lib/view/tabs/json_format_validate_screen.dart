import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pretty_json/pretty_json.dart';

class JsonFormatValidateScreen extends StatefulWidget {
  const JsonFormatValidateScreen({Key? key}) : super(key: key);

  @override
  State<JsonFormatValidateScreen> createState() =>
      _JsonFormatValidateScreenState();
}

class _JsonFormatValidateScreenState extends State<JsonFormatValidateScreen> {
  final _inputTextController = TextEditingController();
  final _outputTextController = TextEditingController();

  void _formatJson(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        _outputTextController.text = '';
      });
      return;
    }
    try {
      final decoded = jsonDecode(value);
      final prettyString = prettyJson(decoded, indent: 2);
      setState(() {
        _outputTextController.text = prettyString;
      });
    } catch (e) {
      setState(() {
        _outputTextController.text = 'Invalid JSON: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
        toolBar: ToolBar(
          title: const Text('JSON Format / Validate'),
          titleWidth: 200.0,
        ),
        children: [
          ContentArea(
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Input:'),
                        const SizedBox(width: 10),
                        PushButton(
                          controlSize: ControlSize.small,
                          child: const Text('Clipboard'),
                          onPressed: () {
                            FlutterClipboard.paste().then((value) {
                              _inputTextController.text = value;
                              _formatJson(value);
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        PushButton(
                          controlSize: ControlSize.small,
                          child: const Text('Clear'),
                          onPressed: () {
                            setState(() {
                              _inputTextController.clear();
                              _outputTextController.clear();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    MacosTextField(
                      controller: _inputTextController,
                      onChanged: _formatJson,
                      maxLines: 15,
                      minLines: 10,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text('Output:'),
                        const SizedBox(width: 10),
                        PushButton(
                          controlSize: ControlSize.small,
                          child: const Text('Copy'),
                          onPressed: () {
                            if (_outputTextController.text.isNotEmpty) {
                              FlutterClipboard.copy(_outputTextController.text);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    MacosTextField(
                      controller: _outputTextController,
                      maxLines: 15,
                      minLines: 10,
                      readOnly: true,
                    ),
                  ],
                ),
              );
            },
          ),
        ]);
  }

  @override
  void dispose() {
    _inputTextController.dispose();
    _outputTextController.dispose();
    super.dispose();
  }
}
