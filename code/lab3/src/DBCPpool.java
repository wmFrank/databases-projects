import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import javax.sql.DataSource;
import java.sql.*;
import org.apache.commons.dbcp2.BasicDataSourceFactory;

class Pool implements Runnable{
    private static Properties properties = new Properties();
    private static DataSource dataSource;
    private int times = 2000;
    private long start,end;
    //加载DBCP配置文件
    static{
        try{
            FileInputStream is = new FileInputStream("config/dbcp.properties");
            properties.load(is);
        }catch(IOException e){
            e.printStackTrace();
        }

        try{
            dataSource = BasicDataSourceFactory.createDataSource(properties);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //从连接池中获取一个连接
    public static Connection getConnection(){
        Connection connection = null;
        try{
            connection = dataSource.getConnection();
//           System.out.println("连接数据库成功");

            //创建一个静态Statement
            Statement stmt = connection.createStatement();
            //查询语句
            ResultSet rs = stmt.executeQuery("select * from Stuff where StuffNo = 5;");
//            ResultSetMetaData m = rs.getMetaData();
//            int columns = m.getColumnCount();
//            for(int i = 1; i <= columns; i++) {
//                System.out.printf("%-20s",m.getColumnName(i));
//            }
//            System.out.println();
//            while(rs.next()){
//                for(int i = 1; i <= columns; i++)
//                {
//                    System.out.printf("%-20s",rs.getString(i));
//                }
//                System.out.println();
//            }
//            System.out.println();

        }catch(SQLException e){
            e.printStackTrace();
//            System.out.print("连接失败");
        }
        try {
            connection.setAutoCommit(false);
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    @Override
    public void run(){
        while(true) {
            if(times == 2000)
                start = System.currentTimeMillis();
            System.out.println(Thread.currentThread().getName() + " 第 " + (2000 - times) + " 次连接");
            getConnection();
            times--;
            if(times == 0) {
                end = System.currentTimeMillis();
                System.out.println("start time:" + start+ "; end time:" + end+ "; Run Time:" + (end - start) + "(ms)");
            }
            if(times <= 0)
                return;
        }
    }
}

public class DBCPpool{
    public static void main(String[] args) {
        Pool mypool = new Pool();
        new Thread(mypool,"连接1").start();
        new Thread(mypool,"连接2").start();
//        new Thread(mypool,"连接3").start();
//        new Thread(mypool,"连接4").start();
//        new Thread(mypool,"连接5").start();
//        new Thread(mypool,"连接6").start();
//        new Thread(mypool,"连接7").start();
//        new Thread(mypool,"连接8").start();
//        new Thread(mypool,"连接9").start();
//        new Thread(mypool,"连接10").start();
//        new Thread(mypool,"连接11").start();
//        new Thread(mypool,"连接12").start();
//        new Thread(mypool,"连接13").start();
//        new Thread(mypool,"连接14").start();
//        new Thread(mypool,"连接15").start();
//        new Thread(mypool,"连接16").start();
//        new Thread(mypool,"连接17").start();
//        new Thread(mypool,"连接18").start();
//        new Thread(mypool,"连接19").start();
//        new Thread(mypool,"连接20").start();
//        new Thread(mypool,"连接21").start();
//        new Thread(mypool,"连接22").start();
//        new Thread(mypool,"连接23").start();
//        new Thread(mypool,"连接24").start();
//        new Thread(mypool,"连接25").start();
//        new Thread(mypool,"连接26").start();
//        new Thread(mypool,"连接27").start();
//        new Thread(mypool,"连接28").start();
//        new Thread(mypool,"连接29").start();
//        new Thread(mypool,"连接30").start();
    }
}
