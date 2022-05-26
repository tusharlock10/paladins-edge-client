/// Used to track time
class Stopwatch {
  DateTime? _startTime = DateTime.now();
  DateTime? _lastReadTime;

  /// stopwatch start time
  DateTime? get startTime => _startTime;

  /// last read time of stopwatch
  DateTime? get lastReadTime => _lastReadTime;

  /// start tracking time
  /// if timer is already started, doesn't start again
  void start() => _startTime ??= DateTime.now();

  /// measures the time taken since stopwatch started
  /// returns duration in microseconds
  int? measure() {
    _lastReadTime = DateTime.now();

    return _startTime != null
        ? _lastReadTime!.difference(_startTime!).inMicroseconds
        : null;
  }

  /// measures the time taken since the last measurement
  /// if not measured before, returns the time since stopwatch start
  /// returns duration in microseconds
  int? measureLastRead() {
    final timeToRead = _lastReadTime ?? _startTime;
    _lastReadTime = DateTime.now();

    return timeToRead != null
        ? _lastReadTime!.difference(timeToRead).inMicroseconds
        : null;
  }

  /// reset stopwatch to original state
  void reset() {
    _startTime = null;
    _lastReadTime = null;
  }
}
