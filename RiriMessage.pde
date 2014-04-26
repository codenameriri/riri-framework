/*
* RiriMessage
*
* Encapsulates values and operations for sending a MIDI message
* http://www.midi.org/techspecs/midimessages.php
*/

public class RiriMessage {
	
  /*
  * Instance Variables
  */

  // Message properties
  private int status, data1, data2, channel;

  /*
  * Default Constructor
  */
  public RiriMessage() {
  
  }
  
  /*
  * Constructor
  * @param RiriMessageType type - What kind of message is being sent
  * @param int aChannel - Channel to send the message on
  * @param int aData1 - First data byte to send
  * @param int aData2 - Second data byte to send
  */
  public RiriMessage(RiriMessageType type, int aChannel, int aData1, int aData2) {
    setMessageByType(type, aChannel, aData1, aData2);
  }
  
  /*
  * Constructor
  * @param int aStatus - Status code of the message to send (accounts for specific channel)
  * @param int aData1 - First data byte to send
  * @param int aData2 - Second data byte to send
  */
  public RiriMessage(int aStatus, int aData1, int aData2) {
    status = aStatus;
    channel = -1;
    data1 = aData1;
    data2 = aData2;
  }
  
  /*
  * Constructor
  * @param int aCommand - Status code of the message to send
  * @param int aChannel - Channel to send the message on
  * @param int aData1 - First data byte to send (Control Number)
  * @param int aData2 - Second data byte to send (Value)
  */
  public RiriMessage(int aCommand, int aChannel, int aData1, int aData2) {
    status = aCommand;
    channel = aChannel;
    data1 = aData1;
    data2 = aData2;
  }

  /*
  * send() - Send a MIDI message
  */
  public void send() {
  	//println("sending msg");
  	// If the channel isn't set, send a MIDI message
    if (channel < 0) {
      //println("midi msg");
      if (data2 < 0) {
      	mb.sendMessage(status, data1);
      }
      else {
      	mb.sendMessage(status, data1, data2);
      }
    }
    // If the channel is set, send a Channel message
    else {
      //println("channel msg");
      mb.sendMessage(status, channel, data1, data2);
    }
  }

  /*
  * setMessageByType() - Assign message parameters by message type
  * @param RiriMessageType type - What kind of message is being sent
  * @param int aChannel - Channel to send the message on
  * @param int aData1 - First data byte to send
  * @param int aData2 - Second data byte to send
  */
  public void setMessageByType(RiriMessageType type, int aChannel, int aData1, int aData2) {
    switch(type) {
      // MIDI Messages
      case NOTE_OFF:
        status = 128 + aChannel; 
        channel = -1;
        data1 = aData1; // Pitch
        data2 = aData2; // Velocity
        break;
      case NOTE_ON:
        status = 144 + aChannel;
        channel = -1;
        data1 = aData1; // Pitch
        data2 = aData2; // Velocity
        break;
      case POLY_AFTERTOUCH:
        status = 160 + aChannel;
        channel = -1;
        data1 = aData1; // Pitch
        data2 = aData2; // Pressure
        break;
      case CHANNEL_AFTERTOUCH:
        status = 208 + aChannel;
        channel = -1;
        data1 = aData1; // Pressure
        data2 = -1; // N/A
        break;
      case PITCH_WHEEL:
        status = 224 + aChannel;
        channel = -1;
        data1 = aData1; // LSB
        data2 = aData2; // MSB
        break;
      // Channel Messages
      case VOLUME:
        status = 176;
        channel = aChannel;
        data1 = 7;
        data2 = aData1;
        break;
      case BALANCE:
        status = 176;
        channel = aChannel;
        data1 = 8;
        data2 = aData1;
        break;
      case PAN:
        status = 176;
        channel = aChannel;
        data1 = 10;
        data2 = aData1;
        break;
      case ALL_SOUND_OFF:
        status = 176;
        channel = aChannel;
        data1 = 120;
        data2 = 0;
        break;
      case ALL_NOTES_OFF:
        status = 176;
        channel = aChannel;
        data1 = 123;
        data2 = 0;
        break;
      default:
        break;
    }
  }

}