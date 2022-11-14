
  class _SomeWidgetState extends State<_SomeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
 @override
  void initState() {
    super.initState();
      _controller = AnimationController(
        duration:Duration(seconds: 3),
        vsync: this,
        home: HomeScreen(
        body:center(
          ListTile(
            leading: LoadingAnimationWidget.inkDrop(
            color: Color.fromARGB(255, 26, 153, 68),
            size: 50,
            ),
          )
        ),
      );
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  }