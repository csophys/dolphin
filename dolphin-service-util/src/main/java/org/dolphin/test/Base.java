package org.dolphin.test;

import org.junit.runner.RunWith;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by csophys on 16/2/19.
 */
@RunWith(CustomizeJUnit4ClassRunner.class)
@ContextConfiguration("classpath:config/spring/appcontext-*.xml")
@Transactional
@ActiveProfiles("test")
public class Base {
}
