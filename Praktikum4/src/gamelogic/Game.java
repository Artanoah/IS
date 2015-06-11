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

	int size;
	List<Player> players;
	Binding binding;
	Iterator<Player> playerIterator;

	public Game(int size, Player... players) {
		this.size = size;
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
	 */
	public int makeTurn() {
		Player nextPlayer = getNextPlayer();

		int[] choice = nextPlayer.makeTurn();
		int xCoord = choice[0];
		int yCoord = choice[1];

		// Existiert das gewaehlte Feld?
		if (binding.getBinding(xCoord, yCoord) == null) {
			throw new IllegalArgumentException("Choose a not existing field");
		}

		// Ist das existierende Feld verfuegbar?
		if (!binding.getBinding(xCoord, yCoord).equals(0)) {
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

	/**
	 * Creates a deep copy of the binding in this game
	 * 
	 * @return
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	public Binding getBindingCopy() throws IOException, ClassNotFoundException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ObjectOutputStream oos = new ObjectOutputStream(baos);
		oos.writeObject(binding);
		oos.close();
		String obj = Base64.getEncoder().encodeToString(baos.toByteArray());
		byte[] data = Base64.getDecoder().decode(obj);
		ObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(data));
		Object o = ois.readObject();
		ois.close();
		return (Binding) o;
	}
	
	public void print() {
		binding.print();
	}
}
