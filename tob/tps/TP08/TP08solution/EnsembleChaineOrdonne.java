/** Définition d'un ensemble d'entiers implanté sous d'éléments chaînés.
 *  @author	Xavier Crégut &lt;prenom.nom@enseeiht.fr&gt;
  */
public class EnsembleChaineOrdonne extends EnsembleChaine implements EnsembleOrdonne {
	
	@Override public void ajouter(int x) {
		if (this.premiere == null || x < this.premiere.element) {
			// Insérer en tête
			this.premiere = new Cellule(x, this.premiere);
		} else {
			// Trouver la cellule après laquelle insérer
			Cellule curseur = this.premiere;
			while (curseur.suivante != null
					&& curseur.suivante.element < x) {
				curseur = curseur.suivante;
			}

			if (curseur.element != x) {
				curseur.suivante = new Cellule(x, curseur.suivante);
			}
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
	
	@Override public int min() {
		return this.premiere.element;
	}

}
