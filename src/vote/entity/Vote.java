package vote.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Vote")
public class Vote {
	@Id
	@GeneratedValue
	private Integer idVote;
	@ManyToOne
	@JoinColumn(name="Id")
	private Selection selection;
	@ManyToOne
	@JoinColumn(name="Email")
	private Users user;
	public Integer getIdVote() {
		return idVote;
	}
	public void setIdVote(Integer idVote) {
		this.idVote = idVote;
	}
	public Selection getSelection() {
		return selection;
	}
	public void setSeletion(Selection selection) {
		this.selection = selection;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	
	
	
}
