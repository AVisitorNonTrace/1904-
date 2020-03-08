package com.dj.hospital.common;

public interface SystemConstant {

    /**
     * 已激活
     */
    Integer STATUS_IS_ACTIVATE = 1;

    /**
     * 已激活
     */
    Integer STATUS_IS_NOT_ACTIVATE = -1;

    /**
     * 未删除
     */
    Integer IS_NOT_DEL = 1;

    /**
     * 已删除
     */
    Integer IS_DEL = 0;

    /**
     * 每页size
     */
    Integer PAGE_SIZE = 5;

    /**
     * 患者
     */
    String TYPE_SICK = "3";

    /**
     * 医生
     */
    String TYPE_DOCTOR = "2";

    /**
     * 患者_医生
     */
    String TYPE_DOCTOR_SICK = "4";

    /**
     * 管理员
     */
    String TYPE_ADMIN = "1";


}
