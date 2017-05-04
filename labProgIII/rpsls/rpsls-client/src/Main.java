import java.rmi.*;
import java.util.Scanner;

public class Main {
	public static void main (String[] args) {
		ActionInterface game;
		Scanner scanner = new Scanner(System.in);
		try {
			game = (ActionInterface)Naming.lookup("rmi://localhost/Action");
			


			
			char move = ' ';
			do{
				System.out.println("Diga seu nome, forasteiro!");
				String player = scanner.nextLine();
				
				System.out.println("Quem deseja desafiar?");
				String enemy = scanner.nextLine();
				int playerCount = 0;
				for(int t=0;t<5;t++){
					System.out.println(playerCount+" pontos \n"
							+ "Qual o seu movimento?\n"
							+ "r - pedra\trock\n"
							+ "p - papel\tpaper\n"
							+ "s - tesoura\tscissor\n"
							+ "L - largarto\tLizard\n"
							+ "S - spock\tSpock");
				
					move = scanner.nextLine().charAt(0);
					game.play(player,move);
					//System.out.println(game.debug());
					System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
					System.out.println(5);
					Thread.sleep(1000);
					System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
					System.out.println(4);
					Thread.sleep(1000);
					System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
					System.out.println(3);
					Thread.sleep(1000);
					System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
					System.out.println(2);
					Thread.sleep(1000);
					System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
					System.out.println(1);
					Thread.sleep(1000);
					System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
					System.out.println("FIGHT!");
					if(game.compare(player, enemy)){
						System.out.println("Boa champz!!");
						playerCount++;
					}else{
						System.out.println("Se deu mal!!");	
					}		
					
				}
				if(playerCount >=3){
					System.out.println("Parabens!! você ganhou!!!");
				}else{
					System.out.println("Perdeu seu n00b!");
				}
			}while(move != '\n');
			
			System.out.println("Result is :");

		}catch (Exception e) {
			System.out.println("exception: " + e);
		}
	}
}
