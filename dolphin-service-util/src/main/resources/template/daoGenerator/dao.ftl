package ${package};

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import ${entity};

import java.util.List;

/**
* Created by csophys with template on ${.now?date}.
*/
public interface ${daoSimple}{
    void insert(${entitySimple} entity);

    @Select("select * from ${entitySimple} where id = ${r'#{id}'}")
    ${entitySimple} getById(int id);

    int updateById(@Param("id") int id, @Param("entity") ${entitySimple} consult);

    @Delete("delete from ${entitySimple} where id=${r'#{id}'}")
    int deleteById(int id);

    @Select("select * from ${entitySimple} where ${r'${fieldName}'} = ${r'#{fieldValue}'}")
    List<${entitySimple}> getByField(@Param("fieldName") String fieldName, @Param("fieldValue") String fieldValue);
}
