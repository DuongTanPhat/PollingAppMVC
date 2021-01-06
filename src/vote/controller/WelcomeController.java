package vote.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import javax.servlet.ServletContext;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import vote.entity.Topics;
import vote.entity.Users;
import vote.entity.Tag;
import vote.bean.vote;
import vote.service.MyUserDetails;
@Transactional
@Controller

public class WelcomeController {

	Users user = null;
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	public static Users getLoginUser(){
        if(SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof UserDetails){
            UserDetails userLogin = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            Users user = null;
            if(userLogin != null){
                user = ((MyUserDetails)userLogin).getUser();
            }
            return user;
        }
        return null;
    }
	@RequestMapping("/processing")
	public String process(ModelMap model, HttpSession session2) {
		user = getLoginUser();
		if(user!=null) session2.setAttribute("user", user);
		return "redirect:/welcome.htm";
	}
	@RequestMapping("/welcome")
	public String welcome(ModelMap model, HttpSession session2) {
		Session session = factory.getCurrentSession();
		String hql = "From Topics";
		String hql2 = "Select count(selection.topic.id) as count,selection.topic.id as id from Vote group by selection.topic.id";
		Query query = session.createQuery(hql);
		Query query2 = session.createQuery(hql2);
		List<Topics> list = query.list();
		List<vote> listTopic = new ArrayList<>();
		List result = query2.list();
		Map<Integer, Integer> b = new HashMap<>();
		for (Object object : result) {
			Object[] a = (Object[]) object;
			int count = ((Number) a[0]).intValue();
			int key = (int) (a[1]);
			b.put(key, count);
		}
		String hql3 = "Select avg(rate) as avg,topic.id as id from Evaluate group by topic.id";
		Query query3 = session.createQuery(hql3);
		List result3 = query3.list();
		Map<Integer, Float> c = new HashMap<>();
		for (Object object : result3) {
			Object[] a = (Object[]) object;
			Float avg = ((Number) a[0]).floatValue();
			int key = (int) (a[1]);
			c.put(key, avg);
		}
		for (Topics object : list) {
			vote a = new vote();
			a.setTopic(object);
			if (b.get(a.getTopic().getId()) != null) {
				a.setCountVote(b.get(a.getTopic().getId()));
			} else
				a.setCountVote(0);
			if (c.get(a.getTopic().getId()) != null) {
				a.setRate(c.get(a.getTopic().getId()));
			} else
				a.setRate(0.0f);
			a.setEx();
			listTopic.add(a);
		}
		Collections.sort(listTopic, Collections.reverseOrder());
		model.addAttribute("topics", listTopic.subList(0, 8));
		model.addAttribute("page", 1);
		model.addAttribute("maxpage", Math.ceil(listTopic.size() / 8.0));
		model.addAttribute("where", 1);
		return "home";
	}

	@RequestMapping(value = "/welcome", params = "page")
	public String welcome(ModelMap model, @RequestParam("page") Integer page) {
		Session session = factory.getCurrentSession();
		String hql = "From Topics";
		String hql2 = "Select count(selection.topic.id) as count,selection.topic.id as id from Vote group by selection.topic.id";
		Query query = session.createQuery(hql);
		Query query2 = session.createQuery(hql2);
		List<Topics> list = query.list();
		List<vote> listTopic = new ArrayList<>();
		List result = query2.list();
		Map<Integer, Integer> b = new HashMap<>();
		for (Object object : result) {
			Object[] a = (Object[]) object;
			int count = ((Number) a[0]).intValue();
			int key = (int) (a[1]);
			b.put(key, count);
		}
		String hql3 = "Select avg(rate) as avg,topic.id as id from Evaluate group by topic.id";
		Query query3 = session.createQuery(hql3);
		List result3 = query3.list();
		Map<Integer, Float> c = new HashMap<>();
		for (Object object : result3) {
			Object[] a = (Object[]) object;
			Float avg = ((Number) a[0]).floatValue();
			int key = (int) (a[1]);
			c.put(key, avg);
		}
		for (Topics object : list) {
			vote a = new vote();
			a.setTopic(object);
			if (b.get(a.getTopic().getId()) != null) {
				a.setCountVote(b.get(a.getTopic().getId()));
			} else
				a.setCountVote(0);
			if (c.get(a.getTopic().getId()) != null) {
				a.setRate(c.get(a.getTopic().getId()));
			} else
				a.setRate(0.0f);
			a.setEx();
			listTopic.add(a);
		}
		Collections.sort(listTopic, Collections.reverseOrder());
		model.addAttribute("topics",
				listTopic.subList((page - 1) * 8, (page * 8 > listTopic.size() ? listTopic.size() : page * 8)));
		model.addAttribute("page", page);
		model.addAttribute("maxpage", Math.ceil(listTopic.size() / 8.0));
		model.addAttribute("where", 1);
		return "home";
	}

	@RequestMapping(value = "/welcome", params = "name")
	public String welcome(ModelMap model, @RequestParam("name") String name) {
		Session session = factory.getCurrentSession();
		String alphaAndDigits = name.replaceAll("[^a-zA-Z0-9âôê_ ]", "_");
		//System.out.println(name);
		//System.out.println(alphaAndDigits);
		String hql = "From Topics WHERE descriptions LIKE '%" + alphaAndDigits + "%' OR name LIKE '%" + alphaAndDigits
				+ "%'";
		Query query = session.createQuery(hql);
		List<Topics> list = query.list();

		String hql2 = "Select count(selection.topic.id) as count,selection.topic.id as id from Vote group by selection.topic.id";
		Query query2 = session.createQuery(hql2);

		List<vote> listTopic = new ArrayList<>();
		List result = query2.list();
		Map<Integer, Integer> b = new HashMap<>();
		for (Object object : result) {
			Object[] a = (Object[]) object;
			int count = ((Number) a[0]).intValue();
			int key = (int) (a[1]);
			b.put(key, count);
		}
		String hql3 = "Select avg(rate) as avg,topic.id as id from Evaluate group by topic.id";
		Query query3 = session.createQuery(hql3);
		List result3 = query3.list();
		Map<Integer, Float> c = new HashMap<>();
		for (Object object : result3) {
			Object[] a = (Object[]) object;
			Float avg = ((Number) a[0]).floatValue();
			int key = (int) (a[1]);
			c.put(key, avg);
		}
		for (Topics object : list) {
			vote a = new vote();
			a.setTopic(object);
			if (b.get(a.getTopic().getId()) != null) {
				a.setCountVote(b.get(a.getTopic().getId()));
			} else
				a.setCountVote(0);
			if (c.get(a.getTopic().getId()) != null) {
				a.setRate(c.get(a.getTopic().getId()));
			} else
				a.setRate(0.0f);
			a.setEx();
			listTopic.add(a);
		}
		Collections.sort(listTopic, Collections.reverseOrder());
		model.addAttribute("topics", listTopic);
		model.addAttribute("where", 1);
		model.addAttribute("page", 1);
		model.addAttribute("maxpage", 1);
		return "home";
	}

	@RequestMapping(value = "/welcome", params = "vote")
	public String welcome3(ModelMap model) {
		model.addAttribute("where", 2);
		return "infoTopic";
	}

	@RequestMapping(value = "/user/info")
	public String welcome4(ModelMap model) {
		//System.out.println(user.getEmail());
		model.addAttribute("where", 5);
		return "info";
	}

	@RequestMapping(value = "/manager")
	public String infoUser(ModelMap model, HttpSession session2) {
		Session session = factory.getCurrentSession();
		user = (Users) session2.getAttribute("user");
		String hql = "from Topics where user.email='" + user.getEmail() + "'";
		Query query = session.createQuery(hql);
		List<Topics> list = query.list();

		model.addAttribute("listTopic", list);
		model.addAttribute("where", 3);
		return "infoUser";
	}

//	@RequestMapping(value = "/login", method = RequestMethod.GET)
//	public String login(ModelMap model) {
//
//		return "login";
//	}
//
//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public String login(ModelMap model, @RequestParam("email") String email, @RequestParam("password") String password,
//			HttpSession session2) {
//
//		Session session = factory.getCurrentSession();
//		String hql = "select email,password from Users where email='" + email + "'and password='" + password
//				+ "' and ban=false";
//		Query query = session.createQuery(hql);
//		List<Object> list = query.list();
//		if (!list.isEmpty()) {
//			String hql2 = "from Users where email='" + email + "'and password='" + password + "' and ban=false";
//			Query query2 = session.createQuery(hql2);
//			List<Users> list2 = query2.list();
//			user = list2.get(0);
//			// user = (Users) session.get(Users.class, email);
//			session2.setAttribute("user", user);
//			if (user.getEmail().equals("admin@admin")) {
//				return "redirect:/admin.htm";
//			}
//			return "redirect:/welcome.htm";
//		}
//		model.addAttribute("email", email);
//		model.addAttribute("password", password);
//		model.addAttribute("message", "Đăng nhập thất bại!");
//		return "login";
//	}

//	@RequestMapping(value = "/vote/{IdTopic}")
//	public String topic(ModelMap model, @PathVariable("IdTopic") Integer idTopic, HttpSession session2) {
//		Users u = (Users) session2.getAttribute("user");
//		Session session = factory.getCurrentSession();
//		
//		String hql4 = "from Topics where id='" + idTopic + "'";
//		Query query4 = session.createQuery(hql4);
//		List<Topics> list = query4.list();
//		
//		Topics topic = (Topics) list.get(0);
//		//Topics topic = (Topics) session.get(Topics.class, idTopic);
//		// model.addAttribute("topic", topic);
//		session2.setAttribute("topic", topic);
////		for (Selection a : topic.getSelection()) {
////			System.out.println(a.getName());
////		}
////		System.out.println(topic);
//		model.addAttribute("where", 2);
//		model.addAttribute("select", new Selection());
//		model.addAttribute("evaluate", new Evaluate());
//		if (isVoted(idTopic, u.getEmail())) {
//			String hql2 = String.format(
//					"Select count(selection.id) as count,selection.id as id from Vote where selection.topic.id=%d group by selection.id",
//					idTopic);
//			Query query2 = session.createQuery(hql2);
//			List result = query2.list();
//			Map<Integer, Integer> b = new HashMap<>();
//			List<VoteSelect> listVote = new ArrayList<>();
//			for (Object object : result) {
//				Object[] a = (Object[]) object;
//				int count = ((Number) a[0]).intValue();
//				int key = (int) (a[1]);
//				b.put(key, count);
//			}
//			String hql = String.format("Select selection.id from Vote where user.email='%s' and selection.topic.id=%d",
//					u.getEmail(), idTopic);
//			Query query = session.createQuery(hql);
//			List<Integer> result2 = query.list();
//			for (Selection object : topic.getSelection()) {
//				VoteSelect a = new VoteSelect();
//				a.setSelect(object);
//				if (b.get(object.getId()) != null) {
//					a.setCountVote(b.get(object.getId()));
//				} else
//					a.setCountVote(0);
//				for (int i = 0; i < result2.size(); i++) {
//					if (result2.get(i) == object.getId()) {
//						a.setVoted(true);
//					}
//				}
//				listVote.add(a);
//			}
//			Collections.sort(listVote, Collections.reverseOrder());
//			model.addAttribute("countSelect", listVote);
//			String hql3 = String.format("from Evaluate where topic.id=%d", idTopic);
//			Query query3 = session.createQuery(hql3);
//			List<Evaluate> result3 = query3.list();
//			model.addAttribute("listEvaluate", result3);
//			return "infoTopicVoted";
//		}
//		return "infoTopic";
//	}
//
//	@RequestMapping(value = "/vote/{IdTopic}", params = "insertSelect", method = RequestMethod.POST)
//	public String Topic(ModelMap model, @ModelAttribute("select") Selection select, HttpSession session2) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		
//		Topics a = (Topics) session2.getAttribute("topic");
//		if(!select.getName().isEmpty()) {
//		select.setTopic(a);
//		try {
//			session.save(select);
//			t.commit();
//			// re.addFlashAttribute("message", "Them moi thanh cong!");
//			model.addAttribute("message", "Them moi thanh cong!");
//			session.close();
//
//		} catch (Exception e) {
//			t.rollback();
//			// re.addFlashAttribute("message", "Them moi that bai!");
//			model.addAttribute("message", "Them moi that bai!");
//			session.close();
//			return "home";
//		}
//		}
//		String b = String.format("redirect:/vote/%s.htm", String.valueOf(a.getId()));
//		return b;
//	}
//
//	@RequestMapping(value = "/vote/{IdTopic}", params = "insertEvaluate", method = RequestMethod.POST)
//	public String Evaluate(ModelMap model, @PathVariable("IdTopic") Integer idTopic,
//			@ModelAttribute("evaluate") Evaluate eva, HttpSession session2) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		String hql = String.format("from Evaluate where topic.id=%d and user.email='%s'", idTopic, user.getEmail());
//		Query query2 = session.createQuery(hql);
//		List<Evaluate> result = query2.list();
//		if (result.isEmpty()) {
//			Topics a = (Topics) session2.getAttribute("topic");
//			eva.setTopic(a);
//			eva.setUser(user);
//			try {
//				session.save(eva);
//				t.commit();
//				// re.addFlashAttribute("message", "Them moi thanh cong!");
//				model.addAttribute("message", "Them moi thanh cong!");
//				session.close();
//
//			} catch (Exception e) {
//				t.rollback();
//				// re.addFlashAttribute("message", "Them moi that bai!");
//				model.addAttribute("message", "Them moi that bai!");
//				session.close();
//				return "home";
//			}
//			String b = String.format("redirect:/vote/%s.htm", String.valueOf(a.getId()));
//			return b;
//		} else {
//			Topics a = (Topics) session2.getAttribute("topic");
//			Evaluate eva2 = result.get(0);
//			eva2.setRate(eva.getRate());
//			eva2.setDescriptions(eva.getDescriptions());
//			try {
//				session.update(eva2);
//				t.commit();
//				// re.addFlashAttribute("message", "Them moi thanh cong!");
//				model.addAttribute("message", "Sua danh gia thanh cong!");
//				session.close();
//
//			} catch (Exception e) {
//				t.rollback();
//				// re.addFlashAttribute("message", "Them moi that bai!");
//				model.addAttribute("message", "Sua danh gia that bai!");
//				session.close();
//				return "home";
//			}
//			String b = String.format("redirect:/vote/%s.htm", String.valueOf(a.getId()));
//			return b;
//		}
//	}
//
//	@RequestMapping(value = "/select/{IdTopic}/{IdSelect}")
//	public String vote(ModelMap model, @PathVariable("IdTopic") Integer idTopic,
//			@PathVariable("IdSelect") Integer idSelect, HttpSession session2) {
//		Users u = (Users) session2.getAttribute("user");
//		Session session = factory.openSession();
//		Topics topic = (Topics) session2.getAttribute("topic");
//		Date now = new Date();
//		Date now2 = new Date(now.getYear(), now.getMonth(), now.getDate());
//		if (topic.getExp() != null) {
//			if (topic.getExp().compareTo(now2)<0)return "redirect:/welcome.htm";
//		}
//		Transaction t = session.beginTransaction();
//		String hql = "from Vote where user.email='" + u.getEmail() + "'and selection.id='" + idSelect + "'";
//		Query query = session.createQuery(hql);
//		List<Vote> list = query.list();
//		if (!list.isEmpty()) {
//			// user = (Users) session.get(Users.class, email);
//			try {
//				// Vote vote2 = (Vote)session.get(Vote.class, );
//				// session.update(vote);
//				session.delete(list.get(0));
//				t.commit();
//				model.addAttribute("message", "Xóa bầu chọn thành công!");
//			} catch (Exception e) {
//				t.rollback();
//				model.addAttribute("message", "Xóa bầu chọn thất bại!");
//			} finally {
//				session.close();
//			}
//			String a = String.format("redirect:/vote/%d.htm", idTopic);
//			return a;
//		} else {
//			Vote vote = new Vote();
//			vote.setUser(u);
//			vote.setSeletion((Selection) session.get(Selection.class, idSelect));
//			if (!isVoted(idTopic, u.getEmail()) || topic.getIsMany()) {
//				try {
//					session.save(vote);
//					t.commit();
//					model.addAttribute("message", "Bầu chọn thành công!");
//				} catch (Exception e) {
//					t.rollback();
//					model.addAttribute("message", "Bầu chọn thất bại!");
//				} finally {
//					session.close();
//				}
//				String a = String.format("redirect:/vote/%d.htm", idTopic);
//				return a;
//			} else {
//				try {
//					String hql3 = "from Vote where user.email='" + u.getEmail() + "'and selection.topic.id='" + idTopic
//							+ "'";
//					Query query3 = session.createQuery(hql3);
//					List<Vote> list3 = query3.list();
//					Vote updateVote = list3.get(0);
//					updateVote.setSeletion((Selection) session.get(Selection.class, idSelect));
//					session.update(updateVote);
//					t.commit();
//					model.addAttribute("message", "Sửa bầu chọn thành công!");
//				} catch (Exception e) {
//					t.rollback();
//					model.addAttribute("message", "Sửa bầu chọn thất bại!");
//				} finally {
//					session.close();
//				}
//
//				String a = String.format("redirect:/vote/%d.htm", idTopic);
//				return a;
//			}
//		}
//	}

//	public Boolean isVoted(Integer idTopic, String email) {
//		Session session = factory.getCurrentSession();
//		String hql = "from Vote where user.email='" + email + "'and selection.topic.id='" + idTopic + "'";
//		Query query = session.createQuery(hql);
//		List<Object> list = query.list();
//		if (!list.isEmpty()) {
//			user = (Users) session.get(Users.class, email);
//			return true;
//		}
//		return false;
//	}

//	@RequestMapping(value = "/logoff")
//	public String logoff(ModelMap model, HttpSession session2) {
//		user = null;
//		session2.removeAttribute("user");
//		session2.removeAttribute("topic");
//		return "redirect:/welcome.htm";
//	}

	@ModelAttribute("tagList")
	public List<Tag> getTagList() {
		Session session = factory.getCurrentSession();
		String hql = "from Tag";
		Query query = session.createQuery(hql);
		List<Tag> list = query.list();
		return list;
	}

//	@RequestMapping(value = "/topic/insert", method = RequestMethod.GET)
//	public String insertTopic(ModelMap model, HttpSession session2) {
//		model.addAttribute("where", 4);
//		model.addAttribute("topic", new Topics());
//		return "insert";
//	}
//
//	@RequestMapping(value = "/topic/insert", method = RequestMethod.POST)
//	public String insertTopic(ModelMap model, @ModelAttribute("topic") Topics topic,
//			@RequestParam("photo2") MultipartFile photo, HttpSession session2, BindingResult errors) {
//		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
//				&& (!photo.isEmpty())) {
//			errors.rejectValue("photo", "topic", "The image type for the file is invalid");
//		}
//		if (errors.hasErrors()) {
//			model.addAttribute("where", 4);
//			return "insert";
//		} else {
//			Session session = factory.openSession();
//			Transaction t = session.beginTransaction();
//			Users u = (Users) session2.getAttribute("user");
//			topic.setUser(u);
//			try {
//				int i = 0;
//				String name = photo.getOriginalFilename();
//				if (!name.isEmpty()) {
//					String photoPath = context.getRealPath("/files/" + name);
//					while (Files.exists(Paths.get(photoPath))) {
//						i++;
//						photoPath = context.getRealPath("/files/" + i + name);
//					}
//					if (i != 0) {
//						name = i + name;
//					}
//					photo.transferTo(new File(photoPath));
//					//System.out.println(photoPath);
//					topic.setPhoto("files/" + name);
//				}
//				session.save(topic);
//				// session2.setAttribute("topicInsert", topic);
//				t.commit();
//				model.addAttribute("message", "Them moi thanh cong!");
//				session.close();
//
//			} catch (Exception e) {
//				t.rollback();
//				model.addAttribute("message", "Them moi that bai!");
//				session.close();
//				return "home";
//			}
//			String a = String.format("redirect:/vote/%s.htm", topic.getId());
//			return a;
//		}
//	}

//	@RequestMapping(value = "/signup", method = RequestMethod.GET)
//	public String signup(ModelMap model) {
//		model.addAttribute("userNew", new Users());
//		model.addAttribute("password2", "");
//		return "signup";
//	}
//
//	@RequestMapping(value = "/signup", method = RequestMethod.POST)
//	public String signup(ModelMap model, @ModelAttribute("userNew") Users user,
//			@RequestParam("password2") String password, @RequestParam("photo2") MultipartFile photo,
//			HttpSession session2, BindingResult errors) {
//		model.addAttribute("password2", password);
//		Session session1 = factory.getCurrentSession();
//		String hql = "select email from Users where email='" + user.getEmail() + "'";
//		Query query = session1.createQuery(hql);
//		List<Object> list = query.list();
//		if (!list.isEmpty()) {
//			errors.rejectValue("email", "userNew", "Email is already in use");
//		}
//
//		if (!user.getPassword().trim().equals(password)) {
//			errors.rejectValue("password", "userNew", "Confirm password doesn't match");
//		}
//		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
//				&& (!photo.isEmpty())) {
//			errors.rejectValue("photo", "userNew", "The image type for the file is invalid");
//		}
//		if (errors.hasErrors()) {
//			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
//			return "signup";
//		} else {
//			Session session = factory.openSession();
//			Transaction t = session.beginTransaction();
//			try {
//				if (!photo.isEmpty()) {
//					int i = 0;
//					String name = photo.getOriginalFilename();
//					String photoPath = context.getRealPath("/files/ava/" + name);
//					while (Files.exists(Paths.get(photoPath))) {
//						i++;
//						photoPath = context.getRealPath("/files/ava/" + i + name);
//					}
//					if (i != 0) {
//						name = i + name;
//					}
//					//System.out.println(photoPath);
//					photo.transferTo(new File(photoPath));
//					user.setPhoto("files/ava/" + name);
//				}
//				user.setBan(false);
//				PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//				user.setPassword(passwordEncoder.encode(user.getPassword()));
//				UsersRole roleU = new UsersRole();
//				roleU.setUser(user);
//				RoleN r = (RoleN)session.get(RoleN.class, 2);
//				roleU.setRole(r);
//				session.save(roleU);
//				session.save(user);
//				t.commit();
//				this.user = user;
//				 session2.setAttribute("user", user);
//				 model.remove("password2");
//				// re.addFlashAttribute("message", "Them moi thanh cong!");
//				model.addAttribute("message", "Them moi thanh cong!");
//				session.close();
//
//			} catch (Exception e) {
//				t.rollback();
//				// re.addFlashAttribute("message", "Them moi that bai!");
//				model.addAttribute("message", "Them moi that bai!");
//				session.close();
//				return "redirect:/welcome.htm";
//			}
//			return "redirect:/welcome.htm";
//		}
//	}

//	@RequestMapping(value = "/topic/edit/{idTopic}", method = RequestMethod.GET)
//	public String edit(ModelMap model, @PathVariable("idTopic") Integer idTopic, HttpSession session2) {
//		Session session = factory.getCurrentSession();
//		Topics topic = (Topics) session.get(Topics.class, idTopic);
//		if (topic.getUser().getEmail().equals(user.getEmail()) || user.getEmail().equals("admin@admin")) {
//			model.addAttribute("topic", topic);
//			model.addAttribute("where", 4);
//			// model.addAttribute("photo2",topic.getPhoto());
//			return "edit";
//		} else
//			return "redirect:/login.htm";
//	}
//
//	@RequestMapping(value = "/topic/edit/{idTopic}", method = RequestMethod.POST)
//	public String edit(ModelMap model, @ModelAttribute("topic") Topics topic,
//			@RequestParam("photo2") MultipartFile photo, HttpSession session2, @PathVariable("idTopic") Integer idTopic,
//			BindingResult errors) {
//
//		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
//				&& (!photo.isEmpty())) {
//			errors.rejectValue("photo", "topic", "The image type for the file is invalid");
//		}
//		if (errors.hasErrors()) {
//			model.addAttribute("where", 3);
//			return "edit";
//		} else {
//			Session session = factory.openSession();
//			Transaction t = session.beginTransaction();
//			Topics topic2 = (Topics) session.get(Topics.class, idTopic);
//			if (topic2.getUser().getEmail().equals(user.getEmail()) || user.getEmail().equals("admin@admin")) {
//				// Users u = (Users) session2.getAttribute("user");
//				// topic.setUser(u);
//				try {
//					int i = 0;
//					String name = photo.getOriginalFilename();
//					if (!name.isEmpty()) {
//						String photoPath = context.getRealPath("/files/" + name);
//						while (Files.exists(Paths.get(photoPath))) {
//							i++;
//
//							photoPath = context.getRealPath("/files/" + i + name);
//
//						}
//						if (i != 0) {
//							name = i + name;
//						}
//						// String photoPath = context.getRealPath("/files/"+ Math.random()+
//						// photo.getOriginalFilename());
//						photo.transferTo(new File(photoPath));
//						//System.out.println(photoPath);
//						topic2.setPhoto("files/" + name);
//					}
//					topic2.setName(topic.getName());
//					topic2.setDescriptions(topic.getDescriptions());
//					topic2.setTag(topic.getTag());
//					topic2.setIsCreate(topic.getIsCreate());
//					topic2.setIsMany(topic.getIsMany());
//					topic2.setExp(topic.getExp());
//					session.update(topic2);
//					// session2.setAttribute("topicInsert", topic);
//					t.commit();
//					// re.addFlashAttribute("message", "Them moi thanh cong!");
//					model.addAttribute("message", "Cap nhat thanh cong!");
//					session.close();
//
//				} catch (Exception e) {
//					t.rollback();
//					// re.addFlashAttribute("message", "Them moi that bai!");
//					model.addAttribute("message", "Cap nhat that bai!");
//					session.close();
//					return "redirect:/welcome.htm";
//				}
//			} else
//				return "redirect:/login.htm";
//			String a = String.format("redirect:/vote/%s.htm", topic2.getId());
//			return a;
//		}
//
//	}
//
//	@RequestMapping(value = "/topic/delete/{idTopic}")
//	public String delete(ModelMap model, @PathVariable("idTopic") Integer idTopic) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		String a = String.format("redirect:/manager.htm");
//		try {
//			Topics topic2 = (Topics) session.get(Topics.class, idTopic);
//			if (topic2.getUser().getEmail().equals(user.getEmail()) || user.getEmail().equals("admin@admin")) {
//				String hql = "from Vote where selection.topic.id=" + idTopic + "";
//				Query query = session.createQuery(hql);
//				List<Vote> list = query.list();
//				for (Vote vote : list) {
//					session.delete(vote);
//				}
//				String hql2 = "from Selection where topic.id=" + idTopic + "";
//				Query query2 = session.createQuery(hql2);
//				List<Selection> list2 = query2.list();
//				for (Selection vote : list2) {
//					session.delete(vote);
//				}
//				String hql3 = "from Evaluate where topic.id=" + idTopic + "";
//				Query query3 = session.createQuery(hql3);
//				List<Evaluate> list3 = query3.list();
//				for (Evaluate vote : list3) {
//					session.delete(vote);
//				}
//				session.delete(topic2);
//				t.commit();
//				// re.addFlashAttribute("message", "Xoa thanh cong!");
//				model.addAttribute("message", "Xoa thanh cong!");
//			} else
//				a = "redirect:/login.htm";
//		} catch (Exception e) {
//			t.rollback();
//			// re.addFlashAttribute("message", "Xoa that bai!");
//			model.addAttribute("message", "Xoa that bai!");
//		} finally {
//			session.close();
//		}
//		// String a = String.format("redirect:/info/%s.htm", user.getFullname());
//		return a;
//
//	}
//
//	@RequestMapping(value = "/delete/{idTopic}/{idSelect}")
//	public String deleteSelect(ModelMap model, @PathVariable("idTopic") Integer idTopic,
//			@PathVariable("idSelect") Integer idSelect) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		String a = String.format("redirect:/vote/%d.htm", idTopic);
//		try {
//			Selection select = (Selection) session.get(Selection.class, idSelect);
//			if (select.getTopic().getUser().getEmail().equals(user.getEmail())
//					|| user.getEmail().equals("admin@admin")) {
//				String hql = "from Vote where selection.id=" + idSelect + "";
//				Query query = session.createQuery(hql);
//				List<Vote> list = query.list();
//				for (Vote vote : list) {
//					session.delete(vote);
//				}
//				session.delete(select);
//				t.commit();
//				// re.addFlashAttribute("message", "Xoa thanh cong!");
//				model.addAttribute("message", "Xoa thanh cong!");
//			} else
//				a = "redirect:/login.htm";
//		} catch (Exception e) {
//			t.rollback();
//			// re.addFlashAttribute("message", "Xoa that bai!");
//			model.addAttribute("message", "Xoa that bai!");
//		} finally {
//			session.close();
//		}
//
//		return a;
//	}
//
//	@RequestMapping(value = "/delete/evaluate/{idEva}")
//	public String deleteEvaluate(ModelMap model, @PathVariable("idEva") Integer idEva, HttpSession session2) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		String a = "redirect:/welcome.htm";
//		try {
//			Evaluate eva = (Evaluate) session.get(Evaluate.class, idEva);
//			a = String.format("redirect:/vote/%d.htm", eva.getTopic().getId());
//			if (eva.getUser().getEmail().equals(user.getEmail()) || user.getEmail().equals("admin@admin")) {
//				session.delete(eva);
//				t.commit();
//				// re.addFlashAttribute("message", "Xoa thanh cong!");
//				model.addAttribute("message", "Xoa thanh cong!");
//			} else
//				a = "redirect:/login.htm";
//		} catch (Exception e) {
//			t.rollback();
//			// re.addFlashAttribute("message", "Xoa that bai!");
//			model.addAttribute("message", "Xoa that bai!");
//		} finally {
//			session.close();
//		}
//		return a;
//	}

//	@RequestMapping(value = "/user/edit", method = RequestMethod.GET)
//	public String editUser(ModelMap model) {
//		model.addAttribute("where", 5);
//		model.addAttribute("userEdit", user);
//		return "editUser";
//	}
//
//	@RequestMapping(value = "/user/edit", method = RequestMethod.POST)
//	public String editUser(ModelMap model, @ModelAttribute("userEdit") Users user2,
//			@RequestParam("photo2") MultipartFile photo, HttpSession session2, BindingResult errors) {
//		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
//				&& (!photo.isEmpty())) {
//			errors.rejectValue("photo", "userEdit", "The image type for the file is invalid");
//		}
//		if (errors.hasErrors()) {
//			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
//			return "editUser";
//		} else {
//			Session session = factory.openSession();
//			Transaction t = session.beginTransaction();
//			try {
//				int i = 0;
//				String name = photo.getOriginalFilename();
//				if (!name.isEmpty()) {
//					String photoPath = context.getRealPath("/files/ava/" + name);
//					while (Files.exists(Paths.get(photoPath))) {
//						i++;
//
//						photoPath = context.getRealPath("/files/ava/" + i + name);
//
//					}
//					if (i != 0) {
//						name = i + name;
//					}
//					// String photoPath = context.getRealPath("/files/"+ Math.random()+
//					// photo.getOriginalFilename());
//					photo.transferTo(new File(photoPath));
//					//System.out.println(photoPath);
//					user2.setPhoto("files/ava/" + name);
//				} else {
//					user2.setPhoto(user.getPhoto());
//				}
//				user2.setEmail(user.getEmail());
//				user2.setPassword(user.getPassword());
//				user2.setBan(false);
//				session.update(user2);
//				user = user2;
//				session2.setAttribute("user", user2);
//				t.commit();
//				// re.addFlashAttribute("message", "Them moi thanh cong!");
//				model.addAttribute("message", "Sua user thanh cong!");
//				session.close();
//
//			} catch (Exception e) {
//				t.rollback();
//				// re.addFlashAttribute("message", "Them moi that bai!");
//				//System.out.println(e);
//				model.addAttribute("message", "Sua that bai!");
//				session.close();
//				return "redirect:/welcome.htm";
//			}
//			return "redirect:/welcome.htm";
//		}
//	}

//	@RequestMapping(value = "/admin")
//	public String admin(ModelMap model) {
//		Session session = factory.getCurrentSession();
//		String hql = "Select count(Email) as count from Users";
//		String hql2 = "Select count(id) as count from Topics";
//		String hql3 = "Select count(id) as count from Vote";
//		String hql4 = "Select count(id) as count from Evaluate";
//		String hql5 = "Select count(id) as count from Selection";
//		String hql6 = "Select sum(rate) as sum from Evaluate";
//		String hql7 = "Select count(id) as count from Tag";
//		String hql8 = "from Vote";
//		Query query = session.createQuery(hql);
//		Query query2 = session.createQuery(hql2);
//		Query query3 = session.createQuery(hql3);
//		Query query4 = session.createQuery(hql4);
//		Query query5 = session.createQuery(hql5);
//		Query query6 = session.createQuery(hql6);
//		Query query7 = session.createQuery(hql7);
//		Query query8 = session.createQuery(hql8);
//
//		Object list = query.list().get(0);
//		Object list2 = query2.list().get(0);
//		Object list3 = query3.list().get(0);
//		Object list4 = query4.list().get(0);
//		Object list5 = query5.list().get(0);
//		Object list6 = query6.list().get(0);
//		Object list7 = query7.list().get(0);
//		query8.setMaxResults(5);
//		query8.setFirstResult((int) ((long) list3 - (long) 5));
//		List<Vote> list8 = query8.list();
//		model.addAttribute("soUser", list);
//		model.addAttribute("soTopics", list2);
//		model.addAttribute("soVote", list3);
//		model.addAttribute("soRate", list4);
//		model.addAttribute("soLuaChon", list5);
//		model.addAttribute("soSao", list6);
//		model.addAttribute("soTag", list7);
//		Collections.reverse(list8);
//		model.addAttribute("listVote", list8);
//		return "adminmanager";
//	}
//
//	@RequestMapping(value = "/usermanager")
//	public String usermanager(ModelMap model) {
//		Session session = factory.getCurrentSession();
//		String hql = "From Users where email<>'admin@admin'";
//		Query query = session.createQuery(hql);
//		List<Users> list = query.list();
//		model.addAttribute("listUserA", list);
//		return "adminUserManager";
//	}
//
//	@RequestMapping(value = "/topicmanager")
//	public String topicmanager(ModelMap model) {
//		Session session = factory.getCurrentSession();
//		String hql = "From Topics";
//		Query query = session.createQuery(hql);
//		List<Users> list = query.list();
//		model.addAttribute("listTopicA", list);
//		return "adminTopicManager";
//	}
//
//	@RequestMapping(value = "/tagmanager")
//	public String tagmanager(ModelMap model) {
//		Session session = factory.getCurrentSession();
//		String hql = "From Tag";
//		Query query = session.createQuery(hql);
//		List<Users> list = query.list();
//		model.addAttribute("listTagA", list);
//		return "adminTagManager";
//	}
//
//	@RequestMapping(value = "/adminInsertTag")
//	public String tagInsert(ModelMap model) {
//		model.addAttribute("tag", new Tag());
//		return "adminInsertTag";
//	}
//
//	@RequestMapping(value = "/adminInsertTag", method = RequestMethod.POST)
//	public String tagInsert(ModelMap model, @ModelAttribute("tag") Tag tag, BindingResult errors) {
//		Session session1 = factory.getCurrentSession();
//		String hql = "From Tag where id = '" + tag.getId() + "'";
//		Query query = session1.createQuery(hql);
//		List<Users> list = query.list();
//		if (!list.isEmpty()) {
//			errors.rejectValue("id", "tag", "Id đã tồn tại");
//		}
//		if (errors.hasErrors()) {
//			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
//			return "adminInsertTag";
//		} else {
//			Session session = factory.openSession();
//			Transaction t = session.beginTransaction();
//			try {
//
//				session.save(tag);
//				t.commit();
//				model.addAttribute("message", "Them tag thanh cong!");
//			} catch (Exception e) {
//				t.rollback();
//				model.addAttribute("message", "Them tag that bai!");
//			} finally {
//				session.close();
//			}
//			return "redirect:/tagmanager.htm";
//		}
//	}
//
//	@RequestMapping(value = "/tag/edit/{idTag}", method = RequestMethod.GET)
//	public String tagEdit(ModelMap model, @PathVariable("idTag") String idTag) {
//		Session session = factory.getCurrentSession();
//		Tag tag = (Tag) session.get(Tag.class, idTag);
//		// if(topic.getUser().getEmail().equals(user.getEmail())||user.getEmail().equals("admin@admin"))
//		// {
//		model.addAttribute("tag", tag);
//		// model.addAttribute("where",4);
//		// model.addAttribute("photo2",topic.getPhoto());
////		return "edit";
////		}
//		return "adminEditTag";
//		// return "redirect:/login.htm";
//	}
//
//	@RequestMapping(value = "/tag/edit/{idTag}", method = RequestMethod.POST)
//	public String tagEdit(ModelMap model, @ModelAttribute("tag") Tag tag, HttpSession session2, BindingResult errors) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		try {
//			session.update(tag);
//			t.commit();
//			// re.addFlashAttribute("message", "Them moi thanh cong!");
//			model.addAttribute("message", "Cap nhat thanh cong!");
//			session.close();
//
//		} catch (Exception e) {
//			t.rollback();
//			// re.addFlashAttribute("message", "Them moi that bai!");
//			model.addAttribute("message", "Cap nhat that bai!");
//			session.close();
//		}
//		return "redirect:/tagmanager.htm";
//	}
//
//	@RequestMapping(value = "/tag/delete/{idTag}")
//	public String deleteTag(ModelMap model, @PathVariable("idTag") String idTag, HttpSession session2) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		String a = "redirect:/tagmanager.htm";
//		try {
//			Tag tag = (Tag) session.get(Tag.class, idTag);
//			if (user.getEmail().equals("admin@admin")) {
//				session.delete(tag);
//				t.commit();
//				// re.addFlashAttribute("message", "Xoa thanh cong!");
//				model.addAttribute("message", "Xoa thanh cong!");
//			} else
//				a = "redirect:/login.htm";
//		} catch (Exception e) {
//			t.rollback();
//			// re.addFlashAttribute("message", "Xoa that bai!");
//			model.addAttribute("message", "Xoa that bai!");
//		} finally {
//			session.close();
//		}
//		return a;
//	}
//
//	@RequestMapping(value = "/admin/ban/{email}")
//	public String banUser(ModelMap model, @PathVariable("email") String email, HttpSession session2) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		String a = "redirect:/usermanager.htm";
//		try {
//			Users userBan = (Users) session.get(Users.class, email);
//			if (user.getEmail().equals("admin@admin")) {
//				userBan.setBan(true);
//				session.update(userBan);
//				t.commit();
//				// re.addFlashAttribute("message", "Xoa thanh cong!");
//				model.addAttribute("message", "Ban thanh cong!");
//			} else
//				a = "redirect:/login.htm";
//		} catch (Exception e) {
//			t.rollback();
//			// re.addFlashAttribute("message", "Xoa that bai!");
//			model.addAttribute("message", "Ban that bai!");
//		} finally {
//			session.close();
//		}
//		return a;
//	}
//
//	@RequestMapping(value = "/admin/unban/{email}")
//	public String unbanUser(ModelMap model, @PathVariable("email") String email, HttpSession session2) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		String a = "redirect:/usermanager.htm";
//		try {
//			Users userBan = (Users) session.get(Users.class, email);
//			if (user.getEmail().equals("admin@admin")) {
//				userBan.setBan(false);
//				session.update(userBan);
//				t.commit();
//				// re.addFlashAttribute("message", "Xoa thanh cong!");
//				model.addAttribute("message", "unBan thanh cong!");
//			} else
//				a = "redirect:/login.htm";
//		} catch (Exception e) {
//			t.rollback();
//			// re.addFlashAttribute("message", "Xoa that bai!");
//			model.addAttribute("message", "unBan that bai!");
//		} finally {
//			session.close();
//		}
//		return a;
//	}
//
//	@RequestMapping(value = "/admin/edit/{email}", method = RequestMethod.GET)
//	public String editAdminUser(ModelMap model, @PathVariable("email") String email) {
//		Session session = factory.getCurrentSession();
//		Users userEdit = (Users) session.get(Users.class, email);
//		// if(topic.getUser().getEmail().equals(user.getEmail())||user.getEmail().equals("admin@admin"))
//		// {
//		model.addAttribute("userEdit", userEdit);
//		return "adminEditUser";
//		// return "redirect:/login.htm";
//	}
//
//	@RequestMapping(value = "/admin/edit/{email}")
//	public String editAdminUser(ModelMap model, @PathVariable("email") String email,
//			@ModelAttribute("userEdit") Users user2, @RequestParam("photo2") MultipartFile photo, HttpSession session2,
//			BindingResult errors) {
//		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
//				&& (!photo.isEmpty())) {
//			errors.rejectValue("photo", "userEdit", "The image type for the file is invalid");
//		}
//		if (errors.hasErrors()) {
//			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
//			return "adminEditUser";
//		} else {
//			Session session1 = factory.getCurrentSession();
//			Session session = factory.openSession();
//			Transaction t = session.beginTransaction();
//			try {
//				Users user1 = (Users) session1.get(Users.class, email);
//				int i = 0;
//				String name = photo.getOriginalFilename();
//				if (!name.isEmpty()) {
//					String photoPath = context.getRealPath("/files/ava/" + name);
//					while (Files.exists(Paths.get(photoPath))) {
//						i++;
//
//						photoPath = context.getRealPath("/files/ava/" + i + name);
//
//					}
//					if (i != 0) {
//						name = i + name;
//					}
//					// String photoPath = context.getRealPath("/files/"+ Math.random()+
//					// photo.getOriginalFilename());
//					photo.transferTo(new File(photoPath));
//					//System.out.println(photoPath);
//					user2.setPhoto("files/ava/" + name);
//				} else {
//
//					user2.setPhoto(user1.getPhoto());
//				}
//				user2.setEmail(user1.getEmail());
//				user2.setPassword(user1.getPassword());
//				user2.setBan(false);
//				session.update(user2);
//				// user = user2;
//				// session2.setAttribute("user", user2);
//				t.commit();
//				// re.addFlashAttribute("message", "Them moi thanh cong!");
//				model.addAttribute("message", "Sua user thanh cong!");
//				session.close();
//
//			} catch (Exception e) {
//				t.rollback();
//				// re.addFlashAttribute("message", "Them moi that bai!");
//				//System.out.println(e);
//				model.addAttribute("message", "Sua user that bai!");
//				session.close();
//				return "redirect:/usermanager.htm";
//			}
//			return "redirect:/usermanager.htm";
//		}
//	}

//	@RequestMapping("/logingg")
//	public String loginGoogle(ModelMap model, HttpServletRequest request, HttpSession session2)
//			throws ClientProtocolException, IOException {
//		String code = request.getParameter("code");
//
//		if (code == null || code.isEmpty()) {
//			return "redirect:/login.htm?message=google_error";
//		}
//		String accessToken = GoogleUtils.getToken(code);
//
//		GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
//		Session session = factory.getCurrentSession();
//		String hql = "select email from Users where email='" + googlePojo.getEmail() + "' and ban=false";
//		Query query = session.createQuery(hql);
//		List<Object> list = query.list();
//		if (!list.isEmpty()) {
//			String hql2 = "from Users where email='" + googlePojo.getEmail() + "' and ban=false";
//			Query query2 = session.createQuery(hql2);
//			List<Users> list2 = query2.list();
//			user = list2.get(0);
//			// user = (Users) session.get(Users.class, email);
//			session2.setAttribute("user", user);
//			if (user.getEmail().equals("admin@admin")) {
//				return "redirect:/admin.htm";
//			}
//			return "redirect:/welcome.htm";
//		} else {
//			/*
//			 * model.addAttribute("email", googlePojo.getEmail());
//			 * model.addAttribute("name", googlePojo.getName());
//			 */
//			session2.setAttribute("email", googlePojo.getEmail());
//			session2.setAttribute("name", googlePojo.getName());
//			session2.setAttribute("photo", googlePojo.getPicture());
//			/*
//			 * request.setAttribute("name", googlePojo.getName());
//			 * 
//			 * request.setAttribute("email", googlePojo.getEmail());
//			 */
//			return "redirect:/signupgg.htm";
//		}
//
//	}
//
//	@RequestMapping(value = "/signupgg", method = RequestMethod.GET)
//	public String signupgg(ModelMap model, HttpSession session2) {
//		Users a = new Users();
//
//		a.setEmail((String) session2.getAttribute("email"));
//		a.setFullname((String) session2.getAttribute("name"));
//		a.setPhoto((String) session2.getAttribute("photo"));
//		model.addAttribute("userNew", a);
//		model.addAttribute("password2", "");
//		return "signupgg";
//	}
//
//	@RequestMapping(value = "/signupgg", method = RequestMethod.POST)
//	public String signupgg(ModelMap model, @ModelAttribute("userNew") Users user,
//			@RequestParam("password2") String password, @RequestParam("photo2") MultipartFile photo,
//			HttpSession session2, BindingResult errors) {
//		model.addAttribute("password2", password);
//		if (!user.getPassword().trim().equals(password)) {
//			errors.rejectValue("password", "userNew", "Confirm password doesn't match");
//		}
//		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
//				&& (!photo.isEmpty())) {
//			errors.rejectValue("photo", "userNew", "The image type for the file is invalid");
//		}
//		if (errors.hasErrors()) {
//			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
//			return "signupgg";
//		} else {
//			Session session = factory.openSession();
//			Transaction t = session.beginTransaction();
//			try {
//				int i = 0;
//				String name = photo.getOriginalFilename();
//				if (!name.isEmpty()) {
//					String photoPath = context.getRealPath("/files/ava/" + name);
//					while (Files.exists(Paths.get(photoPath))) {
//						i++;
//						photoPath = context.getRealPath("/files/ava/" + i + name);
//					}
//					if (i != 0) {
//						name = i + name;
//					}
//					//System.out.println(photoPath);
//					photo.transferTo(new File(photoPath));
//					user.setPhoto("files/ava/" + name);
//				} else {
//					user.setPhoto((String) session2.getAttribute("photo"));
//				}
//				user.setBan(false);
//				session.save(user);
//
//				t.commit();
//				this.user = user;
//				session2.setAttribute("user", user);
//				// re.addFlashAttribute("message", "Them moi thanh cong!");
//				model.addAttribute("message", "Them moi thanh cong!");
//				session.close();
//
//			} catch (Exception e) {
//				t.rollback();
//				// re.addFlashAttribute("message", "Them moi that bai!");
//				model.addAttribute("message", "Them moi that bai!");
//				session.close();
//				return "redirect:/welcome.htm";
//			}
//			return "redirect:/welcome.htm";
//		}
//	}
	@RequestMapping(value = "/changepassword", method = RequestMethod.GET)
	public String changepassword(ModelMap model, HttpSession session2) {
		model.addAttribute("where", 5);
		model.addAttribute("password", "");
		model.addAttribute("password1", "");
		model.addAttribute("password2", "");
		return "changepassword";
	}
	@RequestMapping(value = "/changepassword", method = RequestMethod.POST)
	public String changepassword(ModelMap model, @ModelAttribute("password") String oldpassword,
			@ModelAttribute("password1") String newpassword, @ModelAttribute("password2") String newpassword2,
			HttpSession session2) {
		int err = 0;
		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		//if (!user.getPassword().trim().equals(oldpassword)) {
		user = (Users) session2.getAttribute("user");
		if (!passwordEncoder.matches(oldpassword,user.getPassword())) {
			err++;
			model.addAttribute("passworderr", "Password incorrect!");
			//errors.rejectValue("password", "Password incorrect!");
		}
		if (!newpassword.trim().equals(newpassword2)) {
			err++;
			model.addAttribute("password1err", "Confirm password doesn't match!");
			//errors.rejectValue("password1", "Confirm password doesn't match!");
		}
		if (err>0) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
			model.addAttribute("password", oldpassword);
			model.addAttribute("password1", newpassword);
			model.addAttribute("password2", newpassword2);
			return "changepassword";
		} else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				
				user.setPassword(passwordEncoder.encode(newpassword));
				//user.setPassword(newpassword);
				session.update(user);
				t.commit();
				 session2.setAttribute("user", user);
				//re.addFlashAttribute("message", "Them moi thanh cong!");
				
				model.addAttribute("message", "Doi mat khau thanh cong!");
				model.remove("password");
				model.remove("password1");
				model.remove("password2");
				session.close();

			} catch (Exception e) {
				t.rollback();
				// re.addFlashAttribute("message", "Them moi that bai!");
				model.addAttribute("message", "Doi mat khau that bai!");
				session.close();
				return "redirect:/welcome.htm";
			}
			return "redirect:/welcome.htm";
		}
	}
	public Users loadUserByEmail(final String email) {
	    //List<Users> users = new ArrayList<Users>();
	    Session session = factory.getCurrentSession();
	    String hql = "from Users where email='"+email+"'";
	    Query query2 = session.createQuery(hql);
	    List<Users> users = query2.list();
	    //users = session.createQuery("from User where username=?", Users.class).setParameter(0, username).list();
	    if (users.size() > 0) {
	      return users.get(0);
	    } else {
	      return null;
	    }
	  }
	
}
