public class Machine {
  Axis x;
  Axis y;
  Axis z;
  float max_x_feedrate = 5000;
  float max_y_feedrate = 5000;
  float max_z_feedrate = 150;
  float last_feedrate;
  
  public Machine (AudioOutput out,
                  float x_steps_per_mm,
                  float y_steps_per_mm,
                  float z_steps_per_mm){
    x = new Axis(out, x_steps_per_mm);
    y = new Axis(out, y_steps_per_mm);
    z = new Axis(out, z_steps_per_mm);
  }
  
  public void setTarget(Float tx, Float ty, Float tz, Float f) {
    float cx = x.getPosition();
    float cy = y.getPosition();
    float cz = z.getPosition();
    float nx = cx;
    float ny = cy;
    float nz = cz;
    float fr = last_feedrate;
    if(tx != null)
      nx = tx.floatValue();
    if(ty != null)
      ny = ty.floatValue();
    if(tz != null)
      nz = tz.floatValue();
    if(f != null){
      fr = f;
      last_feedrate = f;
    }
    
    float move_len = sqrt(sq(nx-cx) + sq(ny-cy) + sq(nz-cz));
    float xfr = abs((nx - cx) / move_len) * fr;
    float yfr = abs((ny - cy) / move_len) * fr;
    float zfr = abs((nz - cz) / move_len) * fr;
    x.setTarget(nx, (xfr > max_x_feedrate) ? max_x_feedrate : xfr);
    y.setTarget(ny, (yfr > max_y_feedrate) ? max_y_feedrate : yfr);
    z.setTarget(nz, (zfr > max_z_feedrate) ? max_z_feedrate : zfr);
  }
  
  public void setPosition(Float tx, Float ty, Float tz){
    if(tx != null)
      x.setPosition(tx.floatValue());
    if(ty != null)
      y.setPosition(ty.floatValue());
    if(tz != null)
      z.setPosition(tz.floatValue());
  }
  
  public void update () {
    x.update();
    y.update();
    z.update();
  }
  
  public boolean isReady() {
    return(x.isReady() && y.isReady() && z.isReady());
  }
}
