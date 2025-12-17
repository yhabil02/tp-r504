import java.io.*;
import java.net.*;

public class ClientUDP 
{
	public static void main(String[] args) throws Exception 
	{
		DatagramSocket sock = new DatagramSocket();
		byte[] data = "Hello World".getBytes();
		InetAddress addr = InetAddress.getLocalHost();

		System.out.println("Envoi: Hello World");
		sock.send(new DatagramPacket(data, data.length, addr, 1234));

		byte[] buf = new byte[1024];
		DatagramPacket rep = new DatagramPacket(buf, buf.length);
		sock.receive(rep);
		String echo = new String(rep.getData(), 0, rep.getLength());
		System.out.println("Réponse du serveur:"+echo);
		sock.close();
	}
}
