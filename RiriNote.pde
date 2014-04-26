/*
* RiriNote
*
* Encapsulates values and operations for playing a MIDI note
*/

public class RiriNote extends RiriObject {
  
  /*
  * Instance Variables
  */
  
  // GLOBALS
  // MidiBus mb; // Created in main sketch

  // MIDI note properties
  protected int channel = 0;
  protected int pitch = 0;
  protected int velocity = 0;
  
  /*
  * Default Constructor 
  */
  public RiriNote() {

  }
  
  /*
  * Constructor
  * @param int aChannel = the channel the note should be played on (0-15)
  * @param int aPitch = the pitch of the note (0-127)
  * @param int aVelocity = the velocity of the note (0-127)
  */
  public RiriNote(int aChannel, int aPitch, int aVelocity) {
    super();
    // Set instance vars
    channel = aChannel;
    pitch = aPitch;
    velocity = aVelocity;
    duration = 0;
    repeats = 1;
  }
  
  /*
  * Constructor
  * @param int aChannel = the channel the note should be played on (0-15)
  * @param int aPitch = the pitch of the note (0-127)
  * @param int aVelocity = the velocity of the note (0-127)
  * @param int aDuration = the duration of the note (in milliseconds)
  */
  public RiriNote(int aChannel, int aPitch, int aVelocity, int aDuration) {
    super();
    // Set instance vars
    channel = aChannel;
    pitch = aPitch;
    velocity = aVelocity;
    duration = aDuration;
    repeats = 1;
  }

  /*
  * Constructor
  * @param int aChannel = the channel the note should be played on (0-15)
  * @param int aPitch = the pitch of the note (0-127)
  * @param int aVelocity = the velocity of the note (0-127)
  * @param int aDuration = the duration of the note (in milliseconds)
  * @params int aRepeats = the number of times to repeat the note
  */
  public RiriNote(int aChannel, int aPitch, int aVelocity, int aDuration, int aRepeats) {
    super();
    // Set instance vars
    channel = aChannel;
    pitch = aPitch;
    velocity = aVelocity;
    duration = aDuration;
    repeats = aRepeats;
  }

  /*
  * Constructor
  * @param int aChannel = the channel the note should be played on (0-15)
  * @param int aPitch = the pitch of the note (0-127)
  * @param int aVelocity = the velocity of the note (0-127)
  * @param int aDuration = the duration of the note (in milliseconds)
  * @params boolean aInfinite = repeat the note indefinitely
  */
  public RiriNote(int aChannel, int aPitch, int aVelocity, int aDuration, boolean aInfinite) {
    super();
    // Set instance vars
    channel = aChannel;
    pitch = aPitch;
    velocity = aVelocity;
    duration = aDuration;
    repeats = 1;
    infinite = true;
  }

  /*
  * start() - Start executing the thread
  */
  public void start() {
      super.start();
  }

  /*
  * run() - Thread execution function
  */
  public void run() {
    while (running && counter < repeats) {
      // Send a noteOn message
      noteOn();
      // Sleep for the note's duration
      try {
        long millis = round(duration/1000);
        int nanos = Integer.parseInt(String.valueOf(duration).substring(String.valueOf(duration).length() -3));
        sleep(millis, nanos);
      } catch (Exception e) {
        println("Problem sleeping thread...");
        println(e.getMessage());
      }
      // Send a note off event and quit executing
      noteOff();
      if (!infinite) {
        counter++;
      }
    }
    running = false;
    counter = 0;
  }

  /*
  * quit() - Stop executing the thread
  */
  public void quit() {
    noteOff();
    super.quit();
  }

  /*
  * noteOn() - Start playing the note
  */
  public void noteOn() {
    if (!playing) {
      mb.sendNoteOn(channel, pitch, velocity);
      playing = true;
      //println("playing " + pitch + " on channel " + channel + " with velocity " + velocity + " and duration " + duration);
    }
    else {
      println("Note not played, already playing!");
    }
  }

  /*
  * noteOff() - Stop playing a note
  */
  public void noteOff() {
    if (playing) {
      mb.sendNoteOff(channel, pitch, velocity);
      playing = false;
      //println("stopping " + pitch);
    }
    else {
      println("Note not stopped, already stopped!");
    }
  }

  /*
  * clone() - Create a copy of the RiriNote
  */
  public RiriObject clone() {
    RiriNote clone = new RiriNote();
    clone.duration(this.duration);
    clone.repeats(this.repeats);
    clone.infinite(this.infinite);
    clone.channel(this.channel);
    clone.pitch(this.pitch);
    clone.velocity(this.pitch);
    return clone;
  }

  /*
  * Getters/Setters
  *
  * Getters take no parameters, returns the value of the property
  * Setters take one parameter, the new value of the property
  */
  public int channel() {
    return channel;
  }
  
  public void channel(int c) {
    channel = c;
  }

  public int pitch() {
    return pitch;
  }
  
  public void pitch(int p) {
    pitch = p;
  }
  
  public int velocity() {
    return velocity;
  }
  
  public void velocity(int v) {
    velocity = v;
  }

  public String toString() {
    String str = "\nRiriNote:";
    str += "\n=========";
    str += "\nChannel: " + channel();
    str += "\nPitch: " + pitch();
    str += "\nVelocity: " + velocity();
    str += "\nDuration: " + duration();
    return str;
  }

}
