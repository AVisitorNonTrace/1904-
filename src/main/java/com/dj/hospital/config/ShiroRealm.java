package com.dj.hospital.config;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dj.hospital.common.ResultModel;
import com.dj.hospital.common.SystemConstant;
import com.dj.hospital.pojo.User;
import com.dj.hospital.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 自定义Realm
 */
@Component
public class ShiroRealm extends AuthorizingRealm {


    @Autowired
    private UserService userService;

    /**
     * 授权
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
/*        // 创建简单授权信息
        SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();
//        simpleAuthorInfo.addStringPermission("/test");
        return simpleAuthorInfo;*/
        return null;
    }

    /**
     * 认证
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 得到用户名
        String username = (String) authenticationToken.getPrincipal();
        // 得到密码
        String password = new String((char[]) authenticationToken.getCredentials());
        try {
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.or(i -> i.eq("user_name", username)
                    .or().eq("phone", username)
                    .or().eq("user_email", username));
            queryWrapper.eq("password",password);
            User user = userService.getOne(queryWrapper);

            if (null == user) {
                throw new AccountException("用户名或者密码错误");
                /* return new ResultModel<>().error("用户名或者密码错误");*/
            }
            //判断邮箱是否激活
            if (user.getStatus().equals(SystemConstant.STATUS_IS_NOT_ACTIVATE)) {
                throw new AccountException("用户未激活,请登录邮箱激活");
              /*  return new ResultModel<>().error("用户未激活,请登录邮箱激活");*/
            }
            Session session = SecurityUtils.getSubject().getSession();
            session.setAttribute("USER",user);
        } catch (InvalidSessionException e) {
            e.printStackTrace();
            throw new AccountException(e.getMessage());
        }
        return new SimpleAuthenticationInfo(username, password, getName());


    }

}
