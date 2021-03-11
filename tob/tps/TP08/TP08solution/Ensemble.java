/** Définition d'un ensemble d'entier. */
public interface Ensemble {
	/** Obtenir le nombre d'éléments dans l'ensemble.
	 * @return nombre d'éléments dans l'ensemble.  */
	int cardinal();

	/** Savoir si l'ensemble est vide.
	 * @return Est-ce que l'ensemble est vide ? */
	boolean estVide();

	/** Savoir si un élément est présent dans l'ensemble.
	 * @param x l'élément cherché
	 * @return x est dans l'ensemble */
	boolean contient(int x);

	/** Ajouter un élément dans l'ensemble.
	 * @param x l'élément à ajouter */
	void ajouter(int x);

	/** Enlever un élément de l'ensemble.
	  * @param x l'élément à supprimer */
	void supprimer(int x);

}
