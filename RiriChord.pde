/*
* RiriChord
*
* Encapsulates values and operations for playing several simultaneous MIDI notes
*/

public class RiriChord extends RiriObject {

  /*
  * Instance Variables
  */

  // GLOBALS
  // MidiBus mb; // Created in main sketch

  // Notes in the chord
  ArrayList<RiriNote> notes = null;

  // Playing (for manual starting/stopping)
  private boolean playing = false;

  // Channel notes should be played on
  private int channel = 0;

  /*
  * Default Constructor
  */
  public RiriChord() {
    super();
    notes = new ArrayList<RiriNote>();
    channel = 0;
    running = false;
    counter = 0;
  }

  /*
  * Constructor
  * @param int aChannel - channel notes in the chord should be played on
  */
  public RiriChord(int aChannel) {
    super();
    notes = new ArrayList<RiriNote>();
    channel = aChannel;
    running = false;
    counter = 0;
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
      // Play the notes in the chord
      for (int i = 0; i < notes.size(); i++) {
        //notes.get(i).noteOn();
        notes.get(i).start();
      }
      // Sleep for the chord's duration
      try {
        long millis = round(duration/1000);
        int nanos = Integer.parseInt(String.valueOf(duration).substring(String.valueOf(duration).length() -3));
        sleep(millis, nanos);
      } catch (Exception e) {
        println("Problem sleeping thread...");
        println(e.getMessage());
      }
      // Stop the notes in the chord
      /*for (int i = 0; i < notes.size(); i++) {
        //notes.get(i).noteOff();
      }*/
      counter++;
    }
    running = false;
    counter = 0;
  }

  /*
  * quit() - Stop executing the thread
  */
  public void quit() {
    chordOff();
    notes = new ArrayList<RiriNote>();
    super.quit();
  }

  /*
  * addNote() - Add a note
  * @param RiriNote note - The RiriNote to add to the sequence
  */
  public void addNote(RiriNote note) {
    note.infinite(false);
    notes.add(note);
    setChordDuration();
  }
  
  /*
  * addNote() - Add a note
  * @param int pitch - pitch of the note
  * @param int velocity - velocity of the note 
  * @param int duration - duration of the note (in milliseconds)
  */
  public void addNote(int pitch, int velocity, int duration) {
    notes.add(new RiriNote(channel, pitch, velocity, duration)); 
    setChordDuration();
  }

  /*
  * addNote() - Add a note
  * @param int channel - channel the note should play on
  * @param int pitch - pitch of the note
  * @param int velocity - velocity of the note 
  * @param int duration - duration of the note (in milliseconds)
  */
  public void addNote(int channel, int pitch, int velocity, int duration) {
    notes.add(new RiriNote(channel, pitch, velocity, duration)); 
    setChordDuration();
  }

  /*
  * addNote() - Add a note
  * @param int channel - channel the note should play on
  * @param int pitch - pitch of the note
  * @param int velocity - velocity of the note 
  * @param int duration - duration of the note (in milliseconds)
  * @param int repeats - number of times to repeat the note)
  */
  public void addNote(int channel, int pitch, int velocity, int duration, int repeats) {
    notes.add(new RiriNote(channel, pitch, velocity, duration, repeats)); 
    setChordDuration();
  }

  /*
  * allOn() - Start playing the chord
  */
  public void chordOn() {
    if (!playing) {
      for (int i = 0; i < notes.size(); i++) {
        RiriNote current = notes.get(i);
        current.noteOn();
      }
      playing = true;
    }
    else {
      println("Chord not played, already playing!");
    }
  }

  /*
  * allOff() - Stop playing the chord
  */
  public void chordOff() {
    if (playing) {
      for (int i = 0; i < notes.size(); i++) {
        RiriNote current = notes.get(i);
        current.noteOff();
      }
      playing = false;
    }
    else {
      println("Chord not stopped, already stopped!");
    }
  }

  /*
  * setChordDuration() - Determine the duration of the chord
  */
  public void setChordDuration() {
    int longest = 0;
    // Find the longest note duration (considering repeats)
    for (int i = 0; i < notes.size(); i++) {
      int current = notes.get(i).duration() * notes.get(i).repeats();
      if (current > longest) {
        longest = current;
      }
    }
    // Set the chord's duration to the duration of the longest note
    duration(longest);
  }

  /*
  * clone() - Create a copy of the RiriChord
  */
  public RiriObject clone() {
    RiriChord clone = new RiriChord();
    clone.duration(this.duration);
    clone.repeats(this.repeats);
    clone.infinite(this.infinite);
    clone.notes = new ArrayList<RiriNote>();
    for (int i = 0; i < this.notes.size(); i++) {
      clone.notes.add((RiriNote) this.notes.get(i).clone());
    }
    return clone;
  }

  /*
  * Getters/Setters
  *
  * Getters take no parameters, returns the value of the property
  * Setters take one parameter, the new value of the property
  */
  public ArrayList<RiriNote> notes() {
    return notes;
  }

  public void notes(ArrayList<RiriNote> n) {
    notes = n;
  }

  public String toString() {
    String str = "\nRiriChord:";
    str += "\n==========";
    str += "\nDuration: " + duration();
    str += "\nRepeats: " + repeats();
    str += "\nNotes:";
    for (int i = 0; i < notes.size(); i++) {
      str += notes.get(i).toString();
    }
    return str;
  }
}