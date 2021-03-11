package editeur.commande;

import editeur.Ligne;

/** Positionner le curseur au début de la ligne.
 * @author	Julien Blanchon
 * @version	1.0
 */
public class CommandeCurseurDebut
        extends CommandeLigne
{

    /** Initialiser la ligne sur laquelle travaille
     * cette commande.
     * @param l la ligne
     */
    //@ requires l != null;	// la ligne doit être définie
    public CommandeCurseurDebut(Ligne l) {
        super(l);
    }

    public void executer() {
        //while (ligne.getCurseur() != 0 ) {
        //    ligne.reculer();
        //}
        System.out.println(ligne.getCurseur());
        ligne.raz();
    }

    public boolean estExecutable() {
        return (ligne.getLongueur() > 0 && ligne.getCurseur() > 1);
    }

}
