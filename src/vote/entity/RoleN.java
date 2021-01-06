package vote.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "RoleN")
public class RoleN implements java.io.Serializable{
	@Id
	@GeneratedValue
	private Integer id;
	private String name;
	private static final long serialVersionUID = 1L;
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "role")
	private Set<UsersRole> usersRoleses = new HashSet<UsersRole>(0);
	
	public Set<UsersRole> getUsersRoleses() {
		return usersRoleses;
	}
	public void setUsersRoleses(Set<UsersRole> usersRoleses) {
		this.usersRoleses = usersRoleses;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
