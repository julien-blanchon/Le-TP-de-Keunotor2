/** Une cellule encapsule un élément et un accès
 * à une autre cellule dite suivante.
 */
class Cellule {
	int element;
	Cellule suivante;

	Cellule(int element, Cellule suivante) {
		this.element = element;
		this.suivante = suivante;
	}

	@Override public String toString() {
		// Attention, il ne faut pas que les cellules forment un cycle !
		return "[" + this.element + "]--"
				+ (this.suivante == null ? 'E' : ">" + this.suivante); 
	}

}
