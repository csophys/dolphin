package org.dolphin.service;

import org.dolphin.entity.Consult;
import org.dolphin.enums.ChannelTypeEnum;
import org.dolphin.test.Base;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.test.annotation.Rollback;

import javax.annotation.Resource;


public class ConsultServiceTest extends Base {

    @Resource
    ConsultService consultService;

    @Test
    public void testGetById() throws Exception {
        Consult consult = buildConsult();
        int result = consultService.insert(consult);
        Assert.assertTrue(result > 0);
        Assert.assertTrue(consultService.getById(result) != null);
    }

    private Consult buildConsult() {
        Consult consult = new Consult();
        consult.setName("在线某咨询分类");
        consult.setChannelType(ChannelTypeEnum.H5.getChannelType());
        consult.setCode("csophys");
        consult.setSkillId(2);
        return consult;
    }

    @Test
    public void insert() throws Exception {
        Consult consult = buildConsult();
        int id = consultService.insert(consult);
        Assert.assertTrue(id > 0);
    }


    @Test
    public void testGetByField() throws Exception {

    }

    @Test @Rollback(false)
    public void testUpdateById() throws Exception {
        Consult consult = buildConsult();
        int id = consultService.insert(consult);
        Consult consultToUpdate = new Consult();
        BeanUtils.copyProperties(consult,consultToUpdate);
        consultToUpdate.setName("changedCsophys");
        consultService.updateById(id, consultToUpdate);
        Consult newConsult = consultService.getById(id);
        Assert.assertTrue(consult.getId().equals(newConsult.getId()));
        Assert.assertTrue(consult.getSkillId().equals(newConsult.getSkillId()));
        Assert.assertFalse(consult.getName().equals(newConsult.getName()));
    }

    @Test
    public void testDeleteById() throws Exception {

    }
}