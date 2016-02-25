package ${package};

import ${dao};
import ${entity};
import ${service};
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
* Created by csophys with template on ${.now?date}.
*/
@Service
public class ${serviceSimple}Impl implements ${serviceSimple} {
    @Resource
    ${daoSimple} ${daoID};

    @Override
    public int insert(${entitySimple} entity) {
    ${daoID}.insert(entity);
        return entity.getId();
    }

    @Override
    public ${entitySimple} getById(int id) {
        return ${daoID}.getById(id);
    }

    @Override
    public List<${entitySimple}> getByField(String fieldName, String fieldValue) {
        return ${daoID}.getByField(fieldName,fieldValue);
    }

    @Override
    public int updateById(int id, ${entitySimple} entity) {
        return ${daoID}.updateById(id,entity);
    }

    @Override
    public int deleteById(int id) {
        return ${daoID}.deleteById(id);
    }
}
