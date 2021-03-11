/** Définir les propriétés d'un élément d'un schéma
 * @author  Julien Blanchon
 * @version 1.0
 */
public interface X {
    public static void main(String[] args) {

        /** Translater l'élément.
         * @param dx déplacement suivant l'axe des X
         * @param dy déplacement suivant l'axe des Y
         */
        void translater(double dx, double dy);

        /** Dessine l'élément sur afficheur.
         * @param afficheur Afficheur pour l'élément.
         */
        void dessiner(afficheur.Afficheur afficheur);

        /** Afficher l'élément.
         * */
        void afficher();
    }
}