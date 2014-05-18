import themidibus.*;

// Timekeeping
int BPM = 120;
int lastTime = 0;
int pastTime = 0;
int beatCount  = 1;
boolean playing = false;

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
RiriNote[] notes = new RiriNote[4];
RiriSequence[] sequences = new RiriSequence[4];
RiriMessage[] messages = new RiriMessage[4];
RiriChord[] chords = new RiriChord[4];

void setup() {
  size(400,200);
  // Setup MidiBus
  MidiBus.list();
  mb = new MidiBus(this, -1, MIDI_PORT_OUT);
  mb.sendTimestamps();
  lastTime = millis();
}

void draw() {
  background(0);
  textAlign(LEFT);
  text("Press the space bar to play some music", 0, 50);
}

void keyPressed() {
	if (key == ' ') {
		if (playing) {
			stopMusic();
		}
		else {
  			prepareOdeToJoy();
  			playOdeToJoy();
		}
	}
}

void playOdeToJoy() {
  println("playing...");
  sequences[0].start();
  sequences[1].start();
}

void stopMusic() {
  println("playing...");
  sequences[0].quit();
  sequences[1].quit();
}

int beatsToNanos(float beats){
  // (one second split into single beats) * # needed
  float convertedNumber = (60000000 / BPM) * beats;
  return (int) convertedNumber;
}

void prepareOdeToJoy() {
  println("preparing...");
  // Prepare some music
  sequences[0] = new RiriSequence();
  sequences[1] = new RiriSequence();
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 65, 100, beatsToNanos(1));
  sequences[0].addNote(1, 67, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToNanos(4));
  chords[0].addNote(2, 52, 100, beatsToNanos(4));
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);
  
  sequences[0].addNote(1, 67, 100, beatsToNanos(1));
  sequences[0].addNote(1, 65, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  chords[0].addNote(2, 59, 100, beatsToNanos(4));
  chords[0].addNote(2, 62, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToNanos(4));
  chords[0].addNote(2, 52, 100, beatsToNanos(4));
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 64, 100, beatsToNanos(1.5));
  sequences[0].addNote(1, 62, 100, beatsToNanos(.5));
  sequences[0].addNote(1, 62, 100, beatsToNanos(2));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  chords[0].addNote(2, 59, 100, beatsToNanos(4));
  chords[0].addNote(2, 62, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);

  //
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 65, 100, beatsToNanos(1));
  sequences[0].addNote(1, 67, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToNanos(4));
  chords[0].addNote(2, 52, 100, beatsToNanos(4));
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);
  
  sequences[0].addNote(1, 67, 100, beatsToNanos(1));
  sequences[0].addNote(1, 65, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  chords[0].addNote(2, 59, 100, beatsToNanos(4));
  chords[0].addNote(2, 62, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToNanos(4));
  chords[0].addNote(2, 52, 100, beatsToNanos(4));
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 62, 100, beatsToNanos(1.5));
  sequences[0].addNote(1, 60, 100, beatsToNanos(.5));
  sequences[0].addNote(1, 60, 100, beatsToNanos(2));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(2));
  chords[0].addNote(2, 59, 100, beatsToNanos(2));
  chords[0].addNote(2, 62, 100, beatsToNanos(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToNanos(2));
  chords[1].addNote(2, 52, 100, beatsToNanos(2));
  chords[1].addNote(2, 55, 100, beatsToNanos(2));
  sequences[1].addChord(chords[1]);

  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(2));
  chords[0].addNote(2, 59, 100, beatsToNanos(2));
  chords[0].addNote(2, 62, 100, beatsToNanos(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToNanos(2));
  chords[1].addNote(2, 52, 100, beatsToNanos(2));
  chords[1].addNote(2, 55, 100, beatsToNanos(2));
  sequences[1].addChord(chords[1]);
  
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(.5));
  sequences[0].addNote(1, 65, 100, beatsToNanos(.5));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(2));
  chords[0].addNote(2, 59, 100, beatsToNanos(2));
  chords[0].addNote(2, 62, 100, beatsToNanos(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToNanos(2));
  chords[1].addNote(2, 52, 100, beatsToNanos(2));
  chords[1].addNote(2, 55, 100, beatsToNanos(2));
  sequences[1].addChord(chords[1]);

  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(.5));
  sequences[0].addNote(1, 65, 100, beatsToNanos(.5));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(2));
  chords[0].addNote(2, 59, 100, beatsToNanos(2));
  chords[0].addNote(2, 62, 100, beatsToNanos(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToNanos(2));
  chords[1].addNote(2, 52, 100, beatsToNanos(2));
  chords[1].addNote(2, 55, 100, beatsToNanos(2));
  sequences[1].addChord(chords[1]);

  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  sequences[0].addNote(1, 67, 100, beatsToNanos(2));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToNanos(2));
  chords[0].addNote(2, 52, 100, beatsToNanos(2));
  chords[0].addNote(2, 55, 100, beatsToNanos(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 55, 100, beatsToNanos(2));
  chords[1].addNote(2, 59, 100, beatsToNanos(2));
  chords[1].addNote(2, 62, 100, beatsToNanos(2));
  sequences[1].addChord(chords[1]);

  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 65, 100, beatsToNanos(1));
  sequences[0].addNote(1, 67, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToNanos(4));
  chords[0].addNote(2, 52, 100, beatsToNanos(4));
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);
  
  sequences[0].addNote(1, 67, 100, beatsToNanos(1));
  sequences[0].addNote(1, 65, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  chords[0].addNote(2, 59, 100, beatsToNanos(4));
  chords[0].addNote(2, 62, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  sequences[0].addNote(1, 60, 100, beatsToNanos(1));
  sequences[0].addNote(1, 62, 100, beatsToNanos(1));
  sequences[0].addNote(1, 64, 100, beatsToNanos(1));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 48, 100, beatsToNanos(4));
  chords[0].addNote(2, 52, 100, beatsToNanos(4));
  chords[0].addNote(2, 55, 100, beatsToNanos(4));
  sequences[1].addChord(chords[0]);

  sequences[0].addNote(1, 62, 100, beatsToNanos(1.5));
  sequences[0].addNote(1, 60, 100, beatsToNanos(.5));
  sequences[0].addNote(1, 60, 100, beatsToNanos(2));
  chords[0] = new RiriChord();
  chords[0].addNote(2, 55, 100, beatsToNanos(2));
  chords[0].addNote(2, 59, 100, beatsToNanos(2));
  chords[0].addNote(2, 62, 100, beatsToNanos(2));
  sequences[1].addChord(chords[0]);
  chords[1] = new RiriChord();
  chords[1].addNote(2, 48, 100, beatsToNanos(2));
  chords[1].addNote(2, 52, 100, beatsToNanos(2));
  chords[1].addNote(2, 55, 100, beatsToNanos(2));
  sequences[1].addChord(chords[1]);
}