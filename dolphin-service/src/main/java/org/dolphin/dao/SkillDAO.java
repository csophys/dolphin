package org.dolphin.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.dolphin.entity.Skill;

import java.util.List;

/**
* Created by csophys with template on 2016-2-24.
*/
public interface SkillDAO{
    void insert(Skill entity);

    @Select("select * from Skill where id = #{id}")
    Skill getById(int id);

    int updateById(@Param("id") int id, @Param("entity") Skill consult);

    @Delete("delete from Skill where id=#{id}")
    int deleteById(int id);

    @Select("select * from Skill where ${fieldName} = #{fieldValue}")
    List<Skill> getByField(@Param("fieldName") String fieldName, @Param("fieldValue") String fieldValue);
}
