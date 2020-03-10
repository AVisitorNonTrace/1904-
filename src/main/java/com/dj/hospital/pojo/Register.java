package com.dj.hospital.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.dj.hospital.common.SystemConstant;
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

    @TableField(exist = false)
    private String orderStatusShow;

    public String getOrderStatusShow() {
        if (orderStatus.equals(SystemConstant.ORDER_STATUS_IN)){
            return "预约中";
        }
        if (orderStatus.equals(SystemConstant.ORDER_STATUS_FINISG)){
            return "预约结束";
        }
        return "预约成功";
    }

    private Integer doctorId;

    private String illnessName;

    private String remarks;

    private String drugName;

}
