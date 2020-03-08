package com.dj.hospital.web.page;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dj.hospital.pojo.Drug;
import com.dj.hospital.service.DrugService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/drug/")
public class DrugPageController {

    @Autowired
    private DrugService drugService;
    /**
     *  去展示
     */
    @RequestMapping("toShow")
    public String toShow() {
        return "drug/show";
    }

    /**
     *  去新增
     */
    @RequestMapping("toAdd")
    public String toAdd() {
        return "drug/add";
    }


    /**
     * 去修改
     */
    @RequestMapping("toUpdate/{id}")
    public ModelAndView toUpdate(@PathVariable("id") Integer id){
        QueryWrapper<Drug> wrapper = new QueryWrapper<>();
        wrapper.eq("id", id);
        Drug drug = drugService.getOne(wrapper);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("drug/update");
        modelAndView.addObject("drug", drug);
        return modelAndView;
    }

}
