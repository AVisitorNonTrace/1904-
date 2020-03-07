package com.dj.hospital.web.page;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.dj.hospital.pojo.User;
import com.dj.hospital.service.UserService;
import com.dj.hospital.utils.PasswordSecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user/")
public class UserPageController {

    @Autowired
    private UserService userService;

    /**
     * 去登录
     */
    @RequestMapping("toLogin")
    public String toLogin(){ return "user/login"; }

    /**
     *  去展示
     */
    @RequestMapping("toShow")
    public String toShow() {
        return "user/show";
    }

    /**
     *  去注册
     */
    @RequestMapping("toAdd")
    public String toAdd(ModelMap model) throws Exception {
        String salt = PasswordSecurityUtil.generateSalt();
        model.put("salt",salt);
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

}
