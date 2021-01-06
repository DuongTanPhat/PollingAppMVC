package vote.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Topics")
public class Topics {
@Id
@GeneratedValue
private Integer id;
@Column(name="Name")
private String name;
@ManyToOne
@JoinColumn(name="TagId")
private Tag tag;
private String descriptions;
@ManyToOne
@JoinColumn(name="Email")
private Users user;
private String photo;
@OneToMany(mappedBy = "topic",fetch = FetchType.EAGER)
private Collection<Selection> selection;
private Boolean isMany;
private Boolean isCreate;
@Column(name="Exp")
@Temporal(TemporalType.DATE)
@DateTimeFormat(pattern="yyyy-MM-dd")
private Date exp;

public Date getExp() {
	return exp;
}
public void setExp(Date exp) {
	this.exp = exp;
}
public Boolean getIsMany() {
	return isMany;
}
public void setIsMany(Boolean isMany) {
	this.isMany = isMany;
}
public Boolean getIsCreate() {
	return isCreate;
}
public void setIsCreate(Boolean isCreate) {
	this.isCreate = isCreate;
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
public Tag getTag() {
	return tag;
}
public void setTag(Tag tag) {
	this.tag = tag;
}
public String getDescriptions() {
	return descriptions;
}
public void setDescriptions(String descriptions) {
	this.descriptions = descriptions;
}
public Users getUser() {
	return user;
}
public void setUser(Users user) {
	this.user = user;
}

public String getPhoto() {
	return photo;
}
public void setPhoto(String photo) {
	this.photo = photo;
}
public Collection<Selection> getSelection() {
	return selection;
}
public void setSelection(Collection<Selection> selection) {
	this.selection = selection;
}



}
