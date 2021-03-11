import java.awt.Color;

/**
 * Cercle modélise un cercle géométrique dans un plan équipé d'un repère
 * cartésien. Un cercle peut être affiché et translaté.
 *
 * @author Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.1
 */
public class Cercle implements Mesurable2D {

    /** Point centre est le centre du Cercle.
     * @see Cercle#getCentre() (deepcopy)
     * @see Cercle#setCentre(Point)
     */
    private Point centre;

    /** double rayon est le rayon du Cercle.
     * @see Cercle#getRayon()
     * @see Cercle#setRayon(double)
     */
    private double rayon;

    /** Color couleur est la couleur du Cercle.
     * @see Cercle#getCouleur()
     * @see Cercle#setCouleur(Color)
     */
    private Color couleur;
    /* Remarque on aurait pu utiliser la couleur du Point centre.
    Mais ce n'est pas à proprement parler la couleur du cercle.
    Il aurait dont été judicieux de supprimer la couleur dans Point.java */

    /** double PI est la constante π de {@link Math#PI}.
     * @see Math#PI
     */
    public static final double PI = Math.PI;

    /** Construire un cercle à partir de son centre, de son rayon et sa couleur.
     * @param centre  centre du cercle (deep copy de centre)
     * @param rayon   rayon du cercle
     * @param couleur couleur du cercle
     * @throws AssertionError si rayon négatif ou centre non instancier.
     * @see Point#Point(double, double)
     */
    private Cercle(Point centre, double rayon, Color couleur) throws AssertionError {
        assert centre != null;
        assert rayon > 0.0;
        this.centre = new Point(centre.getX(), centre.getY());
        this.rayon = rayon;
        this.couleur = couleur;
    }

    /** Construire un cercle à partir de son centre et de son rayon.
     * Couleur par défaut à bleu.
     * @param centre centre du cercle (deep copy de centre)
     * @param rayon  rayon du cercle
     * @throws AssertionError si rayon négatif ou centre non instancier.
     * @see Cercle#Cercle(Point, double, Color)
     */
    public Cercle(Point centre, double rayon) throws AssertionError {
        this(centre, rayon, Color.blue);
    }

    /** Construire un cercle à partir de 2 points diamétralement opposés et de ça couleur.
     * @param p1      point appartenant au cercle
     * @param p2      point appartenant au cercle
     * @param couleur couleur du cercle
     * @throws AssertionError si p1, p2 ou couleur non instancier. Ou si p1==p2.
     * @see Point#Point(double, double)
     */
    public Cercle(Point p1, Point p2, Color couleur) throws AssertionError {
        assert p1 != null;
        assert p2 != null;
        assert p1.getX() != p2.getX() || p1.getY() != p2.getY();
        assert couleur != null;
        this.centre = new Point((p1.getX() + p2.getX()) / 2, (p1.getY() + p2.getY()) / 2);
        this.rayon = Math.abs(p1.distance(p2) / 2);
        this.couleur = couleur;
    }

    /** Construire un cercle à partir de 2 points diamétralement opposés.
     * Couleur par défaut à bleu.
     * @param p1 point appartenant au cercle
     * @param p2 point appartenant au cercle
     * @throws AssertionError si p1 non instancier ou rayon négatif
     * @see Cercle#Cercle(Point, Point, Color)
     */
    public Cercle(Point p1, Point p2) {
        this(p1, p2, Color.blue);
    }

    /** Renvoie un cercle construit à partir du centre et d'un point du cercle.
     * @param p1 centre du cercle
     * @param p2 point appartenant au cercle
     * @throws AssertionError si p1 ou p2 non instancier.
     * @return cercle
     * @see Cercle#Cercle(Point, double, Color)
     */
    public static Cercle creerCercle(Point p1, Point p2) throws AssertionError {
        assert p1 != null;
        assert p2 != null;
        return (new Cercle(p1, Math.abs(p1.distance(p2)), Color.blue));
    }

    /** Obtenir le centre du cercle.
     * @return centre du cercle
     * @see Cercle#centre
     * @see Cercle#setCentre(Point)
     * @see Point#getX()
     * @see Point#getY()
     */
    public Point getCentre() {
        return (new Point(this.centre.getX(), this.centre.getY()));
    }

    /** Obtenir le rayon du cercle.
     * @return rayon du cercle
     * @see Cercle#rayon
     * @see Cercle#setRayon(double)
     */
    public double getRayon() {
        return this.rayon;
    }

    /**
     * Obtenir la couleur du cercle.
     * @return couleur du cercle
     * @see Cercle#couleur
     * @see Cercle#setCouleur(Color)
     */
    public Color getCouleur() {
        return this.couleur;
    }

    /** Obtenir le diametre du cercle.
     * @return diametre du cercle
     * @see Cercle#rayon
     * @see Cercle#getRayon()
     * @see Cercle#setDiametre(double)
     */
    public double getDiametre() {
        return 2.0 * this.getRayon();
    }

    /** Conversion de Cercle en String.
     * @return description du cercle
     * @see Point#toString()
     */
    public String toString() {
        return "C" + rayon + "@" + this.centre;
    }

    /** Modifier le centre du cercle.
     * @param centre nouveau centre du cercle
     * @throws AssertionError si centre est non instancier
     * @see Cercle#rayon
     * @see Cercle#getCentre() (deepcopy)
     */
    public void setCentre(Point centre) throws AssertionError {
        assert centre != null;
        this.centre = centre;
    }

    /** Modifier le rayon du cercle.
     * @param rayon nouveau rayon du cercle
     * @throws AssertionError si rayon est négatif
     * @see Cercle#rayon
     * @see Cercle#getRayon()
     */
    public void setRayon(double rayon) throws AssertionError {
        assert rayon > 0.0;
        this.rayon = rayon;
    }

    /** Modifier la couleur du cercle.
     * @param couleur nouvelle couleur du cercle
     * @throws AssertionError si couleur est non instancier.
     * @see Cercle#couleur
     * @see Cercle#getCouleur()
     */
    public void setCouleur(Color couleur) throws AssertionError {
        assert couleur != null;
        this.couleur = couleur;
    }

    /** Modifier le diametre du cercle.
     * @param diametre nouveau diametre du cercle
     * @throws AssertionError si diametre est négatif
     * @see Cercle#rayon
     * @see Cercle#setRayon(double)
     * @see Cercle#getDiametre()
     */
    public void setDiametre(double diametre) throws AssertionError {
        assert diametre > 0.0;
        this.setRayon(diametre / 2.0);
    }

    /** Est ce que le point p1 est contenu dans le cercle ?
     * @param p1 point non null
     * @throws AssertionError si p1 est null
     * @return si p1 est dans le cercle
     * @see Point#distance(Point)
     * @see Math#abs(double)
     */
    public boolean contient(Point p1) throws AssertionError {
        assert p1 != null;
        return (Math.abs(this.getCentre().distance(p1)) <= this.rayon);
    }

    /** Renvoie le perimetre du cercle.
     * @return perimetre du cercle
     * @see Mesurable2D#perimetre()
     * @see Cercle#getRayon()
     * @see Cercle#PI
     */
    public double perimetre() {
        double leRayon = this.getRayon();
        return 2.0 * PI * leRayon;
    }

    /** Renvoie l'aire du cercle.
     * @return aire du cercle
     * @see Mesurable2D#aire()
     * @see Cercle#getRayon()
     * @see Cercle#PI
     */
    public double aire() {
        double leRayon = this.getRayon();
        return PI * leRayon * leRayon;
    }

    /** Translater le cercle de dx en x et dy en y.
     * @param dx translation en x
     * @param dy translation en y
     * @see Cercle#centre
     * @see Point#translater(double, double)
     */
    public void translater(double dx, double dy) {
        this.centre.translater(dx, dy);
    }
}
