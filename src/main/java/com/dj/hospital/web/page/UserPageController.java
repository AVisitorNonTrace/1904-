package com.dj.hospital.web.page;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.dj.hospital.mapper.UserMapper;
import com.dj.hospital.pojo.User;
import com.dj.hospital.service.UserService;
import com.dj.hospital.utils.PasswordSecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/user/")
public class UserPageController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserMapper userMapper;

    /**
     * 去登录
     */
    @RequestMapping("toLogin")
    public String toLogin(){ return "user/login"; }

    /**
     *  去展示
     */
    @RequestMapping("toShow")
    public String toShow(String types, ModelMap modelMap) {
        modelMap.put("types",types);
        return "user/show";
    }

    /**
     *  去注册
     */
    @RequestMapping("toAdd")
    public String toAdd(String types, ModelMap model) throws Exception {
        String salt = PasswordSecurityUtil.generateSalt();
        model.put("salt",salt);
        model.put("types",types);
        return "user/add";
    }

    /**
     * 张慧_邮箱激活
     */
    @RequestMapping("active")
    public String active(Integer id, Integer status) {
        UpdateWrapper<User> userUpdateWrapper = new UpdateWrapper<>();
        userUpdateWrapper.set("status",status);
        userUpdateWrapper.eq("id",id);
        userService.update(userUpdateWrapper);
        return "redirect:/user/toLogin";
    }

    /**
     *  手机号快速登录_去登录
     */
    @RequestMapping("toLoginPhone")
    public String toLoginPhone() {
        return "user/login_phone";
    }

    /**
     *  退出_session失效
     */
    @RequestMapping("quit")
    public String quit() {
        return "/user/login";
    }

    /**
     * 找回密码
     */
    @RequestMapping("toFind")
    public String toFind(){ return "user/find_pwd"; }

    /**
     * 找回密码
     */
    @RequestMapping("toUpdatePwd/{id}")
    public ModelAndView toUpdatePwd(@PathVariable("id") Integer id) throws Exception {
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("id", id);
        User user = userService.getOne(wrapper);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/update_pwd");
        modelAndView.addObject("user", user);
        String salt = PasswordSecurityUtil.generateSalt();
        modelAndView.addObject("salt",salt);
        return modelAndView;
    }
    /**
     *  张慧_去修改
     */
    @RequestMapping("toUpdate")
    public String toUpdate(Integer id,String types, ModelMap map) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",id);
        User user = userService.getOne(queryWrapper);
        map.put("user",user);
        map.put("types",types);
        return "user/update";
    }
    /**
     * 首页展示
     */
    @RequestMapping("toIndex")
    public String toIndex(){ return "user/index"; }

    /**
     * 去挂号
     */
    @RequestMapping("toRegister")
    public String toRegister(Model model){
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("type",2);
        List<User> doctorlist = userMapper.selectList(queryWrapper);
        model.addAttribute("doctorlist",doctorlist);
        return "user/register";
    }
}
