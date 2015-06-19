package gamelogic;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class Binding implements Serializable {
	private static final long serialVersionUID = -5379741264396918811L;

	private static final String SEPERATOR = ",";
	final int size;
	protected Map<String, Integer> binding;
	private List<List<Integer>> winningLines;

	public Binding(int size) {
		this.binding = new HashMap<String, Integer>();
		this.size = size;

		for (int x = 0; x < size; x++) {
			for (int y = 0; y < size; y++) {
				setBinding(x, y, 0);
			}
		}
		
		winningLines = getWinningLines();
	}

	/**
	 * Returns true if and only if some player has a winning binding in this
	 * object.
	 * 
	 * @return
	 */
	public boolean hasSomeoneWon() {
		List<List<Integer>> lines = winningLines;

		// Ueberpruefe Zeilen
		return lines.stream().anyMatch(list -> {
			int init = list.get(0);
			for (int i : list) {
				if (i == 0 || i != init) {
					return false;
				}
			}
			return true;
		});
	}

	/**
	 * Returns the ID of the winning player if one exists, or returns -1, if
	 * noone wins.
	 * 
	 * @return
	 */
	public int getWinner() {
		List<List<Integer>> lines = winningLines;

		outerloop: for (List<Integer> line : lines) {
			int init = line.get(0);
			for (int playerID : new HashSet<Integer>(line)) {
				if (playerID != init || playerID == 0) {
					continue outerloop;
				}
			}
			return init;
		}
		return -1;
	}

	private List<List<Integer>> getWinningLines() {
		// Generiere Zeilen
		List<List<Integer>> lines = new ArrayList<List<Integer>>();

		for (int y = 0; y < size; y++) {
			List<Integer> line = new ArrayList<Integer>();
			lines.add(line);

			for (int x = 0; x < size; x++) {
				line.add(getBinding(x, y));
			}
		}

		// Generiere Spalten
		for (int x = 0; x < size; x++) {
			List<Integer> column = new ArrayList<Integer>();
			lines.add(column);

			for (int y = 0; y < size; y++) {
				column.add(getBinding(x, y));
			}
		}

		// Generiere Diagonale
		List<Integer> d1 = new ArrayList<Integer>();
		List<Integer> d2 = new ArrayList<Integer>();
		lines.add(d1);
		lines.add(d2);

		for (int i = 0; i < size; i++) {
			d1.add(getBinding(i, i));
			d2.add(getBinding(i, size - i - 1));
		}

		return lines;
	}

	/**
	 * Returns true if and only if no turn can be made and no one has won
	 * 
	 * @return
	 */
	public boolean isDraw() {
		if (hasSomeoneWon()) {
			return false;
		} else {
			return !binding.values().contains(0);
		}
	}

	/**
	 * Returns the binding on the x-coordinate and y-coordinate. The binding
	 * represents either the player who marked this field (>0) or that no player
	 * marked this field jet (=0)
	 * 
	 * @param xCoord
	 * @param yCoord
	 * @return
	 */
	public int getBinding(int xCoord, int yCoord) {
		Integer temp = binding.get(xCoord + SEPERATOR + yCoord);
		if (temp == null) {
			return -1;
		} else {
			return temp;
		}
	}

	public void setBinding(int xCoord, int yCoord, int value) {
		binding.put(xCoord + SEPERATOR + yCoord, value);
		winningLines = getWinningLines();
	}

	public void print() {
		String akku = "##### GAME #####\n";

		for (int y = 0; y < size; y++) {
			for (int x = 0; x < size; x++) {
				akku += " " + getBinding(x, y);
			}
			akku += "\n";
		}

		System.out.println(akku);
	}

	public int getSize() {
		return size;
	}

	/**
	 * Creates a deep copy of this binding.
	 * 
	 * @return
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	public Binding getDeepCopy() {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ObjectOutputStream oos;
		Object o = null;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(this);
			oos.close();
			String obj = Base64.getEncoder().encodeToString(baos.toByteArray());
			byte[] data = Base64.getDecoder().decode(obj);
			ObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(
					data));
			o = ois.readObject();
			ois.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return (Binding) o;
	}

	public int compareTo(Binding other, Player firstPlayer) {
		int playerID = firstPlayer.getID();
		// Wenn firstPlayer beides gewinnt
		if (this.getWinner() == playerID && other.getWinner() == playerID) {
			return 0;
			// Wenn firstPlayer this gewinnt
		} else if (this.getWinner() == playerID) {
			return 1;
			// Wenn firstPlayer other gewinnt
		} else if (other.getWinner() == playerID) {
			return -1;
			// Wenn jemand anders beides gewinnt
		} else if (this.getWinner() > 0 && other.getWinner() > 0) {
			return 0;
			// Wenn jemand anders this gewinnt
		} else if (this.getWinner() > 0) {
			return -1;
			// wenn jemand anders other gewinnt
		} else if (other.getWinner() > 0) {
			return 1;
			// Wenn niemand direkt gewinnt
		} else {
			int thisAkku = this.getNumberOfWinPossibilities(playerID);
			int otherAkku = other.getNumberOfWinPossibilities(playerID);
			
			if(thisAkku != 0 || otherAkku != 0) {
				System.out.println("Got it");
			}
			
			for(int tempPlayerID : this.binding.values()) {
				if(tempPlayerID == playerID) {
					continue;
				} else {
					thisAkku -= this.getNumberOfWinPossibilities(tempPlayerID);
				}
			}
			
			for(int tempPlayerID : other.binding.values()) {
				if(tempPlayerID == playerID) {
					continue;
				} else {
					otherAkku -= other.getNumberOfWinPossibilities(tempPlayerID);
				}
			}
			
			return thisAkku > otherAkku ? 1 : 0;
		}
	}
	
	public int rating(Player player) {
		int winner = this.getWinner();
		int playerID = player.getID();
		
		if(winner == playerID) {
			return 100;
		} else if(winner > 0) {
			return -100;
		} else if(isDraw()) {
			return 0;
		} else {
			int thisAkku = this.getNumberOfWinPossibilities(playerID);
			
			for(int tempPlayerID : this.binding.values()) {
				if(tempPlayerID == playerID || tempPlayerID == 0) {
					continue;
				} else {
					thisAkku -= this.getNumberOfWinPossibilities(tempPlayerID);
				}
			}
			
			return thisAkku;
		}
	}

	private int getNumberOfWinPossibilities(int playerID) {
		List<List<Integer>> lines = winningLines;
		return lines
				.stream()
				.map(list -> list.stream().allMatch(
						element -> element == playerID
								|| element == 0) ? 1 : 0)
				.reduce(0, (a, b) -> a + b);
	}
	
	public boolean isFieldEmpty(int xCoord, int yCoord) {
		return getBinding(xCoord, yCoord) == 0;
	}
	
	public int[] getFirstDifference(Binding other) {
		for(int yCoord = 0; yCoord < size; yCoord++) {
			for(int xCoord = 0; xCoord < size; xCoord++) {
				int b1 = this.getBinding(xCoord, yCoord);
				int b2 = other.getBinding(xCoord, yCoord);
				if(b1 != b2) {
					int[] temp = {xCoord, yCoord};
					return temp;
				}
			}
		}
		int[] temp = {-1, -1};
		return temp;
	}
	
	@Override
	public String toString() {
		String akku = "";

		for (int y = 0; y < size; y++) {
			for (int x = 0; x < size; x++) {
				akku += " " + getBinding(x, y);
			}
			akku += "\n";
		}
		return akku;
	}
}
