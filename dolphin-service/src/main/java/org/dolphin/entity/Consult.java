package org.dolphin.entity;

import lombok.Data;

/**
 * Created by csophys on 16/2/19.
 */
@Data
public class Consult extends Entity {
    private String Code;
    private String Name;
    private Integer ParentId;
    private Integer SkillId;
    private Integer IsDelete;
    private Integer Rank;
    private String IconUrl;
    private Integer ChannelType;
}
