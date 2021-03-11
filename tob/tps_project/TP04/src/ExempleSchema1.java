import afficheur.AfficheurSVG;
import afficheur.Ecran;

/** Construire le schéma proposé dans le sujet de TP avec des points,
  * et des segments.
  *
  * @author	Xavier Crégut
  * @version	$Revision: 1.7 $
  */
public class ExempleSchema1 {

	/** Construire le schéma et le manipuler.
	  * Le schéma est affiché.
	  * @param args les arguments de la ligne de commande
	  */
	public static void main(String[] args)
	{
		// Créer les trois segments
		Point p1 = new Point(3, 2);
		Point p2 = new Point(6, 9);
		Point p3 = new Point(11, 4);
		Segment s12 = new Segment(p1, p2);
		Segment s23 = new Segment(p2, p3);
		Segment s31 = new Segment(p3, p1);

		// Créer le barycentre
		double sx = p1.getX() + p2.getX() + p3.getX();
		double sy = p1.getY() + p2.getY() + p3.getY();
		Point barycentre = new Point(sx / 3, sy / 3);

		// Afficher le schéma
		System.out.println("Le schéma est composé de : ");
		s12.afficher();		System.out.println();
		s23.afficher();		System.out.println();
		s31.afficher();		System.out.println();
		barycentre.afficher();	System.out.println();

		// Afficher sur l'écran
		Ecran monEcran = new Ecran("monEcran", 600, 400, 20);
		p1.dessiner(monEcran);
		p2.dessiner(monEcran);
		p3.dessiner(monEcran);
		s12.dessiner(monEcran);
		s23.dessiner(monEcran);
		s31.dessiner(monEcran);
		barycentre.dessiner(monEcran);

		//Exercice 3: Translation
		double dx = 4.0;
		double dy = -3.0;
		p1.translater(dx, dy);
		p2.translater(dx, dy);
		p3.translater(dx, dy);
		s12.translater(dx, dy);
		s23.translater(dx, dy);
		s31.translater(dx, dy);
		barycentre.translater(dx, dy);
		Ecran monEcran2 = new Ecran("monEcran2", 600, 400, 20);
		p1.dessiner(monEcran2);
		p2.dessiner(monEcran2);
		p3.dessiner(monEcran2);
		s12.dessiner(monEcran2);
		s23.dessiner(monEcran2);
		s31.dessiner(monEcran2);
		barycentre = new Point(sx / 3, sy / 3);
		barycentre.dessiner(monEcran2);

		//Exercice 4: SVG
		AfficheurSVG ecranSVG = new AfficheurSVG("monSVG", "maDescription", 400, 20);
		p1.dessinerSVG(ecranSVG);
		p2.dessinerSVG(ecranSVG);
		p3.dessinerSVG(ecranSVG);
		s12.dessinerSVG(ecranSVG);
		s23.dessinerSVG(ecranSVG);
		s31.dessinerSVG(ecranSVG);
		barycentre.dessinerSVG(ecranSVG);
		ecranSVG.ecrire("schema.svg");

		//Exercice 5:
		AfficheurTexte ecranTxt = new AfficheurTexte();
		p1.dessinerTXT(ecranTxt);
		p2.dessinerTXT(ecranTxt);
		p3.dessinerTXT(ecranTxt);
		s12.dessinerTXT(ecranTxt);
		s23.dessinerTXT(ecranTxt);
		s31.dessinerTXT(ecranTxt);



	}

}
