import themidibus.*;
import processing.serial.*;
import org.firmata.*;
import cc.arduino.*;

// Timekeeping
int BPM = 80;
int lastTime = 0;
int pastTime = 0;
int beatCount  = 1;

// Key press
boolean keyDown = false;

// Arduino
Arduino arduino;
String ARDUINO_PORT = "COM3";
//String ARDUINO_PORT = "/dev/tty.usbmodem411";
int potPin = 2;
float potVal = 0;

// MidiBus
MidiBus mb;
String MIDI_PORT_OUT = "Virtual MIDI Bus";
int channel1 = 0;
int channel2 = 1;
int channel3 = 2;
int channel4 = 3;
int velocity = 0;
int pitch = 0;

// Riri Stuff
RiriNote[] notes = new RiriNote[10];
RiriSequence[] sequences = new RiriSequence[10];
RiriMessage[] messages = new RiriMessage[10];
RiriChord[] chords = new RiriChord[10];

void setup() {
  size(400,400);
  stroke(255,255,255);
  // Setup Arduino
  //println(Arduino.list());
  //arduino = new Arduino(this, ARDUINO_PORT, 57600);
  // Setup MidiBus
  MidiBus.list();
  mb = new MidiBus(this, -1, MIDI_PORT_OUT);
  mb.sendTimestamps();

  lastTime = millis();
}

void draw() {
  pastTime = millis() - lastTime;
  // Draw something
  background(0,0,0);
  line(0, mouseY, 400, mouseY);
  line(mouseX, 0, mouseX, 400);
  // Change the sound
  velocity = 100 - (int) (mouseY / 4);
  pitch = (int) (mouseX / 8) + 50;
  // Beat Counter
  if (pastTime > beatsToMils(1)) {
    // Measure Counter
    if (beatCount == 1) {
      // Mark the measure
      fill(125, 125, 125);
      ellipse(mouseX, mouseY, 100, 100);
      // Play something
      createSequence(0, channel2, pitch, velocity);
    }
    // Mark the beat
    fill(250, 250, 250);
    ellipse(mouseX, mouseY, 50, 50);
    // Play something
    RiriNote note = new RiriNote(channel1, pitch, velocity, beatsToMils(1));
    note.start();
    // Update lastTime
    lastTime = millis();
    // Update beatCount
    beatCount++;
    if (beatCount > 4) {
      beatCount = 1;
    }
  }
}

void createSequence(int num, int channel, int startPitch, int startVel) {
  sequences[num] = new RiriSequence();
  sequences[num].addNote(channel, startPitch, startVel, beatsToMils(.5));
  sequences[num].addNote(channel, startPitch + 7, startVel, beatsToMils(.25));
  sequences[num].addNote(channel, startPitch + 4, startVel, beatsToMils(.25));
  sequences[num].start();
}

int beatsToMils(float beats){
  // (one second split into single beats) * # needed
  float convertedNumber = (60000 / BPM) * beats;
  return (int) convertedNumber;
}

void keyPressed() {
  if (!keyDown) {
    switch (key) {
      case ' ':
        playOdeToJoy();
        break;
      default: 
        break;
    }
  }
}

void keyReleased() {
  if (keyDown) {
    switch (key) {
      case '1':

        break;
      default: 
        break;
    }
  }
}

void prepareOdeToJoy() {
    // Prepare some music
  sequences[0] = new RiriSequence();
  sequences[1] = new RiriSequence();
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 65, 100, beatsToMils(1));
  sequences[0].addNote(1, 67, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToMils(4));
  chords[0].addNote(2, 52, 100, beatsToMils(4));
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);
  
  sequences[0].addNote(1, 67, 100, beatsToMils(1));
  sequences[0].addNote(1, 65, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  chords[0].addNote(2, 59, 100, beatsToMils(4));
  chords[0].addNote(2, 62, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToMils(4));
  chords[0].addNote(2, 52, 100, beatsToMils(4));
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 64, 100, beatsToMils(1.5));
  sequences[0].addNote(1, 62, 100, beatsToMils(.5));
  sequences[0].addNote(1, 62, 100, beatsToMils(2));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  chords[0].addNote(2, 59, 100, beatsToMils(4));
  chords[0].addNote(2, 62, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);

  //
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 65, 100, beatsToMils(1));
  sequences[0].addNote(1, 67, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToMils(4));
  chords[0].addNote(2, 52, 100, beatsToMils(4));
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);
  
  sequences[0].addNote(1, 67, 100, beatsToMils(1));
  sequences[0].addNote(1, 65, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  chords[0].addNote(2, 59, 100, beatsToMils(4));
  chords[0].addNote(2, 62, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToMils(4));
  chords[0].addNote(2, 52, 100, beatsToMils(4));
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 62, 100, beatsToMils(1.5));
  sequences[0].addNote(1, 60, 100, beatsToMils(.5));
  sequences[0].addNote(1, 60, 100, beatsToMils(2));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(2));
  chords[0].addNote(2, 59, 100, beatsToMils(2));
  chords[0].addNote(2, 62, 100, beatsToMils(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToMils(2));
  chords[1].addNote(2, 52, 100, beatsToMils(2));
  chords[1].addNote(2, 55, 100, beatsToMils(2));
  sequences[1].addChord(chords[1]);

  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(2));
  chords[0].addNote(2, 59, 100, beatsToMils(2));
  chords[0].addNote(2, 62, 100, beatsToMils(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToMils(2));
  chords[1].addNote(2, 52, 100, beatsToMils(2));
  chords[1].addNote(2, 55, 100, beatsToMils(2));
  sequences[1].addChord(chords[1]);
  
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(.5));
  sequences[0].addNote(1, 65, 100, beatsToMils(.5));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(2));
  chords[0].addNote(2, 59, 100, beatsToMils(2));
  chords[0].addNote(2, 62, 100, beatsToMils(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToMils(2));
  chords[1].addNote(2, 52, 100, beatsToMils(2));
  chords[1].addNote(2, 55, 100, beatsToMils(2));
  sequences[1].addChord(chords[1]);

  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(.5));
  sequences[0].addNote(1, 65, 100, beatsToMils(.5));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(2));
  chords[0].addNote(2, 59, 100, beatsToMils(2));
  chords[0].addNote(2, 62, 100, beatsToMils(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToMils(2));
  chords[1].addNote(2, 52, 100, beatsToMils(2));
  chords[1].addNote(2, 55, 100, beatsToMils(2));
  sequences[1].addChord(chords[1]);

  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  sequences[0].addNote(1, 67, 100, beatsToMils(2));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToMils(2));
  chords[0].addNote(2, 52, 100, beatsToMils(2));
  chords[0].addNote(2, 55, 100, beatsToMils(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 55, 100, beatsToMils(2));
  chords[1].addNote(2, 59, 100, beatsToMils(2));
  chords[1].addNote(2, 62, 100, beatsToMils(2));
  sequences[1].addChord(chords[1]);

  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 65, 100, beatsToMils(1));
  sequences[0].addNote(1, 67, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToMils(4));
  chords[0].addNote(2, 52, 100, beatsToMils(4));
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);
  
  sequences[0].addNote(1, 67, 100, beatsToMils(1));
  sequences[0].addNote(1, 65, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  chords[0].addNote(2, 59, 100, beatsToMils(4));
  chords[0].addNote(2, 62, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  sequences[0].addNote(1, 60, 100, beatsToMils(1));
  sequences[0].addNote(1, 62, 100, beatsToMils(1));
  sequences[0].addNote(1, 64, 100, beatsToMils(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToMils(4));
  chords[0].addNote(2, 52, 100, beatsToMils(4));
  chords[0].addNote(2, 55, 100, beatsToMils(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 62, 100, beatsToMils(1.5));
  sequences[0].addNote(1, 60, 100, beatsToMils(.5));
  sequences[0].addNote(1, 60, 100, beatsToMils(2));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToMils(2));
  chords[0].addNote(2, 59, 100, beatsToMils(2));
  chords[0].addNote(2, 62, 100, beatsToMils(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToMils(2));
  chords[1].addNote(2, 52, 100, beatsToMils(2));
  chords[1].addNote(2, 55, 100, beatsToMils(2));
  sequences[1].addChord(chords[1]);
}

void playOdeToJoy() {
  sequences[0].start();
  sequences[1].start();
}

/*
void keyPressed() {
  if (!keyDown) {
    switch (key) {
      case ' ':
        sequences[0].start();
        //sequences[1].start();
        break;
      case '1':
        // Play a single note (one note, one channel)
        notes[0] = new RiriNote(channel1, 60, 127);
        notes[0].noteOn();
        break;
      case '2':
        // Play a chord (simultaneous notes on different channels)
        notes[0] = new RiriNote(channel1, 60, 127);
        notes[1] = new RiriNote(channel1, 64, 127);
        notes[2] = new RiriNote(channel1, 67, 127);
        notes[0].noteOn();
        notes[1].noteOn();
        notes[2].noteOn();
        break;
      case '3':
        // Play a single note with a duration
        notes[0] = new RiriNote(channel1, 72, 127, 1000);
        notes[0].start();
        break;
      case '4':
        // Play a sequence (multiple notes/channels)
        sequences[0] = new RiriSequence();
        sequences[0].addNote(channel1, 60, 127, 500);
        sequences[0].addNote(channel1, 64, 127, 250);
        sequences[0].addNote(channel1, 67, 127, 250);
        sequences[0].addNote(channel1, 64, 127, 500);
        sequences[0].addNote(channel1, 67, 127, 250);
        sequences[0].addNote(channel1, 64, 127, 250);
        sequences[0].addNote(channel1, 60, 127, 1000);
        sequences[0].start();
        break;
      case '5':
        // Play a sequence using RiriObject.beatsToMils for time
        sequences[1] = new RiriSequence();
        sequences[1].addNote(channel2, 72, 127, RiriObject.beatsToMils(.5));
        sequences[1].addNote(channel2, 71, 127, RiriObject.beatsToMils(.5));
        sequences[1].addNote(channel2, 69, 127, RiriObject.beatsToMils(.5));
        sequences[1].addNote(channel2, 67, 127, RiriObject.beatsToMils(.5));
        sequences[1].addNote(channel2, 65, 127, RiriObject.beatsToMils(.5));
        sequences[1].addNote(channel2, 64, 127, RiriObject.beatsToMils(.5));
        sequences[1].addNote(channel2, 62, 127, RiriObject.beatsToMils(.5));
        sequences[1].addNote(channel2, 67, 127, RiriObject.beatsToMils(.5));
        sequences[1].addNote(channel2, 64, 127, RiriObject.beatsToMils(1));
        RiriChord chord = new RiriChord();
        chord.addNote(channel2, 60, 100, RiriObject.beatsToMils(2));
        chord.addNote(channel2, 64, 100, RiriObject.beatsToMils(1), 2);
        chord.addNote(channel2, 67, 100, RiriObject.beatsToMils(1), 3);
        sequences[1].addChord(chord);
        sequences[1].start();
        break;
      case '6':
        // Add notes to a sequence while it's going
        sequences[2] = new RiriSequence();
        sequences[2].addNote(channel1, 60, 127, RiriObject.beatsToMils(2));
        sequences[2].start();
        delay(RiriObject.beatsToMils(1)); // you can add more notes as the sequence plays
        //delay(RiriObject.beatsToMils(3)); // if the sequence stops, you'll have to start it again 
        sequences[2].addNote(channel1, 72, 127, RiriObject.beatsToMils(2));
        sequences[2].addNote(channel1, 67, 127, RiriObject.beatsToMils(2));
        break;
      case '7':
        // Play a repeating note
        notes[0] = new RiriNote(channel1, 60, 127, RiriObject.beatsToMils(1), 5);
        notes[0].start();
        break;
      case '8':
        // Repeat a note infinitely
        notes[0] = new RiriNote(channel1, 60, 127, RiriObject.beatsToMils(1), true);
        notes[0].start();
        break;
      case '9':
        // Repeated notes in sequences
        sequences[3] = new RiriSequence();
        sequences[3].addNote(channel1, 60, 127, RiriObject.beatsToMils(1), 3);
        sequences[3].addNote(channel1, 64, 127, RiriObject.beatsToMils(1));
        sequences[3].start();
        break;
      case 'q':
        // Control the pitch wheel
        // WORKS IN GARAGEBAND AND ABLETON
        notes[0] = new RiriNote(channel1, 72, 127);
        notes[0].noteOn();
        RiriMessage msg1 = new RiriMessage(RiriMessageType.PITCH_WHEEL, channel1, 0, 0);
        msg1.send();
        break;
      case 'w':
        // Control a channel's volume
        // WORKS IN GARAGEBAND, NOT ABLETON
        notes[0] = new RiriNote(channel1, 72, 127);
        notes[0].noteOn();
        RiriMessage msg = new RiriMessage(RiriMessageType.VOLUME, channel1, 0, -1);
        msg.send();
        break;
      case 'e':
        // Pan a channel
        // WORKS IN GARAGEBAND, NOT ABLETON
        notes[0] = new RiriNote(channel1, 72, 127);
        notes[0].noteOn();
        RiriMessage msg2 = new RiriMessage(RiriMessageType.PAN, channel1, 127, -1);
        msg2.send();
        break;
      case 'r':
        // Play a chord with notes of same duration
        RiriChord chord1 = new RiriChord();
        chord1.addNote(channel1, 60, 100, RiriObject.beatsToMils(1));
        chord1.addNote(channel1, 64, 100, RiriObject.beatsToMils(1));
        chord1.addNote(channel1, 67, 100, RiriObject.beatsToMils(1));
        chord1.start();
        break;
      case 't':
        RiriChord chord2 = new RiriChord();
        chord2.addNote(channel2, 60, 100, RiriObject.beatsToMils(2));
        chord2.addNote(channel2, 64, 100, RiriObject.beatsToMils(1), 2);
        chord2.addNote(channel2, 67, 100, RiriObject.beatsToMils(1), 3);
        chord2.start();
        break;
      case 'y':
        chords[0] = new RiriChord();
        chords[0].addNote(channel1, 60, 100, RiriObject.beatsToMils(1));
        chords[0].addNote(channel1, 64, 100, RiriObject.beatsToMils(1));
        chords[0].addNote(channel1, 67, 100, RiriObject.beatsToMils(1));
        chords[0].chordOn();
        break;
      case 'u':
        RiriSequence s = new RiriSequence();
        RiriNote n = new RiriNote(1, 60, 100, 1000);
        s.addNote(n);
        RiriChord c = new RiriChord();
        c.addNote(1, 64, 100, 1000);
        c.addNote(1, 67, 100, 1000);
        s.addChord(c);
        //println("In Test: "+c.duration());
        RiriChord c2 = new RiriChord();
        c2.addNote(2, 72, 100, 1000);
        c2.addNote(2, 76, 100, 1000);
        s.addChord(c2);
        s.start();
      default:
        
    } 
  }
  keyDown = true;
}

void keyReleased() {
  switch (key) {
    case '1':
      notes[0].noteOff();
      break;
    case '2':
      notes[0].noteOff();
      notes[1].noteOff();
      notes[2].noteOff();
      break;
    case '3':
      break;
    case '4':
      break;
    case '5':
      break;
    case '6':
      break;
    case '7':
      notes[0].quit();
      break;
    case '8':
      notes[0].quit();
      break;
    case '9':
      break;
    case 'q':
      RiriMessage msg1 = new RiriMessage(RiriMessageType.PITCH_WHEEL, channel1, 0, 64);
      msg1.send();
      notes[0].noteOff();
      break;
    case 'w':
      RiriMessage msg = new RiriMessage(RiriMessageType.VOLUME, channel1, 100, -1);
      msg.send();
      notes[0].noteOff();
      break;
    case 'e':
      RiriMessage msg2 = new RiriMessage(RiriMessageType.PAN, channel1, 64, -1);
      msg2.send(); 
      notes[0].noteOff();
      break;
    case 'r':
      break;
    case 't':
      break;
    case 'y':
      chords[0].chordOff();
      break;
    default:
      
  }
  keyDown = false;
}
*/