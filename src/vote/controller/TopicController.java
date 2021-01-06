package vote.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vote.bean.VoteSelect;
import vote.entity.Evaluate;
import vote.entity.Selection;
import vote.entity.Tag;
import vote.entity.Topics;
import vote.entity.Users;
import vote.entity.Vote;
@Transactional
@Controller
public class TopicController {
	Users user = null;
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	@RequestMapping(value = "/vote/{IdTopic}")
	public String topic(ModelMap model, @PathVariable("IdTopic") Integer idTopic, HttpSession session2) {
		Users u = (Users) session2.getAttribute("user");
		Session session = factory.getCurrentSession();
		
		String hql4 = "from Topics where id='" + idTopic + "'";
		Query query4 = session.createQuery(hql4);
		List<Topics> list = query4.list();
		Topics topic;
		if(list.isEmpty()) {
			topic = null;
			
		}
		else{
			topic = (Topics) list.get(0);
			session2.setAttribute("topic", topic);
		}
		
		//Topics topic = (Topics) session.get(Topics.class, idTopic);
		// model.addAttribute("topic", topic);
		
//		for (Selection a : topic.getSelection()) {
//			System.out.println(a.getName());
//		}
//		System.out.println(topic);
		model.addAttribute("where", 2);
		model.addAttribute("select", new Selection());
		model.addAttribute("evaluate", new Evaluate());
		if (isVoted(idTopic, u.getEmail())) {
			String hql2 = String.format(
					"Select count(selection.id) as count,selection.id as id from Vote where selection.topic.id=%d group by selection.id",
					idTopic);
			Query query2 = session.createQuery(hql2);
			List result = query2.list();
			Map<Integer, Integer> b = new HashMap<>();
			List<VoteSelect> listVote = new ArrayList<>();
			for (Object object : result) {
				Object[] a = (Object[]) object;
				int count = ((Number) a[0]).intValue();
				int key = (int) (a[1]);
				b.put(key, count);
			}
			String hql = String.format("Select selection.id from Vote where user.email='%s' and selection.topic.id=%d",
					u.getEmail(), idTopic);
			Query query = session.createQuery(hql);
			List<Integer> result2 = query.list();
			for (Selection object : topic.getSelection()) {
				VoteSelect a = new VoteSelect();
				a.setSelect(object);
				if (b.get(object.getId()) != null) {
					a.setCountVote(b.get(object.getId()));
				} else
					a.setCountVote(0);
				for (int i = 0; i < result2.size(); i++) {
					if (result2.get(i) == object.getId()) {
						a.setVoted(true);
					}
				}
				listVote.add(a);
			}
			Collections.sort(listVote, Collections.reverseOrder());
			model.addAttribute("countSelect", listVote);
			String hql3 = String.format("from Evaluate where topic.id=%d", idTopic);
			Query query3 = session.createQuery(hql3);
			List<Evaluate> result3 = query3.list();
			model.addAttribute("listEvaluate", result3);
			return "infoTopicVoted";
		}
		return "infoTopic";
	}

	@RequestMapping(value = "/vote/{IdTopic}", params = "insertSelect", method = RequestMethod.POST)
	public String Topic(ModelMap model, @ModelAttribute("select") Selection select, HttpSession session2) {
		Session session = factory.openSession();
		Topics topic = (Topics) session2.getAttribute("topic");
		Date now = new Date();
		Date now2 = new Date(now.getYear(), now.getMonth(), now.getDate());
		if (topic.getExp() != null) {
			if (topic.getExp().compareTo(now2)<0)return "redirect:/welcome.htm";
		}
		Transaction t = session.beginTransaction();
		
		Topics a = (Topics) session2.getAttribute("topic");
		if(!select.getName().isEmpty()) {
		select.setTopic(a);
		try {
			session.save(select);
			t.commit();
			// re.addFlashAttribute("message", "Them moi thanh cong!");
			model.addAttribute("message", "Them moi thanh cong!");
			session.close();

		} catch (Exception e) {
			t.rollback();
			// re.addFlashAttribute("message", "Them moi that bai!");
			model.addAttribute("message", "Them moi that bai!");
			session.close();
			return "home";
		}
		}
		String b = String.format("redirect:/vote/%s.htm", String.valueOf(a.getId()));
		return b;
	}

	@RequestMapping(value = "/vote/{IdTopic}", params = "insertEvaluate", method = RequestMethod.POST)
	public String Evaluate(ModelMap model, @PathVariable("IdTopic") Integer idTopic,
			@ModelAttribute("evaluate") Evaluate eva, HttpSession session2) {
		Session session = factory.openSession();
		user = (Users) session2.getAttribute("user");
		Transaction t = session.beginTransaction();
		String hql = String.format("from Evaluate where topic.id=%d and user.email='%s'", idTopic, user.getEmail());
		Query query2 = session.createQuery(hql);
		List<Evaluate> result = query2.list();
		if (result.isEmpty()) {
			Topics a = (Topics) session2.getAttribute("topic");
			eva.setTopic(a);
			
			eva.setUser(user);
			try {
				session.save(eva);
				t.commit();
				// re.addFlashAttribute("message", "Them moi thanh cong!");
				model.addAttribute("message", "Them moi thanh cong!");
				session.close();

			} catch (Exception e) {
				t.rollback();
				// re.addFlashAttribute("message", "Them moi that bai!");
				model.addAttribute("message", "Them moi that bai!");
				session.close();
				return "home";
			}
			String b = String.format("redirect:/vote/%s.htm", String.valueOf(a.getId()));
			return b;
		} else {
			Topics a = (Topics) session2.getAttribute("topic");
			Evaluate eva2 = result.get(0);
			eva2.setRate(eva.getRate());
			eva2.setDescriptions(eva.getDescriptions());
			try {
				session.update(eva2);
				t.commit();
				// re.addFlashAttribute("message", "Them moi thanh cong!");
				model.addAttribute("message", "Sua danh gia thanh cong!");
				session.close();

			} catch (Exception e) {
				t.rollback();
				// re.addFlashAttribute("message", "Them moi that bai!");
				model.addAttribute("message", "Sua danh gia that bai!");
				session.close();
				return "home";
			}
			String b = String.format("redirect:/vote/%s.htm", String.valueOf(a.getId()));
			return b;
		}
	}

	@RequestMapping(value = "/select/{IdTopic}/{IdSelect}")
	public String vote(ModelMap model, @PathVariable("IdTopic") Integer idTopic,
			@PathVariable("IdSelect") Integer idSelect, HttpSession session2) {
		Users u = (Users) session2.getAttribute("user");
		Session session = factory.openSession();
		Topics topic = (Topics) session2.getAttribute("topic");
		Date now = new Date();
		Date now2 = new Date(now.getYear(), now.getMonth(), now.getDate());
		if (topic.getExp() != null) {
			if (topic.getExp().compareTo(now2)<0)return "redirect:/welcome.htm";
		}
		Transaction t = session.beginTransaction();
		String hql = "from Vote where user.email='" + u.getEmail() + "'and selection.id='" + idSelect + "'";
		Query query = session.createQuery(hql);
		List<Vote> list = query.list();
		if (!list.isEmpty()) {
			// user = (Users) session.get(Users.class, email);
			try {
				// Vote vote2 = (Vote)session.get(Vote.class, );
				// session.update(vote);
				session.delete(list.get(0));
				t.commit();
				model.addAttribute("message", "Xóa bầu chọn thành công!");
			} catch (Exception e) {
				t.rollback();
				model.addAttribute("message", "Xóa bầu chọn thất bại!");
			} finally {
				session.close();
			}
			String a = String.format("redirect:/vote/%d.htm", idTopic);
			return a;
		} else {
			Vote vote = new Vote();
			vote.setUser(u);
			vote.setSeletion((Selection) session.get(Selection.class, idSelect));
			if (!isVoted(idTopic, u.getEmail()) || topic.getIsMany()) {
				try {
					session.save(vote);
					t.commit();
					model.addAttribute("message", "Bầu chọn thành công!");
				} catch (Exception e) {
					t.rollback();
					model.addAttribute("message", "Bầu chọn thất bại!");
				} finally {
					session.close();
				}
				String a = String.format("redirect:/vote/%d.htm", idTopic);
				return a;
			} else {
				try {
					String hql3 = "from Vote where user.email='" + u.getEmail() + "'and selection.topic.id='" + idTopic
							+ "'";
					Query query3 = session.createQuery(hql3);
					List<Vote> list3 = query3.list();
					Vote updateVote = list3.get(0);
					updateVote.setSeletion((Selection) session.get(Selection.class, idSelect));
					session.update(updateVote);
					t.commit();
					model.addAttribute("message", "Sửa bầu chọn thành công!");
				} catch (Exception e) {
					t.rollback();
					model.addAttribute("message", "Sửa bầu chọn thất bại!");
				} finally {
					session.close();
				}

				String a = String.format("redirect:/vote/%d.htm", idTopic);
				return a;
			}
		}
	}
	public Boolean isVoted(Integer idTopic, String email) {
		Session session = factory.getCurrentSession();
		String hql = "from Vote where user.email='" + email + "'and selection.topic.id='" + idTopic + "'";
		Query query = session.createQuery(hql);
		List<Object> list = query.list();
		if (!list.isEmpty()) {
			user = (Users) session.get(Users.class, email);
			return true;
		}
		return false;
	}
	@RequestMapping(value = "/topic/insert", method = RequestMethod.GET)
	public String insertTopic(ModelMap model, HttpSession session2) {
		model.addAttribute("where", 4);
		model.addAttribute("topic", new Topics());
		return "insert";
	}

	@RequestMapping(value = "/topic/insert", method = RequestMethod.POST)
	public String insertTopic(ModelMap model, @ModelAttribute("topic") Topics topic,
			@RequestParam("photo2") MultipartFile photo, HttpSession session2, BindingResult errors) {
		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
				&& (!photo.isEmpty())) {
			errors.rejectValue("photo", "topic", "The image type for the file is invalid");
		}
		if (errors.hasErrors()) {
			model.addAttribute("where", 4);
			return "insert";
		} else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			Users u = (Users) session2.getAttribute("user");
			topic.setUser(u);
			try {
				int i = 0;
				String name = photo.getOriginalFilename();
				if (!name.isEmpty()) {
					String photoPath = context.getRealPath("/files/" + name);
					while (Files.exists(Paths.get(photoPath))) {
						i++;
						photoPath = context.getRealPath("/files/" + i + name);
					}
					if (i != 0) {
						name = i + name;
					}
					photo.transferTo(new File(photoPath));
					//System.out.println(photoPath);
					topic.setPhoto("files/" + name);
				}
				session.save(topic);
				// session2.setAttribute("topicInsert", topic);
				t.commit();
				model.addAttribute("message", "Them moi thanh cong!");
				session.close();

			} catch (Exception e) {
				t.rollback();
				model.addAttribute("message", "Them moi that bai!");
				session.close();
				return "home";
			}
			String a = String.format("redirect:/vote/%s.htm", topic.getId());
			return a;
		}
	}
	@RequestMapping(value = "/topic/edit/{idTopic}", method = RequestMethod.GET)
	public String edit(ModelMap model, @PathVariable("idTopic") Integer idTopic, HttpSession session2) {
		Session session = factory.getCurrentSession();
		Topics topic = (Topics) session.get(Topics.class, idTopic);
		user = (Users) session2.getAttribute("user");
		if (topic.getUser().getEmail().equals(user.getEmail()) || user.getEmail().equals("admin@admin")) {
			model.addAttribute("topic", topic);
			model.addAttribute("where", 4);
			// model.addAttribute("photo2",topic.getPhoto());
			return "edit";
		} else
			return "redirect:/login.htm";
	}

	@RequestMapping(value = "/topic/edit/{idTopic}", method = RequestMethod.POST)
	public String edit(ModelMap model, @ModelAttribute("topic") Topics topic,
			@RequestParam("photo2") MultipartFile photo, HttpSession session2, @PathVariable("idTopic") Integer idTopic,
			BindingResult errors) {
		user = (Users) session2.getAttribute("user");
		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
				&& (!photo.isEmpty())) {
			errors.rejectValue("photo", "topic", "The image type for the file is invalid");
		}
		if (errors.hasErrors()) {
			model.addAttribute("where", 3);
			return "edit";
		} else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			Topics topic2 = (Topics) session.get(Topics.class, idTopic);
			if (topic2.getUser().getEmail().equals(user.getEmail()) || user.getEmail().equals("admin@admin")) {
				// Users u = (Users) session2.getAttribute("user");
				// topic.setUser(u);
				try {
					int i = 0;
					String name = photo.getOriginalFilename();
					if (!name.isEmpty()) {
						String photoPath = context.getRealPath("/files/" + name);
						while (Files.exists(Paths.get(photoPath))) {
							i++;

							photoPath = context.getRealPath("/files/" + i + name);

						}
						if (i != 0) {
							name = i + name;
						}
						// String photoPath = context.getRealPath("/files/"+ Math.random()+
						// photo.getOriginalFilename());
						photo.transferTo(new File(photoPath));
						//System.out.println(photoPath);
						topic2.setPhoto("files/" + name);
					}
					topic2.setName(topic.getName());
					topic2.setDescriptions(topic.getDescriptions());
					topic2.setTag(topic.getTag());
					topic2.setIsCreate(topic.getIsCreate());
					topic2.setIsMany(topic.getIsMany());
					topic2.setExp(topic.getExp());
					session.update(topic2);
					// session2.setAttribute("topicInsert", topic);
					t.commit();
					// re.addFlashAttribute("message", "Them moi thanh cong!");
					model.addAttribute("message", "Cap nhat thanh cong!");
					session.close();

				} catch (Exception e) {
					t.rollback();
					// re.addFlashAttribute("message", "Them moi that bai!");
					model.addAttribute("message", "Cap nhat that bai!");
					session.close();
					return "redirect:/welcome.htm";
				}
			} else
				return "redirect:/login.htm";
			String a = String.format("redirect:/vote/%s.htm", topic2.getId());
			return a;
		}

	}

	@RequestMapping(value = "/topic/delete/{idTopic}")
	public String delete(ModelMap model, @PathVariable("idTopic") Integer idTopic, HttpSession session2) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		user = (Users) session2.getAttribute("user");
		String a = String.format("redirect:/manager.htm");
		try {
			Topics topic2 = (Topics) session.get(Topics.class, idTopic);
			if (topic2.getUser().getEmail().equals(user.getEmail()) || user.getEmail().equals("admin@admin")) {
				String hql = "from Vote where selection.topic.id=" + idTopic + "";
				Query query = session.createQuery(hql);
				List<Vote> list = query.list();
				for (Vote vote : list) {
					session.delete(vote);
				}
				String hql2 = "from Selection where topic.id=" + idTopic + "";
				Query query2 = session.createQuery(hql2);
				List<Selection> list2 = query2.list();
				for (Selection vote : list2) {
					session.delete(vote);
				}
				String hql3 = "from Evaluate where topic.id=" + idTopic + "";
				Query query3 = session.createQuery(hql3);
				List<Evaluate> list3 = query3.list();
				for (Evaluate vote : list3) {
					session.delete(vote);
				}
				session.delete(topic2);
				t.commit();
				// re.addFlashAttribute("message", "Xoa thanh cong!");
				model.addAttribute("message", "Xoa thanh cong!");
				try {
				Topics temp = (Topics)session2.getAttribute("topic");
				if(topic2.getId()==temp.getId()) {
					session2.removeAttribute("topic");
				}}
				catch(Exception e){};
			} else
				a = "redirect:/login.htm";
		} catch (Exception e) {
			t.rollback();
			// re.addFlashAttribute("message", "Xoa that bai!");
			model.addAttribute("message", "Xoa that bai!");
		} finally {
			session.close();
		}
		// String a = String.format("redirect:/info/%s.htm", user.getFullname());
		return a;

	}

	@RequestMapping(value = "/delete/{idTopic}/{idSelect}")
	public String deleteSelect(ModelMap model, @PathVariable("idTopic") Integer idTopic,
			@PathVariable("idSelect") Integer idSelect, HttpSession session2) {
		Session session = factory.openSession();
		user = (Users) session2.getAttribute("user");
		Transaction t = session.beginTransaction();
		String a = String.format("redirect:/vote/%d.htm", idTopic);
		try {
			Selection select = (Selection) session.get(Selection.class, idSelect);
			if (select.getTopic().getUser().getEmail().equals(user.getEmail())
					|| user.getEmail().equals("admin@admin")) {
				String hql = "from Vote where selection.id=" + idSelect + "";
				Query query = session.createQuery(hql);
				List<Vote> list = query.list();
				for (Vote vote : list) {
					session.delete(vote);
				}
				session.delete(select);
				t.commit();
				// re.addFlashAttribute("message", "Xoa thanh cong!");
				model.addAttribute("message", "Xoa thanh cong!");
			} else
				a = "redirect:/login.htm";
		} catch (Exception e) {
			t.rollback();
			// re.addFlashAttribute("message", "Xoa that bai!");
			model.addAttribute("message", "Xoa that bai!");
		} finally {
			session.close();
		}

		return a;
	}

	@RequestMapping(value = "/delete/evaluate/{idEva}")
	public String deleteEvaluate(ModelMap model, @PathVariable("idEva") Integer idEva, HttpSession session2) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		user = (Users) session2.getAttribute("user");
		String a = "redirect:/welcome.htm";
		try {
			Evaluate eva = (Evaluate) session.get(Evaluate.class, idEva);
			a = String.format("redirect:/vote/%d.htm", eva.getTopic().getId());
			if (eva.getUser().getEmail().equals(user.getEmail()) || user.getEmail().equals("admin@admin")) {
				session.delete(eva);
				t.commit();
				// re.addFlashAttribute("message", "Xoa thanh cong!");
				model.addAttribute("message", "Xoa thanh cong!");
			} else
				a = "redirect:/login.htm";
		} catch (Exception e) {
			t.rollback();
			// re.addFlashAttribute("message", "Xoa that bai!");
			model.addAttribute("message", "Xoa that bai!");
		} finally {
			session.close();
		}
		return a;
	}
	@ModelAttribute("tagList")
	public List<Tag> getTagList() {
		Session session = factory.getCurrentSession();
		String hql = "from Tag";
		Query query = session.createQuery(hql);
		List<Tag> list = query.list();
		return list;
	}
}
