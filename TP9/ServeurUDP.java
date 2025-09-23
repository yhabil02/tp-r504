import java.io.*;
import java.net.*;

public class ServeurUDP 
{
	public static void main(String[] args) throws Exception 
	{
		DatagramSocket sock = new DatagramSocket(1234);
		byte[] buf = new byte[1024];
		while (true) {
			System.out.println("-Waiting data");
			DatagramPacket p = new DatagramPacket(buf, buf.length);
			sock.receive(p);
			String msg = new String(p.getData(), 0, p.getLength());
			System.out.println("Reçu:"+msg);
			sock.send(new DatagramPacket(p.getData(), p.getLength(), p.getAddress(), p.getPort()));
		}
	}
} 
