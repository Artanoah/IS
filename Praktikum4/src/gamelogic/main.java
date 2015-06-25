package gamelogic;

import java.io.IOException;

public class main {
	
	private static final int SIZE = 6;

	public static void main(String[] args) throws ClassNotFoundException, IOException {
		Player p1 = new AIPlayerMultithreaded();
		Player p2 = new AIPlayerMultithreaded();
		Game game = new Game(SIZE, p1, p2);
		int winner = 0;
		
		long startTime = System.currentTimeMillis();
		
		do {
			game.print();
			winner = game.makeTurn();
		} while (winner == 0);
		
		long endTime = System.currentTimeMillis();
		
		game.print();
		System.out.println("Player " + winner + " wins");
		System.out.println("Calculation-Time: " + (endTime - startTime));
	}
}
