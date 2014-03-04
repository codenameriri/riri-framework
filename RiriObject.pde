/*
*	RiriObject
*
*	Base class for Notes, Rests, and Chords
*/

public class RiriObject extends Thread {

  // Thread properties	
  protected boolean running = false;
  protected int counter = 0;

  // RiriObject properties
  protected int duration = 0;
  protected int repeats = 1;
  protected boolean infinite = false;
  protected boolean playing = false;

  /*
  * Private Constructor
  */
  private RiriObject() {

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
      // Sleep for the note's duration
      try {
        sleep((long) duration);
      } catch (Exception e) {
        println("iunno...");
      }
      // Increment the counter
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
  }

  /*
  * Getters and setters
  */
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

  public String type() {
  	return this.getClass().getSimpleName();
  }

}