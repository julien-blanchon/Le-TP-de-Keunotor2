package allumettes;

import java.util.Scanner;

/** Défini les propriétés de base de la stratégie "humain".
 * d'un joueur du jeu des allumettes
 * @author  Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 2.0
 */
public class Humain implements Strategie {
    /**Regex de la représentation String d'un entier naturelle.*/
    private static String regexEntierNaturelle = "[+-]?[0-9]+";
    /**Nom de la stratégie.*/
    public static final String NOM_STRATEGIE = "humain";
    /**Scanner communs à l'ensemble des stratégie Humaine.*/
    private static final Scanner SCANNER = new Scanner(System.in);

    /** Obtenir le nom de la stratégie : humain.
     * @return nom de la stratégie
     */
    @Override
    public String getNom() {
        return NOM_STRATEGIE;
    }

    /** Obtenir le choix de la stratégie humain: Choix humain (System.in).
     * @return nombre d'allumettes à prendre.
     * @throws ConfigurationException si il y a un problème de configuration
     * @throws CoupInvalideException si le coup est invalide
     * (OperationInterditeException).
     */
    @Override
    public int getPrise(Jeu jeu, String prenom) throws
            ConfigurationException, CoupInvalideException {
        boolean fin = false;
        String saisie;
        do {
            System.out.print(prenom + ", combien d'allumettes ? ");
            saisie = this.getSaisie(prenom);
            switch (saisie.toLowerCase()) {
                case "triche": this.tricher(jeu);
                    break;
                default:
                    if (this.isNaturelle(saisie)) {
                        fin = true;
                    } else {
                        System.out.println("Vous devez donner un entier.");
                    }
            }
        } while (!fin);
        int prise = this.convertirEntier(saisie);
        return prise;
    }

    private void tricher(Jeu jeu) throws CoupInvalideException {
        jeu.retirer(1);
    }


    /** Obtenir la saisie String de l'humain.
     * @see Scanner
     * @see System#in
     * @param prenom le prenom de l'utilisateur
     * @return la saisie clavier
     */
    private String getSaisie(String prenom) {
        String saisie;
        if (SCANNER.hasNextLine()) {
            saisie = SCANNER.nextLine();
        } else {
            throw new ConfigurationException("Pas de nouvelle entrée pour " + prenom);
        }
        return saisie;
    }


    /** Est ce que la saisie est un entier naturelle.
     * @return si la saisie est un entier naturelle.
     * @param saisie le texte saisie par l'utilisateur.
     */
    private boolean isNaturelle(String saisie) {
        return saisie.matches(this.regexEntierNaturelle);
    }

    /** Convertir la saisie en entier.
     * @see Integer#parseInt(String)
     * @param saisie le texte saisie de l'utilisateur
     * @return le nombre d'allumette a prendre
     * @throws ConfigurationException si saisie n'est pas
     * convertible en prise
     */
    private int convertirEntier(String saisie) throws ConfigurationException {
        int prise;
        try {
            prise = Integer.parseInt(saisie);
        } catch (NumberFormatException e) {
            prise  = 0;
            throw new ConfigurationException("C'est étrange "
                    + saisie
                    + " ne peut pas être convertie en entier...");
        }
        return prise;
    }
}
