package gamelogic;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Binding implements Serializable {
	private static final long serialVersionUID = -5379741264396918811L;
	
	private static final String SEPERATOR = ",";
	int size;
	Map<String, Integer> binding;
	
	public Binding(int size) {
		this.binding = new HashMap<String, Integer>();
		
		for (int x = 0; x < size; x++) {
			for (int y = 0; y < size; y++) {
				setBinding(x, y, 0);
			}
		}
	}
	
	public boolean hasSomeoneWon() {

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

		// Ueberpruefe Zeilen
		return lines.stream().anyMatch(list -> {
			int init = list.get(0);
			for (Integer i : list) {
				if (i == 0 || i != init) {
					return false;
				}
			}
			return true;
		});
	}

	public boolean isDraw() {
		return !binding.values().contains(0);
	}
	
	public Integer getBinding(int xCoord, int yCoord) {
		return binding.get(xCoord + SEPERATOR + yCoord);
	}
	
	public void setBinding(int xCoord, int yCoord, int value) {
		binding.put(xCoord + SEPERATOR + yCoord, value);
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
}
