/** Tester le polymorphisme (principe de substitution) et la liaison
 * dynamique.
 * @author	Xavier Crégut
 * @version	1.5
 */
public class TestPolymorphisme {

	/** Méthode principale */
	public static void main(String[] args) {
		// Créer et afficher un point p1
		Point p1 = new Point(3, 4);	// Est-ce autorisé ? Pourquoi ?
		//! Oui car new Point() est bien un Point.
		p1.translater(10,10);		// Quel est le translater exécuté ?
		//! Le translater de Point
		System.out.print("p1 = "); p1.afficher (); System.out.println ();
										// Qu'est ce qui est affiché ?
										//! (14, 14)

		// Créer et afficher un point nommé pn1
		PointNomme pn1 = new PointNomme (30, 40, "PN1");
										// Est-ce autorisé ? Pourquoi ?
		//! Oui car newPointNomme est bien un PointNomme
		pn1.translater (10,10);		// Quel est le translater exécuté ?
		//! Le translater de Point.
		System.out.print ("pn1 = "); pn1.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?
										//! PN1 : (30, 50)

		// Définir une poignée sur un point
		Point q;

		// Attacher un point à q et l'afficher
		q = p1;				// Est-ce autorisé ? Pourquoi ?
		// Oui car g et p1 sont de la même classe Point.
		System.out.println ("> q = p1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?
										//! q = (13, 14)

		// Attacher un point nommé à q et l'afficher
		q = pn1;			// Est-ce autorisé ? Pourquoi ?
		//! Oui car q est de classe Point et pn1 hérite de la classe Point
		System.out.println ("> q = pn1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?
										//! Usage de (Point) afficher
										//! q = (30, 50)

		// Définir une poignée sur un point nommé
		PointNomme qn;
	/*
		// Attacher un point à q et l'afficher
		qn = p1;			// Est-ce autorisé ? Pourquoi ?
		//! Non car qn est de type PointNomme et p1 est de type Point. (p1 au dessus de qn) !
		System.out.println ("> qn = p1;");
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?
										// Erreur avant!
	*/

		// Attacher un point nommé à qn et l'afficher
		qn = pn1;			// Est-ce autorisé ? Pourquoi ?
		//! Oui pn1 et qn de type PointNomme
		System.out.println ("> qn = pn1;");
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?
										//! qn = PN1:(30, 50)

		double d1 = p1.distance (pn1);	// Est-ce autorisé ? Pourquoi ?
		//! Oui car pn1 hérite de Point donc on peut utiliser Point.distance((Point)) avec (PointNomme)
		// qui hérite de (Point).
		System.out.println ("distance = " + d1);

		double d2 = pn1.distance (p1);	// Est-ce autorisé ? Pourquoi ?
		//! Oui même raison que pour p1.distance(pn1), on utilise aussi Point.distance((Point)).
		System.out.println ("distance = " + d2);

		double d3 = pn1.distance (pn1);	// Est-ce autorisé ? Pourquoi ?
		//! Oui on utilise aussi Point.distance((Point)).
		System.out.println ("distance = " + d3);

	/*
		System.out.println ("> qn = q;");
		qn = q;				// Est-ce autorisé ? Pourquoi ?
							//! Non PointNomme <-!- Point
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?
										//! Erreur avant.
	 */

		System.out.println ("> qn = (PointNomme) q;");
		qn = (PointNomme) q;		// Est-ce autorisé ? Pourquoi ?
									//! PointNomme --> PointNomme
		System.out.print ("qn = "); qn.afficher(); System.out.println ();

	/*
		System.out.println ("> qn = (PointNomme) p1;");
		qn = (PointNomme) p1;		// Est-ce autorisé ? Pourquoi ?
									//! Non PointNomme -!-> (PointNomme) Point.
									//! Car la conversion ne peut pas être réalise.
									//! C'est PointNomme qui hérite de Point et pas l'inverse.
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
	*/

	/*
	On peut attacher q aussi bien a un Point ou un PointNomme car q est un pointeur (poignée) pour un
	PointNomme.
	Ainsi comme PointNomme hérite de Point avec le principe de substitution, Point est une classe
	convenable pour	q.
	 */

	}

}
