package gamelogic;

import java.util.Scanner;


public class ManualPlayer extends Player {
	Scanner sc = new Scanner(System.in);
	
	public ManualPlayer() {
		super();
	}

	@Override
	public int[] makeTurn() {
		System.out.println("Player " + id + " Choose your next field. Input in the form \"<xpos>,<ypos>\"");
		String[] input = sc.nextLine().replaceAll(" ", "").split(",");
		int[] output = {Integer.parseInt(input[0]), Integer.parseInt(input[1])};
		return output;
	}

}
