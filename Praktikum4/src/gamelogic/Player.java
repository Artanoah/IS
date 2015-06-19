package gamelogic;

import java.io.IOException;

public abstract class Player {
	private static Generator gen = new Generator(1);
	protected static Game board;
	protected final int id;
	protected static final int MAX_DEPTH = 4;

	/**
	 * @return List&lt;Integer&gt; List, whichs first index (0) is the
	 *         xcoordinate of the turn to make, and whichst second index (1) is
	 *         the ycoordinate.
	 * 
	 * @throws ClassNotFoundException
	 * @throws IOException
	 */
	public abstract int[] makeTurn() throws ClassNotFoundException, IOException;

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
