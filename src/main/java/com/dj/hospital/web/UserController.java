package com.dj.hospital.web;

import com.aliyuncs.exceptions.ClientException;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.api.R;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dj.hospital.common.ResultModel;
import com.dj.hospital.common.SystemConstant;
import com.dj.hospital.config.JavaEmailUtils;
import com.dj.hospital.pojo.User;
import com.dj.hospital.service.UserService;
import com.dj.hospital.utils.MessageVerifyUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

@RestController
@RequestMapping("/user/")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 张慧_登录账户_获取盐
     */
    @PostMapping("getSalt")
    public ResultModel<Object> getSalt(String userName){
        try {
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.or(i -> i.eq("user_name", userName)
                    .or().eq("phone", userName)
                    .or().eq("user_email", userName));
            User user = userService.getOne(queryWrapper);
            if (null == user){
                return new ResultModel<>().error("用户不存在");
            }
            ResultModel resultModel = new ResultModel().success(true);
            resultModel.setData(user.getSalt());
            return resultModel;
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 张慧_用户登录
     */
    @PostMapping("login")
    public ResultModel<Object> login(String userName, String password, HttpSession session) {
        try {
            //非空判断
            if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
                return new ResultModel<>().error("用户名或密码不能为空");
            }
            //shiro的登陆方式
            //得到认证
            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(userName,password);
            subject.login(token);
            return new ResultModel<>().success("登录成功");
        } catch (Exception e) {
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 张慧_注册_用户名去重
     */
    @PostMapping("findByName")
    public Boolean findByName(String userName) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.or(i -> i.eq("user_name", userName)
                .or().eq("phone", userName)
                .or().eq("user_email", userName));
        User user = userService.getOne(queryWrapper);
        return null == user ? true : false;
    }

    /**
     * 张慧_注册_手机号去重
     */
    @PostMapping("findByPhone")
    public Boolean findByPhone(String phone) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("phone",phone);
        User user = userService.getOne(queryWrapper);
        return null == user ? true : false;
    }

    /**
     * 张慧_注册_手机号去重
     */
    @PostMapping("findByUserEmail")
    public Boolean findByUserEmail(String userEmail) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_email",userEmail);
        User user = userService.getOne(queryWrapper);
        return null == user ? true : false;
    }

    /**
     * 张慧_用户注册
     */
    @RequestMapping("add")
    public ResultModel<Object> save(User user, HttpServletRequest request) {
        try {
            user.setCreateTime(new Date()).setIsDel(SystemConstant.IS_NOT_DEL);
            userService.save(user);
            String context = "<a href='http://localhost:8080/"+request.getContextPath()+"/user/active?id="+user.getId()+"&status="+SystemConstant.STATUS_IS_ACTIVATE+"'>点此激活</a>";
            System.out.print(context);
            JavaEmailUtils.sendEmail(user.getUserEmail(),"用户激活",context);
            return new ResultModel<>().success("注册成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 张慧_发送验证码
     */
    @RequestMapping("send")
    public ResultModel<Object> send(String phone) {
        try {
            if (StringUtils.isEmpty(phone)) {
                return new ResultModel<>().error("请输入手机号");
            }
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("phone",phone);
            User user = userService.getOne(queryWrapper);
            if (null == user) {
                return new ResultModel<>().error("手机号不存在");
            }
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            cal.add(Calendar.MINUTE, 1);// 增加一分钟
            user.setCodeTime(cal.getTime());
            String code=  String.valueOf(MessageVerifyUtils.getNewcode());
            user.setCode(code);
            MessageVerifyUtils.sendSms(user.getPhone(),code);
            UpdateWrapper<User> userUpdateWrapper = new UpdateWrapper<>();
            userUpdateWrapper.set("code",code).set("code_time",user.getCodeTime());
            userUpdateWrapper.eq("id",user.getId());
            userService.update(userUpdateWrapper);
            return new ResultModel<>().success("验证码发送成功");
        } catch (ClientException e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 张慧_短信验证码登录
     */
    @RequestMapping("loginPhoneMessages")
    public ResultModel<Object> loginPhoneMessages(User user,HttpSession session) {
        try {
            if (StringUtils.isEmpty(user.getPhone()) || StringUtils.isEmpty(user.getCode())) {
                return new ResultModel<>().error("输入框不能为空");
            }
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("phone",user.getPhone()).eq("code",user.getCode());
            User user1 = userService.getOne(queryWrapper);
            if (null == user1) {
                return new ResultModel<Object>().error("手机号或验证码错误");
            }
            if (user1.getCodeTime().before(new Date())) {
                return new ResultModel<Object>().error("验证码已失效");
            }
            session.setAttribute("USER", user1);
            return new ResultModel<Object>().success("登录成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 张慧_用户展示
     */
    @PostMapping("list")
    public ResultModel<Object> list(User user1, String types, Integer pageNo,HttpSession session){
        HashMap<String,Object> map = new HashMap<>();
        try {
            IPage<User> page = new Page<>(pageNo,SystemConstant.PAGE_SIZE);
            User user = (User) session.getAttribute("USER");
            //定义_开始页_size
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            //患者/医生只能看到自己
            if (user.getType().equals(SystemConstant.TYPE_SICK) || user.getType().equals(SystemConstant.TYPE_DOCTOR)){
                queryWrapper.eq("id",user.getId());
                IPage<User> pageInfo = userService.page(page,queryWrapper);
                //返回_总页码
                map.put("totalNum", pageInfo.getPages());
                //返回_展示数据
                map.put("userList", pageInfo.getRecords());
                return new ResultModel<>().success(map);
            }

            if (!StringUtils.isEmpty(user1.getUserName())) {
                queryWrapper.or(i -> i.like("user_name", user1.getUserName())
                        .or().like("phone", user1.getUserName())
                        .or().like("user_email", user1.getUserName()));
            }
            if (null != user1.getSex()) {
                queryWrapper.eq("sex",user1.getSex());
            }
            if (!StringUtils.isEmpty(user1.getType())) {
                queryWrapper.eq("type",user1.getType());
            }
            //管理员看医生和患者__人员管理
            if (types.equals(SystemConstant.TYPE_DOCTOR_SICK)){
                queryWrapper.ne("type",SystemConstant.TYPE_ADMIN);
                queryWrapper.orderByDesc("id").eq("is_del",SystemConstant.IS_NOT_DEL);
                IPage<User> pageInfo = userService.page(page,queryWrapper);
                //返回_总页码
                map.put("totalNum", pageInfo.getPages());
                //返回_展示数据
                map.put("userList", pageInfo.getRecords());
                return new ResultModel<>().success(map);
            }
            //管理员看自己__管理员管理
            if (types.equals(SystemConstant.TYPE_ADMIN)){
                queryWrapper.eq("type",SystemConstant.TYPE_ADMIN);
                queryWrapper.orderByDesc("id").eq("is_del",SystemConstant.IS_NOT_DEL);
                IPage<User> pageInfo = userService.page(page,queryWrapper);
                //返回_总页码
                map.put("totalNum", pageInfo.getPages());
                //返回_展示数据
                map.put("userList", pageInfo.getRecords());
                return new ResultModel<>().success(map);
            }
            //管理员看到所有
            //queryWrapper.orderByDesc("id").eq("is_del",SystemConstant.IS_NOT_DEL);
            //IPage<User> pageInfo = userService.page(page,queryWrapper);
            //返回_总页码
            //map.put("totalNum", pageInfo.getPages());
            //返回_展示数据
            //map.put("userList", pageInfo.getRecords());
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
            UpdateWrapper<User> userUpdateWrapper = new UpdateWrapper<>();
            userUpdateWrapper.set("is_del",isDel).eq("id",id);
            userService.update(userUpdateWrapper);
            return new ResultModel<>().success(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 张慧_用户修改
     */
    @PutMapping
    public ResultModel<Object> updateUser(User user){
        try {
            UpdateWrapper<User> userUpdateWrapper = new UpdateWrapper<>();
            userUpdateWrapper.set("user_name",user.getUserName()).set("user_email",user.getUserEmail())
                    .set("phone",user.getPhone()).set("password",user.getPassword())
                    .set("sex",user.getSex()).set("age",user.getAge())
                    .set("type",user.getType())
                    .eq("id",user.getId());
            userService.update(userUpdateWrapper);
            return new ResultModel<>().success(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    /**
     * 找回密码
     * @param user
     * @return
     */
    @PostMapping("find")
    public ResultModel<Object> show(User user) {
        HashMap<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isEmpty(user.getPhone()) || StringUtils.isEmpty(user.getCode())) {
                return new ResultModel<>().error("输入框不能为空");
            }
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("phone",user.getPhone()).eq("code",user.getCode());
            User user1 = userService.getOne(queryWrapper);
            if (null == user1) {
                return new ResultModel<Object>().error("手机号或验证码错误");
            }
            if (user1.getCodeTime().before(new Date())) {
                return new ResultModel<Object>().error("验证码已失效");
            }
            map.put("id", user1.getId());
            map.put("msg", 200);
            return new ResultModel<>().success(map);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(e.getMessage());
        }
    }

    @PostMapping
    public ResultModel<Object> update(User user) {
        userService.updateById(user);
        return new ResultModel<>().success();
    }

}
