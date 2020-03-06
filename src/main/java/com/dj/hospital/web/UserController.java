package com.dj.hospital.web;

import com.aliyuncs.exceptions.ClientException;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.api.R;
import com.dj.hospital.common.ResultModel;
import com.dj.hospital.common.SystemConstant;
import com.dj.hospital.config.JavaEmailUtils;
import com.dj.hospital.pojo.User;
import com.dj.hospital.service.UserService;
import com.dj.hospital.utils.MessageVerifyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.Date;

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
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.or(i -> i.eq("user_name", userName)
                    .or().eq("phone", userName)
                    .or().eq("user_email", userName));
            queryWrapper.eq("password",password);
            User user = userService.getOne(queryWrapper);
            if (null == user) {
                return new ResultModel<>().error("用户名或者密码错误");
            }
            //判断邮箱是否激活
            if (user.getStatus().equals(SystemConstant.STATUS_IS_NOT_ACTIVATE)) {
                return new ResultModel<>().error("用户未激活,请登录邮箱激活");
            }
            session.setAttribute("USER",user);
            return new ResultModel<>().success("登录成功");
        } catch (Exception e) {
            e.printStackTrace();
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

}
