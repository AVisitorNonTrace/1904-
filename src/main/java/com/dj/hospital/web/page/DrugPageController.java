package com.dj.hospital.web.page;

import com.dj.hospital.service.DrugService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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



}
