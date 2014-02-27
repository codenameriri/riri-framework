/*
*	RiriNote
*
*	Encapsulates values and operations for playing a MIDI note
*/

public class RiriNote extends Thread {
	
  /*
  *	Instance Variables
  */
  
  // GLOBALS
  // MidiBus mb; // Created in main sketch

  // Thread stuff
  private boolean running;
  
  // Am I currently playing?
  protected boolean playing = false;

  // MIDI note properties
  protected int channel = 0;
  protected int pitch = 0;
  protected int velocity = 0;
  protected int duration = 0;
  
  /*
  *	Default Constructor	
  */
  public RiriNote() {
  	running = false;
  }
  
  /*
  *	Constructor
  *	@param int aChannel = the channel the note should be played on (0-15)
  *	@param int aPitch = the pitch of the note (0-127)
  *	@param int aVelocity = the velocity of the note (0-127)
  */
  public RiriNote(int aChannel, int aPitch, int aVelocity) {
    // Set instance vars
    channel = aChannel;
    pitch = aPitch;
    velocity = aVelocity;
    running = false;
  }
  
  /*
  *	Constructor
  *	@param int aChannel = the channel the note should be played on (0-15)
  *	@param int aPitch = the pitch of the note (0-127)
  *	@param int aVelocity = the velocity of the note (0-127)
  *	@param int aDuration = the duration of the note (in milliseconds)
  */
  public RiriNote(int aChannel, int aPitch, int aVelocity, int aDuration) {
    // Set instance vars
    channel = aChannel;
    pitch = aPitch;
    velocity = aVelocity;
    duration = aDuration;
    running = false;
  }

  /*
  * start() - Start executing the thread
  */
  public void start() {
    running = true;
    super.start();
  }

  /*
  * run() - Thread execution function
  */
  public void run() {
    while (running) {
      // Send a noteOn message
      noteOn();
      // Sleep for the note's duration
      try {
        sleep((long) duration);
      } catch (Exception e) {
        println("iunno...");
      }
      // Send a note off event and quit executing
      noteOff();
      running = false;
    }
  }

  /*
  * quit() - Stop executing the thread
  */
  public void quit() {
    running = false;
    noteOff();
  }

  /*
  *	noteOn() - Start playing the note
  */
  public void noteOn() {
    if (!playing) {
      mb.sendNoteOn(channel, pitch, velocity);
      playing = true;
      println("playing " + pitch);
    }
    else {
      println("Note not played, already playing!");
    }
  }

  /*
  *	noteOff() - Stop playing a note
  */
  public void noteOff() {
    if (playing) {
      mb.sendNoteOff(channel, pitch, velocity);
      playing = false;
      println("stopping " + pitch);
    }
    else {
      println("Note not stopped, already stopped!");
    }
  }

  /*
  *	Getters/Setters
  *
  *	Getters take no parameters, returns the value of the property
  *	Setters take one parameter, the new value of the property
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
  
  public int duration() {
    return duration;
  }
  
  public void duration(int d) {
    duration = d;
  }
  
  public boolean playing() {
    return playing; 
  }

}
