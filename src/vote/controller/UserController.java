package vote.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.apache.http.client.ClientProtocolException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vote.bean.GooglePojo;
import vote.bean.GoogleUtils;
import vote.entity.RoleN;
import vote.entity.Users;
import vote.entity.UsersRole;
@Transactional
@Controller
public class UserController {
	Users user = null;
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(ModelMap model) {

		return "login";
	}
	@RequestMapping(value = "/login",params="error", method = RequestMethod.GET)
	public String loginerr(ModelMap model) {
		model.addAttribute("message", "Đăng nhập thất bại!");
		return "login";
	}
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(ModelMap model, @RequestParam("email") String email, @RequestParam("password") String password,
			HttpSession session2) {

		Session session = factory.getCurrentSession();
		String hql = "select email,password from Users where email='" + email + "'and password='" + password
				+ "'";
		Query query = session.createQuery(hql);
		List<Object> list = query.list();
		if (!list.isEmpty()) {
			String hql2 = "from Users where email='" + email + "'and password='" + password + "' and ban=false";
			Query query2 = session.createQuery(hql2);
			List<Users> list2 = query2.list();
			if(list2.isEmpty()) {
				model.addAttribute("email", email);
				model.addAttribute("message", "Tài khoản đã bị ban!");
				return "login";
			}
			user = list2.get(0);
			// user = (Users) session.get(Users.class, email);
			session2.setAttribute("user", user);
			if (user.getEmail().equals("admin@admin")) {
				return "redirect:/admin.htm";
			}
			return "redirect:/welcome.htm";
		}
		model.addAttribute("email", email);
		model.addAttribute("message", "Đăng nhập thất bại!");
		return "login";
	}
	@RequestMapping(value = "/logoff")
	public String logoff(ModelMap model, HttpSession session2) {
		user = null;
		session2.removeAttribute("user");
		session2.removeAttribute("topic");
		return "redirect:/welcome.htm";
	}
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(ModelMap model) {
		model.addAttribute("userNew", new Users());
		model.addAttribute("password2", "");
		return "signup";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signup(ModelMap model, @ModelAttribute("userNew") Users user,
			@RequestParam("password2") String password, @RequestParam("photo2") MultipartFile photo,
			HttpSession session2, BindingResult errors) {
		model.addAttribute("password2", password);
		if(user.getEmail().isEmpty()) {
			errors.rejectValue("email", "userNew", "Email is empty!");
		}
		Session session1 = factory.getCurrentSession();
		String hql = "select email from Users where email='" + user.getEmail() + "'";
		Query query = session1.createQuery(hql);
		List<Object> list = query.list();
		if (!list.isEmpty()) {
			errors.rejectValue("email", "userNew", "Email is already in use");
		}

		if (!user.getPassword().trim().equals(password)) {
			errors.rejectValue("password", "userNew", "Confirm password doesn't match");
		}
		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
				&& (!photo.isEmpty())) {
			errors.rejectValue("photo", "userNew", "The image type for the file is invalid");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
			return "signup";
		} else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				if (!photo.isEmpty()) {
					int i = 0;
					String name = photo.getOriginalFilename();
					String photoPath = context.getRealPath("/files/ava/" + name);
					while (Files.exists(Paths.get(photoPath))) {
						i++;
						photoPath = context.getRealPath("/files/ava/" + i + name);
					}
					if (i != 0) {
						name = i + name;
					}
					//System.out.println(photoPath);
					photo.transferTo(new File(photoPath));
					user.setPhoto("files/ava/" + name);
				}
				user.setBan(false);
				PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
				user.setPassword(passwordEncoder.encode(user.getPassword()));
				UsersRole roleU = new UsersRole();
				roleU.setUser(user);
				RoleN r = (RoleN)session.get(RoleN.class, 2);
				roleU.setRole(r);
				session.save(roleU);
				session.save(user);
				t.commit();
				this.user = user;
				 session2.setAttribute("user", user);
				 model.remove("password2");
				// re.addFlashAttribute("message", "Them moi thanh cong!");
				model.addAttribute("message", "Them moi thanh cong!");
				session.close();

			} catch (Exception e) {
				t.rollback();
				// re.addFlashAttribute("message", "Them moi that bai!");
				model.addAttribute("message", "Them moi that bai!");
				session.close();
				return "redirect:/welcome.htm";
			}
			return "redirect:/welcome.htm";
		}
	}
	@RequestMapping(value = "/user/edit", method = RequestMethod.GET)
	public String editUser(ModelMap model, HttpSession session2) {
		user = (Users) session2.getAttribute("user");
		model.addAttribute("where", 5);
		model.addAttribute("userEdit", user);
		return "editUser";
	}

	@RequestMapping(value = "/user/edit", method = RequestMethod.POST)
	public String editUser(ModelMap model, @ModelAttribute("userEdit") Users user2,
			@RequestParam("photo2") MultipartFile photo, HttpSession session2, BindingResult errors) {
		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
				&& (!photo.isEmpty())) {
			errors.rejectValue("photo", "userEdit", "The image type for the file is invalid");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
			return "editUser";
		} else {
			Session session = factory.openSession();
			user = (Users) session2.getAttribute("user");
			Transaction t = session.beginTransaction();
			try {
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
					user2.setPhoto(user.getPhoto());
				}
				user2.setEmail(user.getEmail());
				user2.setPassword(user.getPassword());
				user2.setBan(false);
				session.update(user2);
				user = user2;
				session2.setAttribute("user", user2);
				t.commit();
				// re.addFlashAttribute("message", "Them moi thanh cong!");
				model.addAttribute("message", "Sua user thanh cong!");
				session.close();

			} catch (Exception e) {
				t.rollback();
				// re.addFlashAttribute("message", "Them moi that bai!");
				//System.out.println(e);
				model.addAttribute("message", "Sua that bai!");
				session.close();
				return "redirect:/welcome.htm";
			}
			return "redirect:/welcome.htm";
		}
	}
	@RequestMapping("/logingg")
	public String loginGoogle(ModelMap model, HttpServletRequest request, HttpSession session2,RedirectAttributes re)
			throws ClientProtocolException, IOException {
		String code = request.getParameter("code");

		if (code == null || code.isEmpty()) {
			return "redirect:/login.htm?message=google_error";
		}
		String accessToken = GoogleUtils.getToken(code);

		GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
		Session session = factory.getCurrentSession();
		String hql = "select email from Users where email='" + googlePojo.getEmail() + "'";
		Query query = session.createQuery(hql);
		List<Object> list = query.list();
		if (!list.isEmpty()) {
			String hql2 = "from Users where email='" + googlePojo.getEmail() + "' and ban=false";
			Query query2 = session.createQuery(hql2);
			List<Users> list2 = query2.list();
			if(list2.isEmpty()) {
				re.addFlashAttribute("message", "Tài khoản đã bị ban!");
				//model.addAttribute("message", "Tài khoản đã bị ban!");
				return "redirect:/login.htm";
			}
			user = list2.get(0);
			// user = (Users) session.get(Users.class, email);
			session2.setAttribute("user", user);
			if (user.getEmail().equals("admin@admin")) {
				return "redirect:/admin.htm";
			}
			return "redirect:/welcome.htm";
		} else {
			/*
			 * model.addAttribute("email", googlePojo.getEmail());
			 * model.addAttribute("name", googlePojo.getName());
			 */
			session2.setAttribute("email", googlePojo.getEmail());
			session2.setAttribute("name", googlePojo.getName());
			session2.setAttribute("photo", googlePojo.getPicture());
			/*
			 * request.setAttribute("name", googlePojo.getName());
			 * 
			 * request.setAttribute("email", googlePojo.getEmail());
			 */
			return "redirect:/signupgg.htm";
		}

	}

	@RequestMapping(value = "/signupgg", method = RequestMethod.GET)
	public String signupgg(ModelMap model, HttpSession session2) {
		Users a = new Users();

		a.setEmail((String) session2.getAttribute("email"));
		a.setFullname((String) session2.getAttribute("name"));
		a.setPhoto((String) session2.getAttribute("photo"));
		model.addAttribute("userNew", a);
		model.addAttribute("password2", "");
		return "signupgg";
	}

	@RequestMapping(value = "/signupgg", method = RequestMethod.POST)
	public String signupgg(ModelMap model, @ModelAttribute("userNew") Users user,
			@RequestParam("password2") String password, @RequestParam("photo2") MultipartFile photo,
			HttpSession session2, BindingResult errors) {
		model.addAttribute("password2", password);
		if (!user.getPassword().trim().equals(password)) {
			errors.rejectValue("password", "userNew", "Confirm password doesn't match");
		}
		if ((!photo.getContentType().contains("image/png")) && (!photo.getContentType().contains("image/jpeg"))
				&& (!photo.isEmpty())) {
			errors.rejectValue("photo", "userNew", "The image type for the file is invalid");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau!");
			return "signupgg";
		} else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
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
					//System.out.println(photoPath);
					photo.transferTo(new File(photoPath));
					user.setPhoto("files/ava/" + name);
				} else {
					user.setPhoto((String) session2.getAttribute("photo"));
				}
				user.setBan(false);
				session.save(user);

				t.commit();
				this.user = user;
				session2.setAttribute("user", user);
				// re.addFlashAttribute("message", "Them moi thanh cong!");
				model.addAttribute("message", "Them moi thanh cong!");
				session.close();

			} catch (Exception e) {
				t.rollback();
				// re.addFlashAttribute("message", "Them moi that bai!");
				model.addAttribute("message", "Them moi that bai!");
				session.close();
				return "redirect:/welcome.htm";
			}
			return "redirect:/welcome.htm";
		}
	}
}
