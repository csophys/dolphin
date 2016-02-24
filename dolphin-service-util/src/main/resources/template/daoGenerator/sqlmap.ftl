<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${dao}">

    <insert id="insert" parameterType="${entity}" useGeneratedKeys="true" keyProperty="id">
        INSERT INTO ${entitySimple}
        (
        AddTime,
        <#list entityFields as field>
        ${field.name}<#if field_has_next>,</#if>
        </#list>
        )
        VALUES
        (
        now(),
        <#list entityFields as field>
        ${r'#{'}${field.name}}<#if field_has_next>,</#if>
        </#list>
        );
        <selectKey resultType="int" order="AFTER" keyProperty="id">
            SELECT LAST_INSERT_ID()
        </selectKey>
    </insert>

    <update id="update">
        UPDATE  ${entitySimple}
        SET
        <#list entityFields as field>
        ${field.name} = ${r'#{'}${field.name}}<#if field_has_next>,</#if>
        </#list>
        WHERE Id = ${r'#{id}'};
    </update>

</mapper>