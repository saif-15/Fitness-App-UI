import 'dart:async';


class Bloc{

  var currentDate=DateTime.now();
  StreamController<DateTime> _controller = StreamController<DateTime>();

  Stream<DateTime> get dateTime => _controller.stream;

  void addDate(){
    currentDate=currentDate.add(Duration(days: 1));
    _controller.sink.add(currentDate);
  }
  void subtractDate(){

    currentDate=currentDate.subtract(Duration(days: 1));
    _controller.sink.add(currentDate);
  }

  void dispose(){
    _controller.close();
  }
}