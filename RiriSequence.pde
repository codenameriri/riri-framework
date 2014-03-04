/*
*	RiriSequence
*
*	Encapsulates values and operations for playing a sequence of MIDI notes
*/

public class RiriSequence extends RiriObject {
	
  /*
  *	Instance Variables
  */
  
  // List of RiriNotes
  ArrayList<RiriObject> notes = null;
  
  /*
  *	Default Constructor
  */
  public RiriSequence() {
    notes = new ArrayList<RiriObject>();
  }

  /*
  * Constructor
  * @param ArrayList<RiriNote> aNotes - List of RiriNotes to start with
  */
  public RiriSequence(ArrayList<RiriObject> aNotes) {
    notes = aNotes;
  }
  
  /*
  *	Constructor
  * @param ArrayList<RiriNote> aNotes - List of RiriNotes to start with
  * @param int aInterval - Interval between all notes in the sequence 	
  */
  public RiriSequence(ArrayList<RiriObject> aNotes, int aInterval) {
    notes = aNotes;
    for (int i = 0; i < notes.size(); i++) {
      notes.get(i).duration(aInterval);
    }
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
    while(running && counter < notes.size()) {
      // Grab and play the current note in the sequence
      RiriObject currentNote = notes.get(counter);
      int wait = currentNote.duration() * currentNote.repeats();
      currentNote.start();
      // Sleep for the duration of the note
      try {
        //sleep((long) currentNote.duration());
        sleep((long) wait);
      } catch (Exception e) {
        println("iunno...");
      }
      counter++;
    }
    // If we're out of notes, stop executing
    running = false;
    counter = 0;
  }

  /*
  * quit() - Stop executing the thread
  */
  public void quit() {
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
  * @param int channel - channel the note should play on
  * @param int duration - duration of the note (in milliseconds)
  */
  public void addRest(int channel, int duration) {
    notes.add(new RiriNote(channel, 0, 0, duration)); 
  }

  /*
  * addChord - Add a chord
  * @param RiriChord chord - The RiriChord to add to the sequence
  */
  public void addChord(RiriChord chord) {
    notes.add(chord);
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

  public void position(int i) {
    counter = i;
  }

}
