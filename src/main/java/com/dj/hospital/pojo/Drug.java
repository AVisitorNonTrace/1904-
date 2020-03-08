package com.dj.hospital.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

@Data
@Accessors(chain = true)
@TableName("drug")
public class Drug {

    /**
     * id
     */
    @TableId(type = IdType.AUTO)
    private Integer id;
    /**
     * 药名
     */
    private String drugName;
    /**
     * 库存
     */
    private Integer count;
    /**
     * 价格
     */
    private BigDecimal price;
    /**
     * 0已删除1未删除状态
     */
    private Integer isDel;


}
