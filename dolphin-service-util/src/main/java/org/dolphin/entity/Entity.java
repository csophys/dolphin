package org.dolphin.entity;

import lombok.Data;

import java.util.Date;

/**
 * Created by csophys on 16/2/19.
 */
@Data
public class Entity {
    private Integer id;
    private Date addTime;
    private Date updateTime;
}
