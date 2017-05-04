import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;

public class Action extends UnicastRemoteObject implements ActionInterface{
	private HashMap< String, Character> players;
	public static void main (String[] argv) {
		try {
			Action action = new Action();			   		   
			Naming.rebind("rmi://localhost/Action", action);

			System.out.println("Action Server is ready.");
		}catch (Exception e) {
			System.out.println("Action Server failed: " + e);
		}

	}
	
	protected Action() throws RemoteException {
		players = new HashMap<>();
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void play(String player,char move) throws RemoteException {
		players.put(player,move);
	}
	
	@Override
	public boolean compare(String player,String enemy) throws RemoteException {
		switch (""+players.get(player)+players.get(enemy)) {
		case "sp":
		case "pr":
		case "rL":
		case "LS":
		case "Ss":
		case "sL":
		case "pS":
		case "rs":
		case "Lp":
		case "Sr":
			return true;
		}
		return false;
	}
	
	@Override
	public String debug(){
		String str = "";
		for (String player : players.keySet()){
			str += player + ": "+ players.get(player)+"\n";
		}
		return str;
	}
}
