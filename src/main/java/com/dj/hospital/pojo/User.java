package com.dj.hospital.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@TableName("user")
public class User extends BasePojo{

    private String userName;

    private String password;


}
