package vote.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import vote.entity.Users;

public class AdminInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse reponse,Object handler) throws Exception{
		//System.out.println("preAdmin");
		
		HttpSession session = request.getSession();
		Users a = (Users)session.getAttribute("user");
		if(a==null||!a.getEmail().equals("admin@admin")) {
			reponse.sendRedirect(request.getContextPath()+"/login.htm");
			return false;
		}
		return true;
	}
}
