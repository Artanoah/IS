package gamelogic;

public class PossibilityToValueMapping {
	Binding b;
	int val;
	
	public PossibilityToValueMapping(Binding b, int val) {
		this.b = b;
		this.val = val;
	}

	public Binding getBinding() {
		return b;
	}

	public int getVal() {
		return val;
	}
	
	
}
