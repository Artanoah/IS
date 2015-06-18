package gamelogic;

import java.io.IOException;

public class main {
	
	private static final int SIZE = 3;

	public static void main(String[] args) throws ClassNotFoundException, IOException {
		Player p1 = new AIPlayer();
		Player p2 = new AIPlayer();
		Game game = new Game(SIZE, p1, p2);
		int winner = 0;
		
		do {
			game.print();
			winner = game.makeTurn();
		} while (winner == 0);
		
		game.print();
		System.out.println("Player " + winner + " wins");
	}

}
