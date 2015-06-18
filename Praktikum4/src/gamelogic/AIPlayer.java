package gamelogic;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AIPlayer extends Player {
	private static final int MAX_DEPTH = 10;
	private static Binding staticBinding = null;
	
	@Override
	public int[] makeTurn() throws ClassNotFoundException, IOException {
		staticBinding = null;
		max(board.binding.getDeepCopy(), this, MAX_DEPTH);
		return board.binding.getFirstDifference(staticBinding);
	}
	
	private static int max(Binding binding, Player player, int depth) throws ClassNotFoundException, IOException {
		if(depth == 0 || binding.hasSomeoneWon() || binding.isDraw()) {
			return binding.rating(player);
		}
		
		int best = Integer.MIN_VALUE;
		
		List<Binding> turnPossibilities = getAllPossibleNextTurnsForPlayer(binding, player);
		
		for(Binding turnPossibilitie : turnPossibilities) {
			int val = min(turnPossibilitie, board.getPlayerAfter(player), depth - 1);
			
			if(val > best) {
				best = val;
				if(depth == MAX_DEPTH) {
					staticBinding = turnPossibilitie;
				}
			}
			
		}
		return best;
	}
	
	private static int min(Binding binding, Player player, int depth) throws ClassNotFoundException, IOException {
		if(depth == 0 || binding.hasSomeoneWon() || binding.isDraw()) {
			return binding.rating(player);
		}
		
		int minWert = Integer.MAX_VALUE;
		
		List<Binding> turnPossibilities = getAllPossibleNextTurnsForPlayer(binding, player);
		
		for(Binding turnPossibilitie : turnPossibilities) {
			int val = max(turnPossibilitie, board.getPlayerAfter(player), depth - 1);
			if (val < minWert) {
				minWert = val;
			}
		}
		return minWert;
	}
	
	


	private static List<Binding> getAllPossibleNextTurnsForPlayer(Binding binding,
			Player player) throws ClassNotFoundException, IOException {
		List<Binding> akku = new ArrayList<Binding>();

		for (int yCoord = 0; yCoord < binding.getSize(); yCoord++) {
			for (int xCoord = 0; xCoord < binding.getSize(); xCoord++) {
				if (binding.isFieldEmpty(xCoord, yCoord)) {
					Binding possibleTurn = binding.getDeepCopy();
					possibleTurn.setBinding(xCoord, yCoord, player.getID());
					akku.add(possibleTurn);
				}
			}
		}

		return akku;
	}

	
}
