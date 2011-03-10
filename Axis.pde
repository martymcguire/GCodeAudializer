import ddf.minim.*;
import ddf.minim.signals.*;

public class Axis {
  AudioOutput out;
  Oscillator gen;
  float steps_per_mm;
  float pos;
  float target;
  float feedrate;
  float mm_per_sec;
  float steps_per_sec;
  long last_time = 0;
  
  public Axis (AudioOutput _out, float _steps_per_mm){
    out = _out;
    gen = new TriangleWave(0, 0.2, 44100);
    out.addSignal(gen);
    steps_per_mm = _steps_per_mm;
    pos = 0.0;
    target = 0.0;
    feedrate = 0.0;
    last_time = 0;
  }
  
  public boolean isReady(){
    return pos == target;
  }
  
  public void setPosition(float newpos){
    pos = newpos;
    target = pos;
  }
  
  public float getPosition(){
    return pos;
  }
  
  public void setTarget (float newpos, float _feedrate){
    target = newpos;
    feedrate = _feedrate;
    mm_per_sec = feedrate / 60.0; // mm-per-min
    steps_per_sec = steps_per_mm * mm_per_sec;
    last_time = millis();
  }
  
  public void update (){
    if (this.isAtTarget()){
        gen.setFreq(0);
        pos = target;
    } else {
      gen.setFreq(steps_per_sec);
      long now = millis();
      float moved = (now - last_time) * (mm_per_sec / 1000);
      if(pos < target){
        pos += moved;
        if(pos >= target)
          pos = target;
      } else {
        pos -= moved;
        if(pos <= target)
          pos = target;
      }
      last_time = now;
    }
  }
  
  protected boolean isAtTarget(){
    float ep = 0.001;
    return((pos > target - ep) && (pos < target + ep));
  }
}
