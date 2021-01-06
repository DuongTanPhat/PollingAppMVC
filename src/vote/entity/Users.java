package vote.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

@Entity
@Table(name="Users", uniqueConstraints = @UniqueConstraint(columnNames = "Email"))
public class Users implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private String password;
	private String fullname;
	private Boolean gender;
	@Column(name="Birthday")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birthday;
	private String photo;
	@Id
	private String email;
	private String phone;
	private Boolean ban;
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "user")
	private Set<UsersRole> usersRoleses = new HashSet<UsersRole>(0);
	
	public Set<UsersRole> getUsersRoleses() {
		return usersRoleses;
	}
	public void setUsersRoleses(Set<UsersRole> usersRoleses) {
		this.usersRoleses = usersRoleses;
	}
	public Boolean getBan() {
		return ban;
	}
	public void setBan(Boolean ban) {
		this.ban = ban;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Boolean getGender() {
		return gender;
	}
	public void setGender(Boolean gender) {
		this.gender = gender;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Transient
	  public List<GrantedAuthority> getAuthorities() {
	    List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
	    for (UsersRole usersRoles: this.usersRoleses) {
	      authorities.add(new SimpleGrantedAuthority(usersRoles.getRole().getName()));
	    }
	    return authorities;
	  }

}
