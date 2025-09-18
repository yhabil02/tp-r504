import java.io.*;
import java.net.*;

InetAddress addr = InetAddress.getLocalHost();
System.out.println("adresse=" +addr.getHostName());

DatagramPacket packet = new DatagramPacket(data, data.length, addr, 1234);
DatagramSocket sock = new DatagramSocket ();
sock.send(packet);
sock.close();