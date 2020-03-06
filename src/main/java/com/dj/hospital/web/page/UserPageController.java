package com.dj.hospital.web.page;

import com.dj.hospital.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    public String toLogin(){
        return "user/login";
    }

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
    public String toAdd(){
        return "user/add";
    }

}
