package vote.bean;

import vote.entity.Selection;

public class VoteSelect implements Comparable<Object>{
	private Selection select;
	private Integer countVote;
	private Boolean voted = false;
	
	public Boolean getVoted() {
		return voted;
	}
	public void setVoted(Boolean voted) {
		this.voted = voted;
	}
	public Selection getSelect() {
		return select;
	}
	public void setSelect(Selection select) {
		this.select = select;
	}
	public Integer getCountVote() {
		return countVote;
	}
	public void setCountVote(Integer countVote) {
		this.countVote = countVote;
	}
	@Override
	public int compareTo(Object o) {
	    VoteSelect f = (VoteSelect) o; 
	    return this.countVote - f.countVote ;
	}
}
