package com.dj.hospital.web.page;

import com.dj.hospital.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/register/")
public class RegisterPageController {

    @Autowired
    private RegisterService registerService;

    /**
     *  去展示
     */
    @RequestMapping("toShow")
    public String toShow() {
        return "register/show";
    }
    /**
     *  去展示病史
     */
    @RequestMapping("toShowHistory")
    public String toShowHistory() {
        return "register/history";
    }

}
