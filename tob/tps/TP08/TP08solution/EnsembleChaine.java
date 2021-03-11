/** Définition d'un ensemble d'entiers implanté sous d'éléments chaînés.
 *  @author	Xavier Crégut &lt;prenom.nom@enseeiht.fr&gt;
  */
public class EnsembleChaine implements Ensemble {
	protected Cellule premiere;	// accès à la première cellule

	/** Construction d'un ensemble vide. */
	public EnsembleChaine() {
		this.premiere = null;
	}

	private int getNombreCellule(Cellule cellule) {
		if (cellule == null) {
			return 0;
		} else {
			return 1 + getNombreCellule(cellule.suivante);
		}
	}

	@Override public int cardinal() {
		return getNombreCellule(this.premiere);
	}

	/** Savoir si un élément est dans une cellule ou l'une de ses suivantes.
	 * @param x l'élément cherché
	 * @param cellule la cellule où commence la recherche
	 * @return vrai si l'élément x est trouvé
	 */
	private boolean contient(int x, Cellule cellule) {
		if (cellule == null) {
			return false;
		} else if (cellule.element == x) {
			return true;
		} else {
			return this.contient(x, cellule.suivante);
		}
	}

	@Override public boolean estVide() {
		return this.premiere == null;
	}
	
	@Override public boolean contient(int x) {
		return contient(x, this.premiere);
	}
	
	@Override public void ajouter(int x) {
		if (!contient(x)) {
			this.premiere = new Cellule(x, this.premiere);
		}
	}

	@Override public void supprimer(int x) {
		if (this.premiere != null) {
			if (this.premiere.element == x) {
				// Supprimer la première cellule
				this.premiere = this.premiere.suivante;
			} else {
				// Chercher la cellule avant l'élément à supprimer
				Cellule curseur = this.premiere;
				while (curseur.suivante != null && curseur.suivante.element != x) {
					curseur = curseur.suivante;
				}

				if (curseur.suivante != null) {
					curseur.suivante = curseur.suivante.suivante;
				}
			}
		}
	}
	
	@Override public String toString() {
		String resultat = "{";
		if (this.premiere != null) {
			// traiter la première cellule
			resultat += " " + this.premiere.element;

			// traiter les autres cellules
			Cellule curseur = this.premiere.suivante;
			while (curseur != null) {
				resultat += " " + curseur.element;
				curseur = curseur.suivante;
			}
		}
		resultat += " }";
		return resultat;
	}

}
