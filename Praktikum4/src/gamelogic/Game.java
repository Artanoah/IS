package gamelogic;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Iterator;
import java.util.List;

public class Game {

	List<Player> players;
	Binding binding;
	Iterator<Player> playerIterator;

	public Game(int size, Player... players) {
		this.binding = new Binding(size);
		this.players = new ArrayList<Player>(Arrays.asList(players));
		this.playerIterator = this.players.iterator();

		for (Player p : this.players) {
			p.setGame(this);
		}
	}

	/**
	 * Returns <code>0</code> if the turn is finished and no player has won by
	 * now. </br> Returns <code>-1</code> if a draw appeared. </br> Returns
	 * another positive <code>int</code> which represents the player who won, if
	 * the game has been finished.
	 * 
	 * @return <code>int</code>
	 * @throws IOException 
	 * @throws ClassNotFoundException 
	 */
	public int makeTurn() throws ClassNotFoundException, IOException {
		Player nextPlayer = getNextPlayer();

		int[] choice = nextPlayer.makeTurn();
		int xCoord = choice[0];
		int yCoord = choice[1];

		// Existiert das gewaehlte Feld?
		if (binding.getBinding(xCoord, yCoord) == -1) {
			throw new IllegalArgumentException("Choose a not existing field");
		}

		// Ist das existierende Feld verfuegbar?
		if (!(binding.getBinding(xCoord, yCoord) == 0)) {
			throw new IllegalArgumentException("Choose already binded field");
		}

		// Setze das Feld
		binding.setBinding(xCoord, yCoord, nextPlayer.getID());

		if (binding.hasSomeoneWon()) {
			return nextPlayer.getID();
		} else if (binding.isDraw()) {
			return -1;
		} else {
			return 0;
		}
	}

	private Player getNextPlayer() {
		if (playerIterator.hasNext()) {
			return playerIterator.next();
		} else {
			playerIterator = players.iterator();
			return getNextPlayer();
		}
	}
	
	public Player getPlayerAfter(Player player) {
		int playerIndex = players.indexOf(player);
		if(playerIndex < 0) {
			throw new IllegalArgumentException("Player " + player.getID() + " not in this game");
		} else if(playerIndex == (players.size() - 1)) {
			return players.get(0);
		} else {
			return players.get(playerIndex + 1);
		}
	}

	/**
	 * Creates a deep copy of the binding in this game
	 * 
	 * @return
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	public Binding getBindingCopy() throws IOException, ClassNotFoundException {
		return binding.getDeepCopy();
	}
	
	public void print() {
		binding.print();
	}
}
