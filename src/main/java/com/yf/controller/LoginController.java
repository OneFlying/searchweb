package com.yf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.yf.dao.UserDao;
import com.yf.dao.WebsiteconfigDao;
import com.yf.model.User;
import com.yf.model.Websitconfig;

@Controller
@RequestMapping("/")
public class LoginController {

	@Resource(name="userDao")
	private UserDao userDao;
	
	@Resource
	private WebsiteconfigDao websiteconfigDao;
	/**
	 * 检测用户登录
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value="/admin/login",method=RequestMethod.POST)
	@ResponseBody
	public ModelMap checkLogin(HttpServletRequest request,String username,String password){
		ModelMap modelMap = new ModelMap();
		User user = userDao.checkLogin(username, password);
		if(user != null){
			request.getSession().setAttribute("curUser", user);
			modelMap.put("success", true);
			modelMap.put("url", "/admin");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "用户名或密码错误");
		}
		
		return modelMap;
	}
	
	/**
	 * 退出登录
	 * @param request
	 * @return
	 * 2014-12-3
	 *
	 */
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session=request.getSession(false);
		if(session!=null){
			request.getSession().removeAttribute("curUser");
		    request.getSession().invalidate(); 
		    Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
			modelAndView.addObject("logourl",websitconfig.getLogourl());
			modelAndView.addObject("title",websitconfig.getTitle());
		    modelAndView.setViewName("login");
		}
	    return modelAndView;

		//防止创建seesion
		/*HttpSession session=request.getSession(false);
		UserContext usc = UserContext.getInstance();
		//String username = (String) session.getAttribute("username");
		//String password = (String) session.getAttribute("password");
		//User user = userService.getUserByName(username);
		if(session!=null){
			//User  user = (User) session.getAttribute("user");
			User user = usc.getCurrentUser(request);
			usc.remove(user.getId());
			userService.updateUserStatus(user.getId(), Userstatus.USER_NOT_ONLINE);
			request.getSession().invalidate();
			//注销日志记录
			userLogService.save("用户"+user.getUserRealName()+"注销成功", OperaCode.LOGOUT_CODE, OperaCode.LOGIN_OUT_TYPE, user.getUserName(),user.getFayuannum());
			modelAndView.setViewName("login");
		}
		return modelAndView;*/
	}
	/**
	 * 跳转到管理员页面
	 * @return
	 */
//	@RequestMapping(value="/admin/index")
//	public String skipToAdmin(){
//		return "admin";
//	}
}
