/*
* RiriSequence
*
* Encapsulates values and operations for playing a sequence of MIDI notes
*/

public class RiriSequence extends RiriObject {
  
  /*
  * Instance Variables
  */
  
  // List of RiriNotes
  private ArrayList<RiriObject> notes = null;

  // Channel to play notes on
  private int channel;
  
  /*
  * Default Constructor
  */
  public RiriSequence() {
    super();
    notes = new ArrayList<RiriObject>();
    channel = 0;
  }

  /*
  * Constructor
  * @param int aChannel - channel notes in the chord should be played on  
  */
  public RiriSequence(int aChannel) {
    super();
    notes = new ArrayList<RiriObject>();
    channel = aChannel;
  }

  /*
  * Constructor
  * @param ArrayList<RiriNote> aNotes - List of RiriNotes to start with
  */
  public RiriSequence(ArrayList<RiriObject> aNotes) {
    super();
    notes = aNotes;
    channel = 0;
  }
  
  /*
  * Constructor
  * @param ArrayList<RiriNote> aNotes - List of RiriNotes to start with
  * @param int aChannel - channel notes in the chord should be played on  
  */
  public RiriSequence(ArrayList<RiriObject> aNotes, int aChannel) {
    super();
    notes = aNotes;
    channel = aChannel;
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
    // Loop through each note in the sequence
    while(running && counter < repeats) {
      int c = 0;
      while (c < notes.size()) {
        // Grab and play the current note in the sequence
        RiriObject currentNote = notes.get(c).clone();
        long wait = currentNote.duration() * currentNote.repeats();
        currentNote.start();
        // Sleep for the duration of the note
        try {
          long millis = round(wait/1000);
          int nanos = Integer.parseInt(String.valueOf(wait).substring(String.valueOf(wait).length() -3));
          sleep(millis, nanos);
        } catch (Exception e) {
          println("Problem sleeping thread...");
          println(e.getMessage());
        }
        c++;
      }
      if (!infinite) {
        counter++;
      }
    }
    // If we're out of notes, stop executing
    running = false;
    counter = 0;
    println("Done");
  }

  /*
  * clone() - Create a copy of the RiriSequence
  */
  public RiriObject clone() {
    RiriSequence clone = new RiriSequence();
    clone.duration(this.duration);
    clone.repeats(this.repeats);
    clone.infinite(this.infinite);
    clone.notes = new ArrayList<RiriObject>();
    for (int i = 0; i < this.notes.size(); i++) {
      clone.notes.add(this.notes.get(i).clone());
    }
    return clone;
  }

  /*
  * quit() - Stop executing the thread
  */
  public void quit() {
      notes = new ArrayList<RiriObject>();
      super.quit();
  }
  
  /*
  * addNote() - Add a note
  * @param RiriNote note - The RiriNote to add to the sequence
  */
  public void addNote(RiriNote note) {
    notes.add(note);
  }

  /*
  * addNote() - Add a note
  * @param int pitch - pitch of the note
  * @param int velocity - velocity of the note 
  * @param int duration - duration of the note (in milliseconds)
  */
  public void addNote(int pitch, int velocity, int duration) {
    notes.add(new RiriNote(channel, pitch, velocity, duration)); 
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
  }
  
  /*
  * addRest() - Add a note with no pitch/velocity
  * @param int duration - duration of the note (in milliseconds)
  */
  public void addRest(int duration) {
    notes.add(new RiriNote(channel, 0, 0, duration)); 
  }

  /*
  * addRest() - Add a note with no pitch/velocity
  * @param int channel - channel the note should play on
  * @param int duration - duration of the note (in milliseconds)
  */
  public void addRest(int channel, int duration) {
    notes.add(new RiriNote(channel, 0, 0, duration)); 
  }

  /*
  * addChord() - Add a chord
  * @param RiriChord chord - The RiriChord to add to the sequence
  */
  public void addChord(RiriChord chord) {
    notes.add(chord);
  }

  /*
  * clear() - Empty the sequence
  */
  public void clear() {
    notes = new ArrayList<RiriObject>();
  }
  
  /*
  *  Getters/Setters
  *
  *  Getters take no parameters, returns the value of the property
  *  Setters take one parameter, the new value of the property
  */
  public ArrayList<RiriObject> notes() {
    return notes;
  }

  public void notes(ArrayList<RiriObject> n) {
    notes = n;
  }

  public int position() {
    return counter;
  }

  public int duration() {
    int d = 0;
    for (int i = 0; i < notes.size(); i++) {
      d += notes.get(i).duration() * notes.get(i).repeats();
    }
    return d;
  }

}
