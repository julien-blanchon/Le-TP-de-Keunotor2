package editeur;

import editeur.commande.*;
import menu.Menu;

/** Un éditeur pour une ligne de texte.  Les commandes de
 * l'éditeur sont accessibles par un menu.
 *
 * @author	Xavier Crégut -> Julien Blanchon
 * @version	1.6 -> 1.7
 */
public class EditeurLigne {

	/** La ligne de notre éditeur */
	private Ligne ligne;

	/** Le menu courant de l'éditeur */
	protected Menu menuEditeur;
	/** Le menu principal de l'éditeur */
	private Menu menuPrincipal;
		// Remarque : Tous les éditeurs ont le même menu mais on
		// ne peut pas en faire un attribut de classe car chaque
		// commande doit manipuler la ligne propre à un éditeur !
	/** Le menu des opérations curseur.*/
	private Menu menuCurseur;


	/** Initialiser l'éditeur à partir de la ligne à éditer. */
	public EditeurLigne(Ligne l) {
		ligne = l;

		// Créer le menu principal
		menuPrincipal = new Menu("Menu principal");
		menuCurseur = new Menu("Menu Curseur");
		menuEditeur = menuPrincipal;

		menuPrincipal.ajouter("Ajouter un texte en fin de ligne",
					new CommandeAjouterFin(ligne));
		menuPrincipal.ajouter("Supprimer le caractère sous le curseur",
				new CommandeSupprimerSousCurseur(ligne));
		menuPrincipal.ajouter("Sous-Menu: Déplacer le curseur",
				new CommandeMenu(menuEditeur, menuCurseur));

		menuCurseur.ajouter("Avancer le curseur d'un caractère",
				new CommandeCurseurAvancer(ligne));
		menuCurseur.ajouter("Reculer le curseur d'un caractère",
				new CommandeCurseurReculer(ligne));
		menuCurseur.ajouter("Placer le curseur au début de la ligne",
				new CommandeCurseurDebut(ligne));
		menuCurseur.ajouter("Retour Menu Principale",
				new CommandeMenu(menuEditeur, menuPrincipal));

	}

	public void editer() {
		do {
			// Afficher la ligne
			System.out.println();
			ligne.afficher();
			System.out.println();

			// Afficher le menu
			menuEditeur.afficher();

			// Sélectionner une entrée dans le menu
			menuEditeur.selectionner();

			// Valider l'entrée sélectionnée
			menuEditeur.valider();

		} while (! menuEditeur.estQuitte());
	}

}
