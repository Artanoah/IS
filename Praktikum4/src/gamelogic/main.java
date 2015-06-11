package gamelogic;

public class main {
	
	private static final int SIZE = 2;

	public static void main(String[] args) {
		Player p1 = new ManualPlayer();
		Player p2 = new ManualPlayer();
		Player p3 = new ManualPlayer();
		Player p4 = new ManualPlayer();
		Game game = new Game(SIZE, p1, p2, p3, p4);
		int winner = 0;
		
		do {
			game.print();
			winner = game.makeTurn();
		} while (winner == 0);
		
		System.out.println("Player " + winner + " wins");
	}

}
