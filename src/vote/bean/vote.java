package vote.bean;

import java.time.*;
import java.util.Calendar;
import java.util.Date;

import vote.entity.Topics;

public class vote implements Comparable<Object> {
	private Topics topic;
	private Integer countVote;
	private Float rate;
	private Integer ex;

	public Integer getEx() {
		return ex;
	}

	public void setEx() {
		Date now = new Date();
		Date now2 = new Date(now.getYear(), now.getMonth(), now.getDate());
		
		if (topic.getExp() != null) {
			Calendar c1 = Calendar.getInstance();
	        Calendar c2 = Calendar.getInstance();
	        c1.setTime(now2);
	        c2.setTime(topic.getExp());

	        // Công thức tính số ngày giữa 2 mốc thời gian:
	        long noDay = (c2.getTime().getTime() - c1.getTime().getTime()) / (24 * 3600 * 1000);
			ex = (int)noDay;
		} else
			ex = null;

	}

	public Topics getTopic() {
		return topic;
	}

	public void setTopic(Topics topic) {
		this.topic = topic;
	}

	public Integer getCountVote() {
		return countVote;
	}

	public void setCountVote(Integer countVote) {
		this.countVote = countVote;
	}

	public Float getRate() {
		return rate;
	}

	public void setRate(Float rate) {
		this.rate = rate;
	}

	@Override
	public int compareTo(Object o) {
		vote f = (vote) o;
		return this.countVote - f.countVote;
	}
}
