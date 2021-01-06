package vote.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "UsersRole")
public class UsersRole implements java.io.Serializable  {
	 private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private Integer id;
	@ManyToOne
	@JoinColumn(name="Email")
	private Users user;
	@ManyToOne
	@JoinColumn(name="IdRole")
	private RoleN role;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public RoleN getRole() {
		return role;
	}
	public void setRole(RoleN role) {
		this.role = role;
	}

}
