import java.util.*;

public class Chat extends Observable implements Iterable {

	private List<Message> messages;

	public Chat() {
		this.messages = new ArrayList<Message>();
	}

	public void ajouter(Message m) {
		this.messages.add(m);
		this.setChanged();
		this.notifyObservers();
	}

	@Override
	public Iterator<Message> iterator() {
		return Collections.unmodifiableList(this.messages).iterator();
	}


}
// Chat -> Observable. Quand on ajoute on notify les observateur

//1)
//Expliquer pourquoi l’attribut messages est déclaré du type List mais initialisé en utilisant
//la classe ArrayList.
	//ArrayList implemente List, donc en déclarant message comme une List on ne va pouvoir avoir
	//accés que aux méthodes de l'interface List (sauf faire un transtypage dynamique (ArrayList) message)
//2)
//Expliquer pourquoi ce serait une mauvaise idée d’avoir un accesseur getMessages() qui
//retourne la valeur de l’attribut messages.
	//Car message est une poignée vers un Objet list donc l'utilisateur aurait donc accés au l'Objet
	//il pourrais modifier les messages précédent sans utiliser les méthodes du programme.
