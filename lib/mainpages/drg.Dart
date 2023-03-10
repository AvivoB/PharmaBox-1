class DraggableBottomSheet extends StatefulWidget {
  @override
  _DraggableBottomSheetState createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  bool _showSheet = false; // whether or not to show the bottom sheet
  double _sheetHeight = 300; // the initial height of the bottom sheet
  double _dragContainerHeight = 50; // the height of the drag container

  // toggles the visibility of the bottom sheet
  void _toggleSheet() {
    setState(() {
      _showSheet = !_showSheet;
      _sheetHeight = _showSheet ? 300 : 0;
    });
  }

  // builds the draggable container that is always visible at the bottom of the screen
  Widget _buildDragContainer() {
    return GestureDetector(
      onTap: _toggleSheet,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _dragContainerHeight,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.grey[600],
            size: 30,
          ),
        ),
      ),
    );
  }

  // builds the content of the bottom
