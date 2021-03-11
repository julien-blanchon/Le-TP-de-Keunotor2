/** Point
 * @author  Julien Blanchon
 * @version 1.0
 */
public class Point {
    //! attributs
    private double x, y;

    //! constructeur
    public Point(double x, double y){
        this.x = x;
        this.y = y;
    }

    //! methodes
    public void setX(double x){
        this.x = x;
    }

    public void setY(double y){
        this.y = y;
    }

    public void translater(double dx, double dy){
        //this.setX(this.getX()+dx);
        this.x = this.x + dx;
        //this.setY(this.getY()+dy);
        this.y = this.y + dy;
    }

    public void afficher(){
        System.out.println("(" + this.x + ", " + this.y + ")");
    }
    
    public double getX(){
        return this.x;
    }

    public double getModule(){
        return Math.sqrt(this.x * this.x + this.y * this.y);
    }
}

