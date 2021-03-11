package allumettes;

/** Exception qui indique que le joueur triche.
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version	1.0
 */
public class OperationInterditeException extends CoupInvalideException {

    /** Initialiser OperationInterditeException à partir du nombre d'allumettes
     * volée et le problème constaté. Par exemple, on peut avoir nombre
     * d'allumettes qui vaut 0 et le problème "< 1".
     * @param nb le nombre d'allumettes volée.
     * @param probleme description du probleme.
     */
    public OperationInterditeException(int nb, String probleme) {
        super(nb, "Nombre d'allumettes volée : " + nb + " (" + probleme + ")");
    }

}