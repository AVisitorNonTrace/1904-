package com.dj.hospital.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dj.hospital.mapper.DrugMapper;
import com.dj.hospital.pojo.Drug;
import com.dj.hospital.service.DrugService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class)
public class DrugServiceImpl extends ServiceImpl<DrugMapper, Drug> implements DrugService {


}
