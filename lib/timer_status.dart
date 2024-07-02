
class TimerStatus {}

class Checking extends TimerStatus{}

class Counting extends TimerStatus{
  int elapsedTime;
  Counting(this.elapsedTime);
}

class Idle extends TimerStatus {}
