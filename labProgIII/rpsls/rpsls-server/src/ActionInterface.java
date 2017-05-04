import java.rmi.*;

public interface ActionInterface extends Remote{
	public void play(String player,char move) throws RemoteException;
	public boolean compare(String player,String enemy) throws RemoteException;
	public String debug() throws RemoteException;
}
