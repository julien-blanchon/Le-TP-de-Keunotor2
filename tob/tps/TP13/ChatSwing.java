import javax.swing.*;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import java.awt.*;
import java.awt.event.*;
import java.util.Iterator;
import java.util.Observable;
import java.util.Observer;

public class ChatSwing extends JPanel implements Observer {
    final private Chat leChat = new Chat();
    final private JScrollPane nomTxt = new JScrollPane();
    final private JButton bA = new JButton("A");
    final private JTextPane text = new JTextPane();
    private Document doc = text.getDocument();

    public ChatSwing() {
        super();
        this.setLayout(new GridLayout(2, 1));
        this.add(bA);
        this.bA.addActionListener(new ActionBoutonA());
        text.setEditable(false);
        this.add(text);
        leChat.addObserver(this);
    }

    public class ControleurChat extends JPanel implements Observer {
        final private JLabel lePseudo = new JLabel();
        final private JTextField leTxt = new JTextField();
        final private JButton leBoutonOk = new JButton();

        public ControleurChat(String pseudo){
            this.setLayout(new BorderLayout());
            this.lePseudo.setText(pseudo);
            this.add(lePseudo);
            this.leTxt.setEditable(true);
            this.add(leTxt);
            this.leBoutonOk.setText("Ok");
            this.add(leBoutonOk);

            this.leBoutonOk.addActionListener(new ActionOk());


        }
        @Override
        public void update(Observable o, Object arg) {

        }

        private class ActionOk implements ActionListener {

            @Override
            public void actionPerformed(ActionEvent e) {

            }
        }
    }


    public static JFrame newJFrame(String titre) {
        JFrame fenetre = new JFrame(titre);
        ChatSwing leChatSwing = new ChatSwing();
        fenetre.getContentPane().add(leChatSwing);
        fenetre.pack();
        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        return fenetre;
    }


    public static void fenetre(int i) {
        JFrame frame1 = newJFrame("Fenêtre" + i);
        frame1.setVisible(true);
    }

    public static void main(String[] args) {
        fenetre(1);
        System.out.println("Fin du programme principal !");
    }

    @Override
    public void update(Observable chat, Object arg) {
        try {
            doc.insertString(doc.getLength(), "heldlo\n", null);
        } catch (BadLocationException e) {
            e.printStackTrace();
        }
    }

    private class ActionBoutonA implements ActionListener {
        public void actionPerformed(ActionEvent evt) {
            try {
                doc.insertString(doc.getLength(), "hello\n", null);
                leChat.ajouter(new MessageTexte("Moi", "sj"));
                doc.remove(0, doc.getLength());
                for (Iterator<Message> it = leChat.iterator(); it.hasNext(); ) {
                    Message msg = it.next();
                    doc.insertString(doc.getLength(), msg.getPseudo() + " : " + msg.getTexte() + "\n", null);
                    System.out.println(msg.getTexte());
                }
            } catch (BadLocationException e) {
                e.printStackTrace();
            }
        }
    }
}
