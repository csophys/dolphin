package org.dolphin.service;

import org.dolphin.entity.Consult;

import java.util.List;

/**
 * Created by csophys on 16/2/19.
 */
public interface ConsultService {

    int insert(Consult consult);

    Consult getById(int id);

    List<Consult> getByField(String fieldName,String fieldValue);

    int updateById(int id, Consult consult);

    int deleteById(int id);
}
