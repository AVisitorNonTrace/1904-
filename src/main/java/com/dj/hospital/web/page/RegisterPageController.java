package com.dj.hospital.web.page;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dj.hospital.common.SystemConstant;
import com.dj.hospital.pojo.Register;
import com.dj.hospital.pojo.User;
import com.dj.hospital.service.RegisterService;
import com.dj.hospital.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/register/")
public class RegisterPageController {

    @Autowired
    private RegisterService registerService;

    @Autowired
    private UserService userService;

    /**
     *  去展示病历单
     */
    @RequestMapping("toShow")
    public String toShow() {
        return "register/show";
    }

    /**
     *  去增加病历单
     */
    @RequestMapping("toAdd")
    public String toAdd(User user, Model model) throws Exception {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("is_del", SystemConstant.IS_NOT_DEL).eq("type", SystemConstant.TYPE_DOCTOR);
        List<User> userList = userService.list(queryWrapper);
        model.addAttribute("userList", userList);
        return "register/add";
    }
    /**
     *  去修改病历单
     */
    @RequestMapping("toUpdate/{id}")
    public String toUpdate(@PathVariable Integer id, ModelMap map) {
        QueryWrapper<Register> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",id);
        Register register = registerService.getOne(queryWrapper);
        map.put("register",register);
        return "register/update";
    }
    /**
     *  去展示病史
     */
    @RequestMapping("toShowHistory")
    public String toShowHistory() {
        return "register/history";
    }

    /**
     *  去展示_已开药品
     */
    @RequestMapping("toSeeDrug/{id}")
    public String toSeeDrug(@PathVariable Integer id,ModelMap modelMap) {
        //查询此id开的药品
        QueryWrapper<Register> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",id);
        Register register = registerService.getOne(queryWrapper);
        modelMap.put("register",register);
        return "register/see_open_drug_show";
    }
}
