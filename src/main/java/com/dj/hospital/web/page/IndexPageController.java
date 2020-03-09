package com.dj.hospital.web.page;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dj.hospital.pojo.Register;
import com.dj.hospital.pojo.User;
import com.dj.hospital.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/index/")
public class IndexPageController {

	@Autowired
	private RegisterService registerService;

	@RequestMapping("toIndex")
	public String toIndex() {
		return "/index/index";
	}
	
	@RequestMapping("toLeft")
	public String toLeft() {
		return "/index/left";
	}
	
	@RequestMapping("toRight")
	public String toRight(HttpSession session, Model model) {
		User user = (User) session.getAttribute("USER");
		QueryWrapper<Register> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("doctor_id", user.getId());
		List<Register> list = registerService.list(queryWrapper);
		model.addAttribute("size", list.size());
		return "/index/right";
	}
	
	@RequestMapping("toTop")
	public String toTop() {
		return "/index/top";
	}
	
}
