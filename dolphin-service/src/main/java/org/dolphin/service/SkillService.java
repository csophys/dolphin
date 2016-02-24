package org.dolphin.service;

import org.dolphin.entity.Skill;

import java.util.List;

/**
* Created by csophys with template on 2016-2-24.
*/
public interface SkillService {

    int insert(Skill entity);

    Skill getById(int id);

    List<Skill> getByField(String fieldName,String fieldValue);

    int updateById(int id, Skill entity);

    int deleteById(int id);
}
