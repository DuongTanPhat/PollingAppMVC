package vote.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;

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

import vote.entity.Tag;
import vote.entity.Users;
import vote.entity.Vote;

@Transactional
@Controller
public class AdminController {
	Users user = null;
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	@RequestMapping(value = "/admin")
	public String admin(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "Select count(Email) as count from Users";
		String hql2 = "Select count(id) as count from Topics";
		String hql3 = "Select count(id) as count from Vote";
		String hql4 = "Select count(id) as count from Evaluate";
		String hql5 = "Select count(id) as count from Selection";
		String hql6 = "Select sum(rate) as sum from Evaluate";
		String hql7 = "Select count(id) as count from Tag";
		String hql8 = "from Vote";
		Query query = session.createQuery(hql);
		Query query2 = session.createQuery(hql2);
		Query query3 = session.createQuery(hql3);
		Query query4 = session.createQuery(hql4);
		Query query5 = session.createQuery(hql5);
		Query query6 = session.createQuery(hql6);
		Query query7 = session.createQuery(hql7);
		Query query8 = session.createQuery(hql8);

		Object list = query.list().get(0);
		Object list2 = query2.list().get(0);
		Object list3 = query3.list().get(0);
		Object list4 = query4.list().get(0);
		Object list5 = query5.list().get(0);
		Object list6 = query6.list().get(0);
		Object list7 = query7.list().get(0);
		query8.setMaxResults(5);
		query8.setFirstResult((int) ((long) list3 - (long) 5));
		List<Vote> list8 = query8.list();
		model.addAttribute("soUser", list);
		model.addAttribute("soTopics", list2);
		model.addAttribute("soVote", list3);
		model.addAttribute("soRate", list4);
		model.addAttribute("soLuaChon", list5);
		model.addAttribute("soSao", list6);
		model.addAttribute("soTag", list7);
		Collections.reverse(list8);
		model.addAttribute("listVote", list8);
		return "adminmanager";
	}

	@RequestMapping(value = "/usermanager")
	public String usermanager(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "From Users where email<>'admin@admin'";
		Query query = session.createQuery(hql);
		List<Users> list = query.list();
		model.addAttribute("listUserA", list);
		return "adminUserManager";
	}

	@RequestMapping(value = "/topicmanager")
	public String topicmanager(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "From Topics";
		Query query = session.createQuery(hql);
		List<Users> list = query.list();
		model.addAttribute("listTopicA", list);
		return "adminTopicManager";
	}

	@RequestMapping(value = "/tagmanager")
	public String tagmanager(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "From Tag";
		Query query = session.createQuery(hql);
		List<Users> list = query.list();
		model.addAttribute("listTagA", list);
		return "adminTagManager";
	}

	@RequestMapping(value = "/adminInsertTag")
	public String tagInsert(ModelMap model) {
		model.addAttribute("tag", new Tag());
		return "adminInsertTag";
	}

	@RequestMapping(value = "/adminInsertTag", method = RequestMethod.POST)
	public String tagInsert(ModelMap model, @ModelAttribute("tag") Tag tag, BindingResult errors) {
		Session session1 = factory.getCurrentSession();
		String hql = "From Tag where id = '" + tag.getId() + "'";
		Query query = session1.createQuery(hql);
		List<Users> list = query.list();
		if (!list.isEmpty()) {
			errors.rejectValue("id", "tag", "Id đã tồn tại");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
			return "adminInsertTag";
		} else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {

				session.save(tag);
				t.commit();
				model.addAttribute("message", "Them tag thanh cong!");
			} catch (Exception e) {
				t.rollback();
				model.addAttribute("message", "Them tag that bai!");
			} finally {
				session.close();
			}
			return "redirect:/tagmanager.htm";
		}
	}

	@RequestMapping(value = "/tag/edit/{idTag}", method = RequestMethod.GET)
	public String tagEdit(ModelMap model, @PathVariable("idTag") String idTag) {
		Session session = factory.getCurrentSession();
		Tag tag = (Tag) session.get(Tag.class, idTag);
		// if(topic.getUser().getEmail().equals(user.getEmail())||user.getEmail().equals("admin@admin"))
		// {
		model.addAttribute("tag", tag);
		// model.addAttribute("where",4);
		// model.addAttribute("photo2",topic.getPhoto());
//		return "edit";
//		}
		return "adminEditTag";
		// return "redirect:/login.htm";
	}

	@RequestMapping(value = "/tag/edit/{idTag}", method = RequestMethod.POST)
	public String tagEdit(ModelMap model, @ModelAttribute("tag") Tag tag, HttpSession session2, BindingResult errors) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(tag);
			t.commit();
			// re.addFlashAttribute("message", "Them moi thanh cong!");
			model.addAttribute("message", "Cap nhat thanh cong!");
			session.close();

		} catch (Exception e) {
			t.rollback();
			// re.addFlashAttribute("message", "Them moi that bai!");
			model.addAttribute("message", "Cap nhat that bai!");
			session.close();
		}
		return "redirect:/tagmanager.htm";
	}

	@RequestMapping(value = "/tag/delete/{idTag}")
	public String deleteTag(ModelMap model, @PathVariable("idTag") String idTag, HttpSession session2) {
		Session session = factory.openSession();
		user = (Users) session2.getAttribute("user");
		Transaction t = session.beginTransaction();
		String a = "redirect:/tagmanager.htm";
		try {
			Tag tag = (Tag) session.get(Tag.class, idTag);
			if (user.getEmail().equals("admin@admin")) {
				session.delete(tag);
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

	@RequestMapping(value = "/admin/ban/{email}")
	public String banUser(ModelMap model, @PathVariable("email") String email, HttpSession session2) {
		Session session = factory.openSession();
		user = (Users) session2.getAttribute("user");
		Transaction t = session.beginTransaction();
		String a = "redirect:/usermanager.htm";
		try {
			Users userBan = (Users) session.get(Users.class, email);
			if (user.getEmail().equals("admin@admin")) {
				userBan.setBan(true);
				session.update(userBan);
				t.commit();
				// re.addFlashAttribute("message", "Xoa thanh cong!");
				model.addAttribute("message", "Ban thanh cong!");
			} else
				a = "redirect:/login.htm";
		} catch (Exception e) {
			t.rollback();
			// re.addFlashAttribute("message", "Xoa that bai!");
			model.addAttribute("message", "Ban that bai!");
		} finally {
			session.close();
		}
		return a;
	}

	@RequestMapping(value = "/admin/unban/{email}")
	public String unbanUser(ModelMap model, @PathVariable("email") String email, HttpSession session2) {
		Session session = factory.openSession();
		user = (Users) session2.getAttribute("user");
		Transaction t = session.beginTransaction();
		String a = "redirect:/usermanager.htm";
		try {
			Users userBan = (Users) session.get(Users.class, email);
			if (user.getEmail().equals("admin@admin")) {
				userBan.setBan(false);
				session.update(userBan);
				t.commit();
				// re.addFlashAttribute("message", "Xoa thanh cong!");
				model.addAttribute("message", "unBan thanh cong!");
			} else
				a = "redirect:/login.htm";
		} catch (Exception e) {
			t.rollback();
			// re.addFlashAttribute("message", "Xoa that bai!");
			model.addAttribute("message", "unBan that bai!");
		} finally {
			session.close();
		}
		return a;
	}

	@RequestMapping(value = "/admin/edit/{email}", method = RequestMethod.GET)
	public String editAdminUser(ModelMap model, @PathVariable("email") String email) {
		Session session = factory.getCurrentSession();
		Users userEdit = (Users) session.get(Users.class, email);
		// if(topic.getUser().getEmail().equals(user.getEmail())||user.getEmail().equals("admin@admin"))
		// {
		model.addAttribute("userEdit", userEdit);
		return "adminEditUser";
		// return "redirect:/login.htm";
	}

	@RequestMapping(value = "/admin/edit/{email}")
	public String editAdminUser(ModelMap model, @PathVariable("email") String email,
			@ModelAttribute("userEdit") Users user2, @RequestParam("photo2") MultipartFile photo, HttpSession session2,
			BindingResult errors) {
		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
				&& (!photo.isEmpty())) {
			errors.rejectValue("photo", "userEdit", "The image type for the file is invalid");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
			return "adminEditUser";
		} else {
			Session session1 = factory.getCurrentSession();
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				Users user1 = (Users) session1.get(Users.class, email);
				int i = 0;
				String name = photo.getOriginalFilename();
				if (!name.isEmpty()) {
					String photoPath = context.getRealPath("/files/ava/" + name);
					while (Files.exists(Paths.get(photoPath))) {
						i++;

						photoPath = context.getRealPath("/files/ava/" + i + name);

					}
					if (i != 0) {
						name = i + name;
					}
					// String photoPath = context.getRealPath("/files/"+ Math.random()+
					// photo.getOriginalFilename());
					photo.transferTo(new File(photoPath));
					//System.out.println(photoPath);
					user2.setPhoto("files/ava/" + name);
				} else {

					user2.setPhoto(user1.getPhoto());
				}
				user2.setEmail(user1.getEmail());
				user2.setPassword(user1.getPassword());
				user2.setBan(user1.getBan());
				session.update(user2);
				// user = user2;
				// session2.setAttribute("user", user2);
				t.commit();
				// re.addFlashAttribute("message", "Them moi thanh cong!");
				model.addAttribute("message", "Sua user thanh cong!");
				session.close();

			} catch (Exception e) {
				t.rollback();
				// re.addFlashAttribute("message", "Them moi that bai!");
				//System.out.println(e);
				model.addAttribute("message", "Sua user that bai!");
				session.close();
				return "redirect:/usermanager.htm";
			}
			return "redirect:/usermanager.htm";
		}
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
