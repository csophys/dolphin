package ${package};

import ${entity};

import java.util.List;

/**
* Created by csophys with template on ${.now?date}.
*/
public interface ${entitySimple}Service {

    int insert(${entitySimple} entity);

    ${entitySimple} getById(int id);

    List<${entitySimple}> getByField(String fieldName,String fieldValue);

    int updateById(int id, ${entitySimple} entity);

    int deleteById(int id);
}
