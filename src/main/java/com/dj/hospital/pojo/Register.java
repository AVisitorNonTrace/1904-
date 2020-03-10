package com.dj.hospital.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@TableName("register")
public class Register extends BasePojo{

    private Integer userId;
    /**
     * 预约状态1预约成功2预约中3预约结束
     */
    private Integer orderStatus;

    private Integer doctorId;

    private String illnessName;

    private String remarks;

    private String drugName;

}
