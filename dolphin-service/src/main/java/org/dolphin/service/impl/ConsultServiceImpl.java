package org.dolphin.service.impl;

import org.dolphin.dao.ConsultDAO;
import org.dolphin.entity.Consult;
import org.dolphin.service.ConsultService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by csophys on 16/2/19.
 */
@Service
public class ConsultServiceImpl implements ConsultService {
    @Resource
    ConsultDAO consultDAO;

    @Override
    public int insert(Consult consult) {
        consultDAO.insert(consult);
        return consult.getId();
    }

    @Override
    public Consult getById(int id) {
        return consultDAO.getById(id);
    }

    @Override
    public List<Consult> getByField(String fieldName, String fieldValue) {
        return consultDAO.getByField(fieldName, fieldValue);
    }

    @Override
    public int updateById(int id, Consult consult) {
        return consultDAO.updateById(id,consult);
    }

    @Override
    public int deleteById(int id) {
        return consultDAO.deleteById(id);
    }
}
