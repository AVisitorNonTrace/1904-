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
import com.dj.hospital.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/register/")
public class RegisterController {

    @Autowired
    private RegisterService registerService;
    @Autowired
    private UserService userService;

    /**
     * 预约
     */
    @RequestMapping("add")
    public ResultModel<Object> save(Register register) {
        try {
            QueryWrapper<Register> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("user_id", register.getUserId())
                        .eq("is_del", SystemConstant.IS_NOT_DEL);
            List<Register> registerList = registerService.list(queryWrapper);
            QueryWrapper<Register> wrapper = new QueryWrapper<>();
            wrapper.eq("doctor_id", register.getDoctorId());
            List<Register> list = registerService.list(wrapper);
            QueryWrapper<Register> registerQueryWrapper = new QueryWrapper<>();
            registerQueryWrapper.eq("doctor_id", register.getDoctorId())
                    .eq("user_id", register.getUserId()).eq("is_del", SystemConstant.IS_NOT_DEL);
            Register register1 = registerService.getOne(registerQueryWrapper);
            if (register1!= null && register1.getDoctorId().equals(register.getDoctorId())) {
                return new ResultModel<>().error("您也预约过该医生,请等待!");
            }
            if (registerList.size()  == 1) {
                return new ResultModel<>().error("您最多预约一位医生,如果需要预约其他医生,请去取消!");
            }
            if (list.size() == 5) {
                return new ResultModel<>().error("该医生已经预约了很多人了,请等待再进行预约!");
            }


            register.setCreateTime(new Date()).setIsDel(SystemConstant.IS_NOT_DEL);
            registerService.save(register);
            return new ResultModel<>().success("预约成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }
    /**
     * 预约展示
     */
    @PostMapping("list")
    public ResultModel<Object> list(Register register, Integer pageNo, HttpSession session){
        HashMap<String,Object> map = new HashMap<>();
        try {
            IPage<Register> page = new Page<>(pageNo,SystemConstant.PAGE_SIZE);
            //定义_开始页_size
            QueryWrapper<Register> queryWrapper = new QueryWrapper<>();
            //患者只能看到自己
            User user = (User) session.getAttribute("USER");
            if (user.getType().equals(SystemConstant.TYPE_SICK)){
                queryWrapper.eq("user_id",user.getId());
                queryWrapper.eq("is_del",SystemConstant.IS_NOT_DEL);
                IPage<Register> pageInfo = registerService.page(page,queryWrapper);
                //返回_总页码
                map.put("totalNum", pageInfo.getPages());
                //返回_展示数据
                map.put("registerList", pageInfo.getRecords());
                return new ResultModel<>().success(map);
            }
            //管理员看到所有
            queryWrapper.orderByDesc("id").eq("is_del",SystemConstant.IS_NOT_DEL);
            IPage<Register> pageInfo = registerService.page(page,queryWrapper);
            //返回_总页码
            map.put("totalNum", pageInfo.getPages());
            //返回_展示数据
            map.put("registerList", pageInfo.getRecords());
            return new ResultModel<>().success(map);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }
    /**
     * 张慧_用户删除
     */
    @DeleteMapping
    public ResultModel<Object> del(Integer id,Integer isDel){
        try {
            UpdateWrapper<Register> userUpdateWrapper = new UpdateWrapper<>();
            userUpdateWrapper.set("is_del",isDel).eq("id",id);
            registerService.update(userUpdateWrapper);
            return new ResultModel<>().success(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

}
