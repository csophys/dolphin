package org.dolphin.enums;

import lombok.Getter;

/**
 * Created by csophys on 16/2/19.
 */

@Getter
public enum ChannelTypeEnum {
    WEIXIN(10), PC(20), H5(30);

    private final int channelType;

    ChannelTypeEnum(int channelType) {
        this.channelType = channelType;
    }
}
