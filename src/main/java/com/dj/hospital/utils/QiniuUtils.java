package com.dj.hospital.utils;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;

import java.io.InputStream;

/**
 * 七牛云文件管理工具类
 *
 * @author zhangzhikai
 * @date 2019年12月9日
 */
public class QiniuUtils {

    /**
     * 密钥AK
     */
    private static final String ACCESSKEY = "_BOfXAQkihueerajR068m0nOdqt8j8WW1_FSVL3y";

    /**
     * 密钥SK
     */
    private static final String SECRETKEY = "bC8bxFKnDT3Js-N267w3RzK18Rvm-PMf10owegFS";

    /**
     * 存储空间名称
     */
    private static final String BUCKET = "dongxu";

    /**
     * 下载链接
     */
    public static final String URL = "http://idv093d.qiniudns.com/";

    /**
     * 构造一个带指定 Region 对象的配置类
     */
    private static Configuration cfg = new Configuration(Region.region0());

    /**
     * 构造文件上传管理器
     */
    private static UploadManager uploadManager = new UploadManager(cfg);
    /**
     * 生成上传策略
     */
    private static Auth auth = Auth.create(ACCESSKEY, SECRETKEY);
    private static String upToken = auth.uploadToken(BUCKET);

    /**
     * 本地文件上传
     * @param fileName 文件名
     */
    public static void upload(String fileName) {
        try {
            //如果是Windows情况下，格式是 D:\\qiniu\\test.png
            String localFilePath = "E:\\upload\\" + fileName;
            uploadManager.put(localFilePath, fileName, upToken);
        } catch (QiniuException ex) {
            ex.printStackTrace();
            Response r = ex.response;
            System.err.println(r.toString());
            try {
                System.err.println(r.bodyString());
            } catch (QiniuException ex2) {
                //ignore
            }
        }
    }

    /**
     * 通过输入流上传至七牛云空间
     * @param inputStream 要上传的文件
     * @param fileName    文件名
     */
    public static void uploadByInputStream(InputStream inputStream, String fileName) {
        try {
            uploadManager.put(inputStream, fileName, upToken, null, null);
            System.out.println("上传成功");
        } catch (QiniuException ex) {
            System.err.println("上传失败");
            ex.printStackTrace();
            Response r = ex.response;
            System.err.println(r.toString());
            try {
                System.err.println(r.bodyString());
            } catch (QiniuException ex2) {
                // ignore
            }
        }
    }

    /**
     * 通过字节数组上传
     *
     * @param file     要上传的文件
     * @param fileName 文件名
     */
    public static void uploadByByteArray(byte[] file, String fileName) {
        try {
            uploadManager.put(file, fileName, upToken);
            System.out.println("上传成功");
        } catch (QiniuException ex) {
            System.err.println("上传失败");
            ex.printStackTrace();
            Response r = ex.response;
            System.err.println(r.toString());
            try {
                System.err.println(r.bodyString());
            } catch (QiniuException ex2) {
                //ignore
            }
        }
    }

    /**
     * 根据文件名删除bucket中的文件
     * @param fileName 文件名
     */
    public static void delFile(String fileName) {
        try {
            BucketManager bucketManager = new BucketManager(auth, cfg);
            bucketManager.delete(BUCKET, fileName);
            System.out.println("删除成功");
        } catch (QiniuException ex) {
            //如果遇到异常，说明删除失败
            System.out.println("删除失败");
            System.err.println(ex.code());
            System.err.println(ex.response.toString());
        }
    }

}
