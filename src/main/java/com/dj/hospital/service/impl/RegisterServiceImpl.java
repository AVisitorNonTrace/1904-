package com.dj.hospital.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dj.hospital.mapper.RegisterMapper;
import com.dj.hospital.pojo.Register;
import com.dj.hospital.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class)
public class RegisterServiceImpl extends ServiceImpl<RegisterMapper, Register> implements RegisterService {


}
