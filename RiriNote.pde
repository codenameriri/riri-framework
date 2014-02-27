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
  private int counter;
  
  // Am I currently playing?
  protected boolean playing = false;

  // MIDI note properties
  protected int channel = 0;
  protected int pitch = 0;
  protected int velocity = 0;
  

  // RiriNote properties
  protected int duration = 0;
  protected int repeats = 1;
  protected boolean infinite = false;
  
  /*
  *	Default Constructor	
  */
  public RiriNote() {
  	// Set thread vars
    counter = 0;
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
    duration = 0;
    repeats = 1;
    // Set thread vars
    counter = 0;
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
    duration = 0;
    repeats = 1;
    // Set thread vars
    counter = 0;
    running = false;
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
    // Set instance vars
    channel = aChannel;
    pitch = aPitch;
    velocity = aVelocity;
    duration = aDuration;
    repeats = aRepeats;
    // Set thread vars
    counter = 0;
    running = false;
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
    // Set instance vars
    channel = aChannel;
    pitch = aPitch;
    velocity = aVelocity;
    duration = aDuration;
    repeats = 1;
    infinite = true;
    // Set thread vars
    counter = 0;
    running = false;
  }

  /*
  * start() - Start executing the thread
  */
  public void start() {
    running = true;
    counter = 0;
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
        sleep((long) duration);
      } catch (Exception e) {
        println("iunno...");
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
    running = false;
    counter = 0;
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

  public int repeats() {
    return repeats;
  }

  public void repeats(int r) {
    repeats = r;
  }

  public boolean infinite() {
    return infinite;
  }

  public void infinite(boolean i) {
    infinite = i;
  }
  
  public boolean playing() {
    return playing; 
  }

}
