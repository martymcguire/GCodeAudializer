import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
Machine machine;
AudioRecorder recorder;
BufferedReader reader;
String filename = "penny_opener_cut.gcode";

void setup (){
  size(200,200);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO, 4096);
  recorder = minim.createRecorder(out, "g-code.wav", false);
  recorder.beginRecord();
  machine = new Machine(out, 11.767463, 11.767463, 320);
  reader = createReader(filename);
}

void draw(){
  if(machine.isReady()){
    try {
      String line = reader.readLine();
      if(line == null){
        recorder.endRecord();
        recorder.save();
      }
      GCode code = new GCode(line);
      if (code.hasCode('G')) {
        if (code.getCodeValue('G') == 1 && code.hasCode('X')) {
          machine.setTarget(new Float(code.getCodeValue('X')),
                            new Float(code.getCodeValue('Y')),
                            new Float(code.getCodeValue('Z')),
                            new Float(code.getCodeValue('F')));
        }
      }
    } catch (IOException ignored) {}
  }
  machine.update();
}
