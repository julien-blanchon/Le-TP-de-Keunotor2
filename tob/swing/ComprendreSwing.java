import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class ComprendreSwing extends JPanel {
	// JPanel conteneurs général de fenetre
	final private JLabel nomTxt = new JLabel("Nom : ");
	// JLabel pour afficher une valeur
	final private JTextField nom = new JTextField(25);
	// JTextField : zone de texte éditable ;
	final private JButton bA = new JButton("A");
	// JButton : comme un JLabel mais a vocation à être appuyé ;
	final private JButton bB = new JButton("B");
	final private JButton bC = new JButton("C");
	final private JButton bQ = new JButton("Q");

	public ComprendreSwing() {
		super();
		this.setLayout(new BorderLayout());

		JPanel J_NORTH = new JPanel();
		J_NORTH.setLayout(new GridLayout(1, 3));
		J_NORTH.add(bA);
		J_NORTH.add(bB);
		J_NORTH.add(bC);

		JPanel J_CENTER = new JPanel();
		J_CENTER.setLayout(new GridLayout(1, 2));
		J_CENTER.add(nomTxt);
		nomTxt.setHorizontalAlignment(JLabel.CENTER);

		J_CENTER.add(nom);

		JPanel J_SOUTH = new JPanel();
		J_SOUTH.setLayout(new BorderLayout());
		J_SOUTH.add(bQ);
		this.bQ.addActionListener(new ActionQuitter());
		this.bC.addActionListener(new ActionEffacer());
		this.add(J_NORTH, BorderLayout.NORTH);
		this.add(J_CENTER, BorderLayout.CENTER);
		this.add(J_SOUTH, BorderLayout.SOUTH);

		ActionTrace trace = new ActionTrace();
		bA.addMouseListener(trace);
		bB.addMouseListener(trace);
	}

	public class ActionQuitter implements ActionListener {
		public void actionPerformed(ActionEvent evt) {
			System.out.println("Quitter");
			//fenetre.dispose()  (fenetre est JFrame fenetre) Pas accessible dans ActionQuitter
			// Il faut donc le passer a ComprendreSwing !
			//System.exit(0);
		}
	}

	public class ActionTrace extends MouseAdapter {

		@Override
		public void mouseClicked(MouseEvent ev) {
			System.out.println("Appui sur "
					+ ((JButton) ev.getSource()).getText());
		}

		@Override
		public void mouseEntered(MouseEvent ev) {
			JButton source = (JButton) ev.getSource();
			System.out.println("Entrée dans "
					+ source.getText());
		}

		@Override
		public void mouseExited(MouseEvent ev) {
			JButton source = (JButton) ev.getSource();
			System.out.println("Sortie de "
					+ source.getText());
		}

	}

	public static JFrame newJFrame(String titre) {
		JFrame fenetre = new JFrame(titre);
		ComprendreSwing comprendre = new ComprendreSwing();
		fenetre.getContentPane().add(comprendre);
		fenetre.pack();
		fenetre.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		return fenetre;
	}


	public static void exemple1() {
		JFrame frame1 = newJFrame("Fenêtre1");
		JFrame frame2 = newJFrame("Fenêtre2");
		frame2.setLocation(300, 100);
		frame1.setVisible(true);
		frame2.setVisible(true);
	}

	public static void main(String[] args) {
		EventQueue.invokeLater(ComprendreSwing::exemple1);
			// On demande au fil d'exécutin de Swing d'exécuter la méthode
			// exemple1 de la classe ComprendreSwing.
		System.out.println("Fin du programme principal !");
	}

	private class ActionEffacer implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			nom.setText("");
		}
	}
}
