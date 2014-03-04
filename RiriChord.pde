/*
*	RiriChord
*
*	Encapsulates values and operations for playing several simultaneous MIDI notes
*/

public class RiriChord extends RiriObject {

  /*
  *	Instance Variables
  */

  // Notes in the chord
  ArrayList<RiriNote> notes = null;

  /*
  * Default Constructor
  */
  public RiriChord() {
  	notes = new ArrayList<RiriNote>();
    running = false;
    counter = 0;
  }

  /*
  * start() - Start executing the thread
  */
  public void start() {
  	setChordDuration();
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
        sleep((long) duration);
      } catch (Exception e) {
        println("iunno...");
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
    super.quit();
  }

  /*
  * addNote() - Add a note
  * @param RiriNote note - The RiriNote to add to the sequence
  */
  public void addNote(RiriNote note) {
  	note.infinite(false);
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
  * setChordDuration() - Determine the duration of the chord
  */
  private void setChordDuration() {
  	int longest = 0;
  	for (int i = 0; i < notes.size(); i++) {
  		int current = notes.get(i).duration() * notes.get(i).repeats();
  		if (current > longest) {
  			longest = current;
  		}
  	}
  	duration = longest;
  }
}