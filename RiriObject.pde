/*
* RiriObject
*
* Base class for Notes, Rests, and Chords
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
    if (!running) {
      running = true;
      counter = 0;
      try {
        super.start();
      }
      catch (IllegalThreadStateException e) {
        println("Problem starting thread...");
        println(e.getMessage());
      }
    }
  }

  /*
  * run() - Thread execution function
  */
  public void run() {
    while (running && counter < repeats) {
      // Sleep for the note's duration
      try {
        long millis = round(duration/1000);
        int nanos = Integer.parseInt(String.valueOf(duration).substring(String.valueOf(duration).length() -3));
        sleep(millis, nanos);
      } catch (Exception e) {
        println("Problem sleeping thread...");
        println(e.getMessage());
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
    if (running) {
      running = false;
      counter = 0;
      interrupt();
    }
  }

  /*
  * clone() - Create a copy of the RiriObject
  */
  public RiriObject clone() {
    RiriObject clone = new RiriObject();
    clone.duration(this.duration);
    clone.repeats(this.repeats);
    clone.infinite(this.infinite);
    return clone;
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

  public String toString() {
    return "";
  }

}