package org.dolphin.codeGenerator;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.log4j.Logger;

import java.io.*;
import java.net.URL;
import java.util.HashMap;

/**
 * Created by csophys on 16/1/29.
 */
public class DaoCodeGenerate {
    public static final String DATA_FTL = "/data/ftl";
    public static final String CONFIG_FTL = "/template/daoGenerator";
    private static Logger logger = Logger.getLogger(DaoCodeGenerate.class);

    private enum classType {
        DAO, SERVICE, DAO_TEST, SQLMAP, SERVICE_IMPL
    }

    public static void generateByJavaBean(Class clazz) {
        //获取当前文件目录
        File file = getCurrentDirectory(clazz);

        //获取源文件目录
        File sourceDirectory = getSourceDirectory(file);

        logger.debug("获取的源代码目录path:" + sourceDirectory.getAbsolutePath());

        //freemarker配置设置
        Configuration configuration = getFreeMarkerConfiguration(clazz);

        //生成dao
        generateDao(clazz, file, configuration);
        logger.info("dao类生成成功！");

        //生成sqlmap
        generateSqlmap(clazz, sourceDirectory, configuration);
        logger.info("ibatis sqlmap 生成成功!");

        //生成service
        generateService(clazz, file, configuration);
        //生成serviceImpl
        //生成test
        generateDaoTest(clazz, sourceDirectory, configuration);
        logger.info("dao test生成成功！");

        //生成service test

    }

    private static void generateService(Class clazz, File file, Configuration configuration) {
        String serviceFilePath = file.getParent() + "/" + classType.SERVICE.toString().toLowerCase() + "/" + clazz.getSimpleName() + "Service.java";
        generateFileByTemplate(clazz, configuration, serviceFilePath, classType.SERVICE);
    }

    private static void generateFileByTemplate(Class clazz, Configuration configuration, String filePath, classType classType) {
        File file = new File(filePath);
        try {
            if (file.exists()) {
                logger.warn(classType + "类已经存在");
                return;
            }

            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }
            file.createNewFile();
            Template template = null;
            try {
                template = configuration.getTemplate(underlineToHump(classType.toString().toLowerCase()) + ".ftl");
            } catch (IOException e) {
                e.printStackTrace();
            }
            HashMap<Object, Object> map = new HashMap<Object, Object>();
            map.put("package", getPackageName(clazz, classType));
            map.put("entitySimple", clazz.getSimpleName());
            map.put("entity", clazz.getName());
            map.put("daoSimple", getDaoSimpleName(clazz));
            map.put("entityID", getEntityID(clazz));
            map.put("daoID", getDaoID(clazz));
            map.put("dao", getPackageName(clazz, classType.DAO) + "." + getDaoSimpleName(clazz));
            map.put("entityFields", clazz.getDeclaredFields());
            Writer writer = new OutputStreamWriter(new FileOutputStream(file));
            try {
                template.process(map, writer);
                writer.flush();
            } catch (TemplateException e) {
                e.printStackTrace();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void generateDaoTest(Class clazz, File sourceDirectory, Configuration configuration) {
        File testSourceDirectory = getTestSourceDirectory(sourceDirectory);
        String daoTestPath = testSourceDirectory + "/" + getPackageName(clazz, classType.DAO).replace(".", "/") + "/" + getDaoSimpleName(clazz) + "Test.java";
        generateFileByTemplate(clazz, configuration, daoTestPath, classType.DAO_TEST);
    }

    private static File getTestSourceDirectory(File sourceDirectory) {
        return new File(sourceDirectory.getParentFile().getParentFile() + "/test/java");
    }

    private static void generateSqlmap(Class clazz, File sourceDirectory, Configuration configuration) {
        String sqlmapPath = getResourceDirectory(sourceDirectory) + "/config/mybatis/sqlmap/" + clazz.getSimpleName() + ".xml";
        generateFileByTemplate(clazz,configuration,sqlmapPath,classType.SQLMAP);
    }


    private static String getEntityID(Class clazz) {
        return clazz.getSimpleName().substring(0, 1).toLowerCase() + clazz.getSimpleName().substring(1);
    }


    private static String getDaoID(Class clazz) {
        return getDaoSimpleName(clazz).substring(0, 1).toLowerCase() + getDaoSimpleName(clazz).substring(1);
    }

    private static void generateDao(Class clazz, File file, Configuration configuration) {
        String daoFilePath = file.getParent() + "/" + classType.DAO.toString().toLowerCase() + "/" + clazz.getSimpleName() + classType.DAO + ".java";
        generateFileByTemplate(clazz, configuration, daoFilePath, classType.DAO);
    }

    private static String getPackageName(Class clazz, classType classType) {
        String originPackage = "\\.[a-zA-Z]*\\." + clazz.getSimpleName();
        return clazz.getName().replaceAll(originPackage, "." + underlineToHump(classType.toString().toLowerCase()));
    }

    private static String getDaoSimpleName(Class clazz) {
        return clazz.getSimpleName() + classType.DAO;
    }

    private static Configuration getFreeMarkerConfiguration(Class clazz) {
        Configuration configuration = new Configuration();
        try {
            File file = getTempFTLDirectory(clazz);
            configuration.setDirectoryForTemplateLoading(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return configuration;
    }

    private static File getTempFTLDirectory(Class clazz) throws IOException {
        //1.创建临时目录
        File file = new File(DATA_FTL);
        if (!file.exists() && !file.isDirectory()) {
            file.mkdir();
            logger.info("成功创建目录" + DATA_FTL);
        }
        //2.创建ftl模板
        String daofileName = "/dao.ftl";
        createTempFTLFile(clazz, daofileName);
        logger.info("成功创建文件" + DATA_FTL + daofileName);


        String serviceFileName = "/service.ftl";
        createTempFTLFile(clazz, serviceFileName);
        logger.info("成功创建文件" + DATA_FTL + serviceFileName);

        String serviceImplFileName = "/serviceImpl.ftl";
        createTempFTLFile(clazz, serviceImplFileName);
        logger.info("成功创建文件" + DATA_FTL + serviceImplFileName);


        String serviceTestFileName = "/serviceTest.ftl";
        createTempFTLFile(clazz, serviceTestFileName);
        logger.info("成功创建文件" + DATA_FTL + serviceTestFileName);

        String salmapFileName = "/sqlmap.ftl";
        createTempFTLFile(clazz, salmapFileName);
        logger.info("成功创建文件" + DATA_FTL + salmapFileName);
        return file;
    }

    private static void createTempFTLFile(Class clazz, String fileName) throws IOException {
        File daoFile = new File(DATA_FTL + fileName);
        if (!daoFile.exists() && !daoFile.isFile()) {
            daoFile.createNewFile();
        } else {
            daoFile.delete();
            daoFile.createNewFile();
        }
        InputStream inputStream = clazz.getResourceAsStream(CONFIG_FTL + fileName);

        FileOutputStream fileOutputStream = new FileOutputStream(daoFile);

        int bytesRead;
        int bufferSize = 8192;
        byte[] buffer = new byte[bufferSize];
        while ((bytesRead = inputStream.read(buffer, 0, bufferSize)) != -1) {
            fileOutputStream.write(buffer, 0, bytesRead);
        }
        fileOutputStream.close();
        inputStream.close();
    }

    private static String getResourceDirectory(File sourceDirectory) {
        return sourceDirectory.getParentFile() + "/resources";
    }

    private static File getSourceDirectory(File file) {
        String absolutePath = file.getAbsolutePath();
        /**
         * jar 中的目录结构不一样，需要特别处理
         */
        return new File(absolutePath.substring(0, absolutePath.lastIndexOf("java")) + "java");

    }

    private static File getCurrentDirectory(Class clazz) {
        /**
         * class.getName 获取类名（包含包）
         */
        URL url = clazz.getClassLoader().getResource(clazz.getName().replace(".", "/") + ".class");
        String currentDirectoryPath = url.toString().replace("file:", "").replace("target/classes", "src/main/java").replace("/" + clazz.getSimpleName() + ".class", "").replace("%20", " ");
        return new File(currentDirectoryPath);
    }

    private static String underlineToHump(String symbol) {
        int index = symbol.indexOf("_");
        if (index != -1) {
            //_不为最后一个字符
            if (symbol.length() > index + 1) {
                String suffix = symbol.charAt(index + 1) + "";
                String toBeReplace = "_" + suffix;
                return underlineToHump(symbol.replaceFirst(toBeReplace, suffix.toUpperCase()));
            }//_为最后一个字符
            else {
                return symbol.substring(0, index);
            }
        } else {
            return symbol;
        }
    }
}
