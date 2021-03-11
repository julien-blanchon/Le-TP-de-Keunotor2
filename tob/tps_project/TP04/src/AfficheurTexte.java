import afficheur.Afficheur;

import java.awt.*;

public class AfficheurTexte implements Afficheur {

    public void dessinerPoint(double x, double y, Color c){
        System.out.println("Point {");
        System.out.println("\t x = "+ x+ "");
        System.out.println("\t y = "+ y+ "");
        System.out.println("\t couleur = "+ c+ "");
        System.out.println("}");
    }
    public void dessinerLigne(double x1, double y1, double x2, double y2, Color c){
        System.out.println("Ligne {");
        System.out.println("\t x1 = "+ x1+ "");
        System.out.println("\t y1 = "+ y1+ "");
        System.out.println("\t x2 = "+ x2+ "");
        System.out.println("\t y2 = "+ y2+ "");
        System.out.println("\t couleur = "+ c+ "");
        System.out.println("}");
    }
    public void dessinerCercle(double x, double y, double rayon, Color c){
        System.out.println("Cercle {");
        System.out.println("\t centre_x = "+ x+ "");
        System.out.println("\t centre_y = "+ y+ "");
        System.out.println("\t rayon = "+ rayon+ "");
        System.out.println("\t couleur = "+ c+ "");
        System.out.println("}");
    }
    public void dessinerTexte(double x, double y, String texte, Color c){
        System.out.println("Texte {");
        System.out.println("\t x = "+ x+ "");
        System.out.println("\t y = "+ y+ "");
        System.out.println("\t valeur = "+ texte+ "");
        System.out.println("\t couleur = "+ c+ "");
        System.out.println("}");
    }

}
