
import afficheur.Ecran;
import java.awt.Color;

/**
 * Exemple d'utilisation de la classe Ecran.
 */
class ExempleEcran {

	public static void main(String[] args) {
		// Construire un écran
		Ecran monEcran = new Ecran("monEcran", 400, 250, 15);
		// Dessiner un point vert de coordonnées (1, 2)
		monEcran.dessinerPoint(1, 2, Color.green);
		// Dessiner un segment rouge d'extrémités (6, 2) et (11, 9)
		monEcran.dessinerLigne(6.0, 2.0, 11.0, 9.0, Color.red);
		// Dessiner un cercle jaune de centre (4, 3) et rayon 2.5
		monEcran.dessinerCercle(4.0, 3.0, 2.5, Color.yellow);
		// Dessiner le texte "Premier dessin" en bleu à la position (1, -2)
		monEcran.dessinerTexte(1.0, -2.0, "Premier dessin", Color.blue);
	}

}
