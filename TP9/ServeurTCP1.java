import java.io.*;
import java.net.*;

DatagramSocket sock = new DatagramSocket (1234);
while(true)
{
	System.out.println("-Waiting data");
	DatagramPacket packet = new DatagramPacket(new byte[1024], 1024);
	sock.recieve(packet);
	String str = new String(packet.getData());
	System.out.println("str=" + str);
}