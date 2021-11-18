import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum ScrollEventType {
  SCROLLED_FORWARD,
  SCROLLED_BACKWARDS,
  NO_SCROLL_THRESHOLD,
  NO_SCROLL_END_OF_LIST,
  NO_SCROLL_START_OF_LIST,
}

typedef void ScrollEventCallback(ScrollEventType type, {int currentIndex});

class GrubSwipeFullPageScroller extends StatefulWidget {
  const GrubSwipeFullPageScroller({
    @required this.contentSize,
    @required this.builder,
    this.swipePositionThreshold = 0.20,
    this.swipeVelocityThreshold = 1000,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onScrollEvent, this.cardIndex = 0
  });

  /// The number of elements in the list,
  final int contentSize;

  /// A function that converts a context and an index to a Widget to be rendered
  final IndexedWidgetBuilder builder;

  /// The fraction of the screen scrolled (before lifting your finger) that will
  /// cause the card to animate to the next/previous card (otherwise the card
  /// will animate to the current card's resting position),
  final double swipePositionThreshold;

  /// This threshold will override [swipePositionThreshold] if the card is
  /// flicked a small distance but quickly,
  final double swipeVelocityThreshold;

  /// The time the card will take to animate to either off the screen or its
  /// resting position,
  final Duration animationDuration;

  /// An optional callback to be notified of different scroll events
  final ScrollEventCallback onScrollEvent;

  final int cardIndex;

  @override
  _GrubSwipeFullPageScrollerState createState() =>
      _GrubSwipeFullPageScrollerState();
}

class _GrubSwipeFullPageScrollerState
    extends State<GrubSwipeFullPageScroller>
    with SingleTickerProviderStateMixin {
  Size _containerSize;
  double _cardOffset;
  double _dragStartPosition;
  AnimationController _animationController;
  Animation<double> _animation;
  int _cardIndex = 0;
  DragState _dragState;

  @override
  void initState() {
    _cardOffset = 0;
    _dragStartPosition = 0;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    print(' widget card index is ${widget.cardIndex}');
    if(widget.cardIndex == 0 || widget.cardIndex == null) {
      _cardIndex = 0;
    } else {
      _cardIndex = widget.cardIndex;
    }
    _dragState = DragState.idle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('card index is ${_cardIndex}');
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          /// Takes the size of the container, not the whole screen size
          _containerSize = constraints.biggest;
          return Stack(
            children: <Widget>[
              if (_cardIndex > 0)
                Positioned(
                  bottom: _containerSize.height - _cardOffset,
                  child: SizedBox.fromSize(
                      size: _containerSize,
                      child: widget.builder(context, _cardIndex - 1)),
                ),
              Positioned(
                top: _cardOffset,
                child: GestureDetector(
                  child: SizedBox.fromSize(
                      size: _containerSize,
                      child: widget.builder(context, _cardIndex)),
                  onVerticalDragStart: (DragStartDetails details) {
                    setState(() {
                      _dragState = DragState.dragging;
                      _dragStartPosition = details.localPosition.dy;
                    });
                  },
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    setState(() {
                      _cardOffset = details.localPosition.dy - _dragStartPosition;
                    });
                  },
                  onVerticalDragEnd: (DragEndDetails details) {
                    bool positiveDragThresholdMet = (_cardOffset <
                        -_containerSize.height *
                            widget.swipePositionThreshold ||
                        details.primaryVelocity < -widget.swipeVelocityThreshold);

                    bool negativeDragThresholdMet = (_cardOffset >
                        _containerSize.height / widget.swipePositionThreshold ||
                        details.primaryVelocity > widget.swipeVelocityThreshold);

                    DragState _state;
                    // If the length of scroll goes beyond the point of no return
                    // or if a small flick was faster than the velocity threshold
                    if (positiveDragThresholdMet &&
                        _cardIndex < widget.contentSize - 1) {
                      // build animation, set state to animate forward
                      // Animate to next card
                      _state = DragState.animatingForward;
                    } else if (negativeDragThresholdMet) {
                      if (_cardIndex == 0) {
                        // we are trying to swipe back beyond the first card, if callback exists, call it
                        widget.onScrollEvent?.call(
                            ScrollEventType.NO_SCROLL_START_OF_LIST,
                            currentIndex: 0);
                        _state = DragState.animatingToCancel;
                      } else {
                        // if we are not on the first card and swiping back
                        // Animate to previous card
                        _state = DragState.animatingBackward;
                      }
                    } else if (positiveDragThresholdMet &&
                        _cardIndex == widget.contentSize - 1) {
                      widget.onScrollEvent?.call(
                          ScrollEventType.NO_SCROLL_END_OF_LIST,
                          currentIndex: widget.contentSize - 1);
                      _state = DragState.animatingToCancel;
                    } else {
                      // Thresholds not met so relaxing back to initial state
                      widget.onScrollEvent
                          ?.call(ScrollEventType.NO_SCROLL_THRESHOLD);
                      _state = DragState.animatingToCancel;
                    }
                    setState(() {
                      _dragState = _state;
                    });
                    _createAnimation();
                  },
                ),
              ),
              if (_cardIndex < widget.contentSize - 1)
                Positioned(
                  top: _containerSize.height + _cardOffset,
                  child: SizedBox.fromSize(
                    size: _containerSize,
                    child: widget.builder(context, _cardIndex + 1),
                  ),
                ),
            ],
          );
        });
  }

  void _createAnimation() {
    double _end;
    switch (_dragState) {
      case DragState.animatingForward:
        _end = -_containerSize.height;
        break;
      case DragState.animatingBackward:
        _end = _containerSize.height;
        break;
      case DragState.animatingToCancel:
      default:
        _end = 0;
    }
    _animation = Tween<double>(begin: _cardOffset, end: _end)
        .animate(_animationController)
      ..addListener(_animationListener)
      ..addStatusListener((AnimationStatus _status) {
        switch (_status) {
          case AnimationStatus.completed:
          // change the card index if required,
          // change the offset back to zero,
          // change the drag state back to idle
            int _newCardIndex = _cardIndex;
            // we finished the scroll and updated the card
            switch (_dragState) {
              case DragState.animatingForward:
                _newCardIndex++;
                widget.onScrollEvent?.call(ScrollEventType.SCROLLED_FORWARD,
                    currentIndex: _newCardIndex);
                break;
              case DragState.animatingBackward:
                _newCardIndex--;
                widget.onScrollEvent?.call(
                    ScrollEventType.SCROLLED_BACKWARDS,
                    currentIndex: _newCardIndex);
                break;
              case DragState.animatingToCancel:
              //no change to card index
                break;
              default:
            }

            if (_status != AnimationStatus.dismissed &&
                _status != AnimationStatus.forward) {
              setState(() {
                _cardIndex = _newCardIndex;
                _dragState = DragState.idle;
                _cardOffset = 0;
              });
              _animation.removeListener(_animationListener);
              _animationController.reset();
            }
            break;
          default:
        }
      });
    _animationController.forward();
  }

  void _animationListener() {
    setState(() {
      _cardOffset = _animation.value;
    });
  }
}

enum DragState {
  idle,
  dragging,
  animatingForward,
  animatingBackward,
  animatingToCancel,
}