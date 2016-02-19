package org.dolphin.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.dolphin.entity.Consult;

/**
 * Created by csophys on 16/2/19.
 */
public interface ConsultDao {
    void insert(Consult consult);

    @Select("select * from Consult where id = #{id}")
    Consult getById(int id);

    int updateById(@Param("id") int id, @Param("consult") Consult consult);
}
