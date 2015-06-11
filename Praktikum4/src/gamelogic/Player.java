package gamelogic;


public abstract class Player {
	private static Generator gen = new Generator(1);
	private Game board;
	protected final int id;
	
	public abstract int[] makeTurn();
	
	public Player() {
		id = gen.getID();
	}
	
	public void setGame(Game game) {
		board = game;
	}
	
	public int getID() {
		return id;
	}
}
