import java.sql.*;
import java.io.*;

public class DBCon {


    public static Connection getConnection(){
        String driverName="com.mysql.jdbc.Driver";  //数据库驱动
        String dbURL="jdbc:mysql://localhost:3306/exp2" +
                "?useUnicode=true&characterEncoding=utf-8&useSSL=false";  //数据库的url链接
        String userName="root";  //数据库用户名
        String userPwd="wmkljy";  //数据库的密码
        Connection dbConn = null;  //链接初始化为空
        try {
            Class.forName(driverName).newInstance();     //创建数据库驱动实例
            dbConn=DriverManager.getConnection(dbURL,userName,userPwd);  //创建与数据库的连接
         //   System.out.println("连接数据库成功");

            //创建一个静态Statement
            Statement stmt = dbConn.createStatement();

            //查询语句
            ResultSet rs = stmt.executeQuery("select * from Stuff where StuffNo = 3;");
//            ResultSetMetaData m = rs.getMetaData();  //得到返回结果集
//            int columns = m.getColumnCount();   //得到属性的数目
//            for(int i = 1; i <= columns; i++) {    //输出属性名
//                System.out.printf("%-20s",m.getColumnName(i));
//            }
//            System.out.println();
//            while(rs.next()){        //格式化输出返回的结果
//                for(int i = 1; i <= columns; i++)
//                {
//                    System.out.printf("%-20s",rs.getString(i));
//                }
//                System.out.println();
//            }
//            System.out.println();

            //插入语句
//            stmt.executeUpdate("insert into Stuff values('Bob',7,27,38000,2);");
//            ResultSet rs2 = stmt.executeQuery("select * from Stuff;");
//            ResultSetMetaData m2 = rs2.getMetaData();
//            int columns2 = m2.getColumnCount();
//            for(int i = 1; i <= columns2; i++) {
//                System.out.printf("%-20s",m2.getColumnName(i));
//            }
//            System.out.println();
//            while(rs2.next()) {
//                for (int i = 1; i <= columns2; i++) {
//                    System.out.printf("%-20s", rs2.getString(i));
//                }
//                System.out.println();
//            }
//            System.out.println();

            //删除语句
//            stmt.executeUpdate("delete from Stuff where StuffNo = 7;");
//            ResultSet rs3 = stmt.executeQuery("select * from Stuff;");
//            ResultSetMetaData m3 = rs3.getMetaData();
//            int columns3 = m3.getColumnCount();
//            for(int i = 1; i <= columns3; i++) {
//                System.out.printf("%-20s",m3.getColumnName(i));
//            }
//            System.out.println();
//            while(rs3.next()) {
//                for (int i = 1; i <= columns3; i++) {
//                    System.out.printf("%-20s", rs3.getString(i));
//                }
//                System.out.println();
//            }
//            System.out.println();

            //更新语句
//            stmt.executeUpdate("update Stuff set Salary = 70000 where StuffNo = 6;");
//            ResultSet rs4 = stmt.executeQuery("select * from Stuff;");
//            ResultSetMetaData m4 = rs4.getMetaData();
//            int columns4 = m4.getColumnCount();
//            for(int i = 1; i <= columns4; i++) {
//                System.out.printf("%-20s",m4.getColumnName(i));
//            }
//            System.out.println();
//            while(rs4.next()) {
//                for (int i = 1; i <= columns4; i++) {
//                    System.out.printf("%-20s", rs4.getString(i));
//                }
//                System.out.println();
//            }
//            System.out.println();

            //更新语句
//            stmt.executeUpdate("update Stuff set Age = 50 where StuffNo = 2;");
//            ResultSet rs5 = stmt.executeQuery("select * from Stuff;");
//            ResultSetMetaData m5 = rs5.getMetaData();
//            int columns5 = m5.getColumnCount();
//            for(int i = 1; i <= columns5; i++) {
//                System.out.printf("%-20s",m5.getColumnName(i));
//            }
//            System.out.println();
//            while(rs5.next()) {
//                for (int i = 1; i <= columns5; i++) {
//                    System.out.printf("%-20s", rs5.getString(i));
//                }
//                System.out.println();
//            }
//            System.out.println();

            //断开链接
            dbConn.close();

        } catch(Exception e) {
            e.printStackTrace();
       //     System.out.print("连接失败");
        }

        return dbConn;
    }

    public static void main(String[] args) {
        long start,end;
        start = System.currentTimeMillis();
        for(int i = 0; i < 2000; i++) {
            getConnection();
           // System.out.println("第 " + i + " 次连接");
        }
        end = System.currentTimeMillis();
        System.out.println("start time:" + start+ "; end time:" + end+ "; Run Time:" + (end - start) + "(ms)");
    }
}
