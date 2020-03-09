package com.dj.hospital.web;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dj.hospital.common.ResultModel;
import com.dj.hospital.common.SystemConstant;
import com.dj.hospital.pojo.Register;
import com.dj.hospital.pojo.User;
import com.dj.hospital.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;

@RestController
@RequestMapping("/register/")
public class RegisterController {

    @Autowired
    private RegisterService registerService;

    /**
     * 病历表展示
     */
    @PostMapping("showRegister")
    public ResultModel<Object> showRegister(Register register, Integer pageNo, HttpSession session){
        HashMap<String,Object> map = new HashMap<>();
        try {
            IPage<Register> page = new Page<>(pageNo,SystemConstant.PAGE_SIZE);
            //定义_开始页_size
            QueryWrapper<Register> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("is_del",SystemConstant.IS_NOT_DEL);
            User user = (User) session.getAttribute("USER");
            if (user.getType().equals(SystemConstant.TYPE_DOCTOR)){
                queryWrapper.eq("doctor_id",user.getId());
            }
            if (user.getType().equals(SystemConstant.TYPE_SICK)){
                queryWrapper.eq("user_id",user.getId());
            }
            IPage<Register> pageInfo = registerService.page(page,queryWrapper);
            //返回_总页码
            map.put("totalNum", pageInfo.getPages());
            //返回_展示数据
            map.put("registerlist", pageInfo.getRecords());
            return new ResultModel<>().success(map);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 病历单添加
     */
    @RequestMapping("add")
    public ResultModel<Object> save(Register register, HttpServletRequest request,  HttpSession session) {
        try {
            User user = (User) session.getAttribute("USER");
            register.setUserId(user.getId()).setCreateTime(new Date()).setIsDel(SystemConstant.IS_NOT_DEL).setCreateUserId(user.getId());
            registerService.save(register);
            return new ResultModel<>().success("预约病例成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }
    /**
     * 病历单删除
     */
    @DeleteMapping
    public ResultModel<Object> del(Integer id,Integer isDel){
        try {
            UpdateWrapper<Register> registerUpdateWrapper = new UpdateWrapper<>();
            registerUpdateWrapper.set("is_del",isDel).eq("id",id);
            registerService.update(registerUpdateWrapper);
            return new ResultModel<>().success(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 病历单修改
     */
    @PutMapping
    public ResultModel<Object> update(Register register){
        try {
            UpdateWrapper<Register> registerUpdateWrapper = new UpdateWrapper<>();
            registerUpdateWrapper.set("order_status",register.getOrderStatus())
                    .eq("id",register.getId());
            registerService.update(registerUpdateWrapper);
            return new ResultModel<>().success("处理完毕");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }
}
