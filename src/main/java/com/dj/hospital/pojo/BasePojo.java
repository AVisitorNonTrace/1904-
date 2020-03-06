package com.dj.hospital.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.Date;


@Data
@Accessors(chain = true)
public class BasePojo {

	/**
	 * id
	 */
	@TableId(type = IdType.AUTO)
	private Integer id;

	/**
	 * ������id
	 */
	private Integer createUserId;

	/**
	 * ����ʱ��
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date createTime;

	/**
	 * ����ʱ��չʾ
	 */
	private String createTimeShow;

	public String getCreateTimeShow() {
		if (createTime == null) {
			return "";
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(createTime);
	}

	/**
	 * �޸���id
	 */
	private Integer updateUserId;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date updateTime;

	/**
	 * ɾ���� 1�� ���� 0��ɾ��
	 */
	private Integer isDel;
}
