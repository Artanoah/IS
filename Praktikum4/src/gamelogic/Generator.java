package gamelogic;

public class Generator {
	private int counter;
	
	public Generator(int startIndex) {
		this.counter = startIndex;
	}
	
	public int getID() {
		int temp = counter;
		counter++;
		return temp;
	}
}
