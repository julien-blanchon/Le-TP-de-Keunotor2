/** Définition d'un ensemble d'entier. */
public interface EnsembleOrdonne extends Ensemble {
	// Caractérisation du min (quand il existe !)
	// ------------------------------------------
	/*@ public invariant ! estVide() ==>
			contient(min());               // un élément de l'ensemble
	    public invariant ! estVide() ==>
			min() == (\min int x; contient(x); x);    // le plus petit
	@*/

	/**  Obtenir le minimum de l'ensemble.
	 * @return le plus petit élément de l'ensemble  */
	int min();

}
