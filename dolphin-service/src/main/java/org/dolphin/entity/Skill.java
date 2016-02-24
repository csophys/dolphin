package org.dolphin.entity;

import lombok.Data;

/**
 * Created by csophys on 16/2/19.
 */
@Data
public class Skill extends Entity {
    private String Name;
    private Integer IsDelete;
    private Integer DeptId;
}
