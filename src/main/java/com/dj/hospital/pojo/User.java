package com.dj.hospital.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@Accessors(chain = true)
@TableName("user")
public class User extends BasePojo{

    private String userName;

    private String userEmail;

    private String password;

    private String phone;

    private String salt;

    private Integer status;

    private Integer sex;

    private Integer age;

    private String code;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date codeTime;

    /* private String subject;*/

    /**
     * 1管理员2医生3患者
     */
    private String type;
    @TableField(exist = false)
    private String typeShow;

    public String getTypeShow() {
        if (null != type && type.equals(SystemConstant.TYPE_DOCTOR)) {
            return "医生";
        }
        if (null != type && type.equals(SystemConstant.TYPE_SICK)) {
            return "患者";
        }
        return "管理员";
    }




}
