package allumettes;

/** Exception qui indique qu'un joueur a du abandonner la partie.
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version	1.0
 */
public class AbandonException extends Exception {

    /** Initialiser AbandonException à partir d'un texte problème.
     * @param probleme description du probleme.
     */
    public AbandonException(String probleme) {
        super(probleme);
    }

    /** Initialiser AbandonException.
     * Pas de description du probleme.
     */
    public AbandonException() {
        this(null);
    }

}
