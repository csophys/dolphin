package org.dolphin.entity;

import org.dolphin.codeGenerator.DaoCodeGenerate;

public class SkillTest {

    public static void main(String[] args) {
        DaoCodeGenerate.generateByJavaBean(Skill.class);
    }
}