package vote.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import vote.entity.Users;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
@Override
public boolean preHandle(HttpServletRequest request,HttpServletResponse reponse,Object handler) throws Exception{
	//System.out.println("preLogger");
	HttpSession session = request.getSession();
	Users a = (Users)session.getAttribute("user");
	if(a==null||a.getBan()==true) {
		reponse.sendRedirect(request.getContextPath()+"/login.htm");
		return false;
	}
	return true;
}
}
