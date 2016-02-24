package org.dolphin.service.impl;

import org.dolphin.dao.ConsultDao;
import org.dolphin.entity.Consult;
import org.dolphin.service.ConsultService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
* Created by csophys with template on ${.now?date}.
*/
@Service
public class ConsultServiceImpl implements ConsultService {
    @Resource
    ConsultDao consultDao;

    @Override
    public int insert(Consult consult) {
    consultDao.insert(consult);
        return consult.getId();
    }

    @Override
    public Consult getById(int id) {
        return consultDao.getById(id);
    }

    @Override
    public List<Consult> getByField(String fieldName, String fieldValue) {
        return consultDao.getByField(fieldName,fieldValue);
    }

    @Override
    public int updateById(int id, Consult consult) {
        return consultDao.updateById(id,consult);
    }

    @Override
    public int deleteById(int id) {
        return consultDao.deleteById(id);
    }
}
