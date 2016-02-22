package org.dolphin.entity;

import lombok.Data;

/**
 * Created by csophys on 16/2/19.
 */
@Data
public class Consult extends Entity {
    private String code;
    private String name;
    private Integer parentId;
    private Integer skillId;
    private Integer isDelete;
    private Integer rank;
    private String iconUrl;
    private Integer channelType;
}
