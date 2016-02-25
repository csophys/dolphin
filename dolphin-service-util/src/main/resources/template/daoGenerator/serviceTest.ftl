package ${package};

import ${entity};
import org.dolphin.test.Base;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.BeanUtils;

import javax.annotation.Resource;


public class ${serviceSimple}Test extends Base {

    @Resource
    ${serviceSimple} service;

    @Test
    public void testGetById() throws Exception {
        int result = insert${entitySimple}();
        Assert.assertTrue(result > 0);
        Assert.assertTrue(service.getById(result) != null);
    }

    private ${entitySimple} build${entitySimple}() {
        ${entitySimple} entity = new ${entitySimple}();
        //TODO:not null field set
        return entity;
    }

    @Test
    public void insert() throws Exception {
        int id = insert${entitySimple}();
        Assert.assertTrue(id > 0);
    }

    private int insert${entitySimple}() {
        ${entitySimple} entity = build${entitySimple}();
        return service.insert(entity);
    }


    @Test
    public void testGetByField() throws Exception {
        int id = insert${entitySimple}();
        Assert.assertTrue(service.getByField("id", String.valueOf(id)).size() > 0);
    }

    @Test
    public void testUpdateById() throws Exception {
        ${entitySimple} entity = build${entitySimple}();
        int id = service.insert(entity);
        ${entitySimple} entityToUpdate = new ${entitySimple}();
        BeanUtils.copyProperties(entity, entityToUpdate);
        //field to update
        service.updateById(id, entityToUpdate);
        ${entitySimple} new${entitySimple} = service.getById(id);
        Assert.assertTrue(entity.getId().equals(new${entitySimple}.getId()));
    }

    @Test
    public void testDeleteById() throws Exception {
        int id = insert${entitySimple}();
        Assert.assertTrue(service.getById(id) != null);
        int rows = service.deleteById(id);
        Assert.assertTrue(rows > 0);
        Assert.assertTrue(service.getById(id) == null);
    }
}