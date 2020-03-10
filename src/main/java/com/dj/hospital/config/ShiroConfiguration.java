package com.dj.hospital.config;

import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Shiro配置
 */
@Configuration
@DependsOn("shiroRealm")
public class ShiroConfiguration {

    /**
     * 自定义Realm
     */
    @Autowired
    private ShiroRealm shiroRealm;

    /**
     * 安全管理器
     *
     * @return
     */
    @Bean
    DefaultWebSecurityManager securityManager() {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(shiroRealm);
        return securityManager;
    }

    /**
     * Shiro过滤器工厂
     *
     * @param securityManager
     * @return
     */
    @Bean
    ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
        // 定义 shiroFactoryBean
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        // 设置securityManager
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        // 设置默认登录的 URL，身份认证失败会访问该 URL
        shiroFilterFactoryBean.setLoginUrl("/user/toIndex");
        // 设置成功之后要跳转的链接
        shiroFilterFactoryBean.setSuccessUrl("/user/toIndex");
        // 设置未授权界面，权限认证失败会访问该 URL
        shiroFilterFactoryBean.setUnauthorizedUrl("/403.jsp");
        Map<String, String> filters = new LinkedHashMap<>();
        //Map<String, String> filters = new HashMap<>();
        filters.put("/user/toIndex", "anon"); // anon 表示不需要认证
        filters.put("/user/toLogin", "anon"); // anon 表示不需要认证
        filters.put("/user/getSalt", "anon"); // anon 表示不需要认证
        filters.put("/user/login", "anon"); // anon 表示不需要认证
        filters.put("/user/toAdd", "anon"); // anon 表示不需要认证
        filters.put("/user/add", "anon"); // anon 表示不需要认证
        filters.put("/user/findByName", "anon"); // anon 表示不需要认证
        filters.put("/user/findByPhone", "anon"); // anon 表示不需要认证
        filters.put("/user/findByUserEmail", "anon"); // anon 表示不需要认证
        filters.put("/user/active", "anon"); // anon 表示不需要认证
        filters.put("/user/toLoginPhone", "anon"); // anon 表示不需要认证
        filters.put("/user/send", "anon"); // anon 表示不需要认证
        filters.put("/user/loginPhoneMessages", "anon"); // anon 表示不需要认证
        filters.put("/logout", "anon"); // anon 表示不需要认证
        filters.put("/res/**", "anon"); // anon 表示不需要认证
        filters.put("/**", "authc"); // authc 表示必须认证才可访问
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filters);
        return shiroFilterFactoryBean;
    }

}
