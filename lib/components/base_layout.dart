import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  const BaseWidget({Key? key, this.title, this.init, required this.hasPadding, required this.body}) : super(key: key);

  final VoidCallback? init;
  final bool hasPadding;
  final Widget body;
  final Widget? title;

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  void initState() {
    if(widget.init != null) {
      widget.init!();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: widget.title != null
        ? AppBar(
          title: widget.title!,
        )
        : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Padding(
                        padding: widget.hasPadding ? const EdgeInsets.all(18.0) : EdgeInsets.zero,
                        child: widget.body,
                      ),
                    ],
                  )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
