package gamelogic;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class AIPlayerMultithreaded extends Player {

	private static volatile Binding staticBinding = null;

	@Override
	public int[] makeTurn() throws ClassNotFoundException, IOException {
		staticBinding = null;
		max(board.binding.getDeepCopy(), this, this, MAX_DEPTH);
		return board.binding.getFirstDifference(staticBinding);
	}

	private static int max(Binding binding, Player playerOnTurn,
			Player aiPlayer, int depth) {
		if (depth == 0 || binding.hasSomeoneWon() || binding.isDraw()) {
			return binding.rating(aiPlayer);
		}

		int best = Integer.MIN_VALUE;

		List<Binding> turnPossibilities = getAllPossibleNextTurnsForPlayer(
				binding, playerOnTurn);

		List<PossibilityToValueMapping> outcommings = turnPossibilities
				.stream()
				.parallel()
				.map(turnPossibilitie -> new PossibilityToValueMapping(
						turnPossibilitie, min(turnPossibilitie,
								board.getPlayerAfter(playerOnTurn), aiPlayer,
								depth - 1)))
				.collect(Collectors.toList());

		for (PossibilityToValueMapping o : outcommings) {
			if (o.getVal() > best) {
				best = o.getVal();
				if (depth == MAX_DEPTH) {
					staticBinding = o.getBinding();
				}
			}
		}
		return best;
	}

	private static int min(Binding binding, Player playerOnTurn,
			Player aiPlayer, int depth) {
		if (depth == 0 || binding.hasSomeoneWon() || binding.isDraw()) {
			return binding.rating(aiPlayer);
		}

		int minWert = Integer.MAX_VALUE;

		List<Binding> turnPossibilities = getAllPossibleNextTurnsForPlayer(
				binding, playerOnTurn);
		
		List<PossibilityToValueMapping> outcommings = turnPossibilities
				.stream()
				.parallel()
				.map(turnPossibilitie -> new PossibilityToValueMapping(
						turnPossibilitie, max(turnPossibilitie,
								board.getPlayerAfter(playerOnTurn), aiPlayer,
								depth - 1)))
				.collect(Collectors.toList());

		for (PossibilityToValueMapping o : outcommings) {
			if (o.getVal() < minWert) {
				minWert = o.getVal();
			}
		}
		return minWert;
	}

	private static List<Binding> getAllPossibleNextTurnsForPlayer(
			Binding binding, Player player) {
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
