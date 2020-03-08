package com.dj.hospital.web;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dj.hospital.common.ResultModel;
import com.dj.hospital.common.SystemConstant;
import com.dj.hospital.pojo.Drug;
import com.dj.hospital.service.DrugService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@RestController
@RequestMapping("/drug/")
public class DrugController {

    @Autowired
    private DrugService drugService;

    @PostMapping("list")
    public ResultModel<Object> list(Drug drug, Integer pageNo,HttpSession session){
        HashMap<String,Object> map = new HashMap<>();
        try {
            IPage<Drug> page = new Page<>(pageNo,SystemConstant.PAGE_SIZE);
            //定义_开始页_size
            QueryWrapper<Drug> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("is_del",SystemConstant.IS_NOT_DEL);
                IPage<Drug> pageInfo = drugService.page(page,queryWrapper);
                //返回_总页码
                map.put("totalNum", pageInfo.getPages());
                //返回_展示数据
                map.put("druglist", pageInfo.getRecords());
                return new ResultModel<>().success(map);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }


}
